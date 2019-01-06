local TheInput = GLOBAL.TheInput
local Profile = GLOBAL.Profile
local TimeEvent = GLOBAL.TimeEvent
local ACTIONS = GLOBAL.ACTIONS
local State = GLOBAL.State
local TheWorld = GLOBAL.TheWorld
local BufferedAction = GLOBAL.BufferedAction
local ActionHandler = GLOBAL.ActionHandler
local EventHandler = GLOBAL.EventHandler
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local FRAMES = GLOBAL.FRAMES

GLOBAL.IsPreemptiveEnemy = function(inst, target)
	-- 트리가드를 제외한 몬스터
	-- PVP가 켜져있을경우 플레이어 아닐경우 제외
	-- 친구가 제외
	-- 자기자신이 제외
	-- 날 공격하려 하는(타겟으로 삼은) 경우 무조건
	return (target:HasTag("monster") or (target:HasTag("epic") and not tarzget:HasTag("leif"))) and not (target:HasTag("companion") and (TheNet:GetPtargetPEnabled() or not target:HasTag("player"))) or (target.components.combat ~= nil and target.components.combat.target == inst) and target ~= inst
end

local IsPreemptiveEnemy = GLOBAL.IsPreemptiveEnemy

local function ForceStopHeavyLifting(inst) 
    if inst.components.inventory:IsHeavyLifting() then
        inst.components.inventory:DropItem(inst.components.inventory:Unequip(EQUIPSLOTS.BODY), true, true)
    end
end

local SKILL_RADIUS_DEFAULT = 6
local function GetPositionToClosestEnemy(inst, range)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, range or SKILL_RADIUS_DEFAULT, { "_combat" } ) -- See entityreplica.lua (for _combat tag usage)
	local target, tx, ty, tz

	for k, v in pairs(ents) do
		-- 적 타겟순서
		-- 1) 가장 가까운 보스(단, 트리가드 제외)
		-- 2) 나를 타겟한 적.
		-- 3) 선공 할만한 적
		if v:HasTag("epic") and not v:HasTag("leif") then
			target = v; break
		elseif v ~= inst and v.components.combat ~= nil and v.components.combat.target == inst then
			target = v; break
		elseif IsPreemptiveEnemy(inst, v) then
			target = v; break
		end
	end

	if target ~= nil then
		tx, ty, tz = target.Transform:GetWorldPosition()
	end

	return tx, ty, tz
end

local function OnStartSkillGeneral(inst, shouldstop)
	inst:AddTag("inskill")
	inst.components.locomotor:Stop()
	inst.components.locomotor:Clear()
    inst:ClearBufferedAction()
	ForceStopHeavyLifting(inst)
	if shouldstop and inst.components.playercontroller ~= nil then
		inst.components.playercontroller:RemotePausePrediction()
		inst.components.playercontroller:Enable(false)
	end
	inst:PerformBufferedAction()
end

local function OnFinishSkillGeneral(inst)
	inst:RemoveTag("inskill")
	if inst.components.playercontroller ~= nil then	
		inst.components.playercontroller:Enable(true)
	end
end

local function nullfn()  -- AddAction's third argument type must be function. And I won't use action.fn at all.
	return true 
end

local function AddSkill(skillname, SgS, SgC)
	-- This is Ctor to make key-press-to-action.
	-- Does Anyone want to use this function, feel free to use it
	-- and don't forget to rename ModRPCHandler's namespace and copy nullfn.
	local upperskillname = skillname:upper()

	AddAction(upperskillname, skillname, nullfn)
	AddModRPCHandler("sendi", skillname, function(inst) 
		inst:PushEvent("on"..skillname) -- See sendi_classified how to excute actions via PushEvent.
	end)

	AddStategraphState("wilson", SgS) -- Client Stategraph
	AddStategraphState("wilson_client", SgC) -- Server Stategraph
	AddStategraphActionHandler("wilson", ActionHandler(ACTIONS[upperskillname], skillname))
	AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS[upperskillname], skillname))
end

--------------------------------------------------------------------------------------------------------------------
local rapier_SgS = State { 
	name = "rapier",
	tags = { "busy", "doing", "skill", "pausepredict", "aoe", "nointerrupt", "nomorph"},

	onenter = function(inst)
		OnStartSkillGeneral(inst, true)
		local x, y, z = GetPositionToClosestEnemy(inst)
		if x ~= nil then inst:ForceFacePoint(x, y, z) end
		inst.sg:SetTimeout(11 * FRAMES)
		inst.AnimState:PlayAnimation("whip_pre") -- YUKARI : TODO. 커스텀 애니메이션. 프레임 수 7
        inst.AnimState:PushAnimation("whip", false)

        inst.sg.statemem.angle = inst.Transform:GetRotation() -- 가까이에 적이 있을경우 적에게, 없으면 바라보던 방향으로 돌진
		inst.components.sendiskill:OnStartRapier(inst, inst.sg.statemem.angle)
	end,

	timeline =
	{
		TimeEvent(4 * FRAMES, function(inst)
			inst.components.sendiskill:Explode(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/swipe") -- 좀더 날카롭게 찌르는 소리 같은거 없나?
		end),
	},
	
	events = {
        EventHandler("animover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle", true)
			end
		end),
    },
	
	ontimeout = function(inst)
		inst.components.sendiskill:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
	
	onexit = function(inst)	
		inst.components.sendiskill:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
}

local rapier_SgC = State {
	name = "rapier",
	tags = { "doing", "attack", "skill" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
        inst.components.locomotor:Clear()
		inst.entity:FlattenMovementPrediction()
		inst.AnimState:PlayAnimation("whip_pre")
		inst.AnimState:PushAnimation("whip", false)
		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(11 * FRAMES)
	end,
	
	onupdate = function(inst)
		if inst.bufferedaction == nil then
			inst.sg:GoToState("idle", true)
		end
	end,

	ontimeout = function(inst)
		inst:ClearBufferedAction()
		inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
	end,
	
	onexit = function(inst)	
		inst.entity:SetIsPredictingMovement(true)
	end,
}

AddSkill("rapier", rapier_SgS, rapier_SgC)


local igniarun_SgS = State { 
	name = "igniarun",
	tags = { "busy", "doing", "skill", "pausepredict", "nomorph" },

	onenter = function(inst)
		OnStartSkillGeneral(inst, true)
		inst.sg:SetTimeout(13 * FRAMES)
        inst.AnimState:PlayAnimation("jumpout")

		inst.components.sendiskill:OnStartIgniaRun(inst)
	end,

	timeline =
	{
		TimeEvent(6 * FRAMES, function(inst)
			inst.components.health:SetInvincible(false)
		end),
		TimeEvent(13 * FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
		end),
		
	},
	
	events = {
        EventHandler("animover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle", true)
			end
		end),
    },
	
	ontimeout = function(inst)
		inst.components.sendiskill:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
	
	onexit = function(inst)	
		inst.components.sendiskill:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
}

local igniarun_SgC = State {
	name = "igniarun",
	tags = { "doing", "skill" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
        inst.components.locomotor:Clear()
		inst.entity:FlattenMovementPrediction()
		inst.AnimState:PlayAnimation("jumpout")

		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(11 * FRAMES)
	end,
	
	onupdate = function(inst)
		if inst.bufferedaction == nil then
			inst.sg:GoToState("idle", true)
		end
	end,

	ontimeout = function(inst)
		inst:ClearBufferedAction()
		inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
	end,
	
	onexit = function(inst)	
		inst.entity:SetIsPredictingMovement(true)
	end,
}

AddSkill("igniarun", igniarun_SgS, igniarun_SgC)