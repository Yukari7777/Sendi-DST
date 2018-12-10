local TheInput = GLOBAL.TheInput
local Profile = GLOBAL.Profile
local TimeEvent = GLOBAL.TimeEvent
local ACTIONS = GLOBAL.ACTIONS
local State = GLOBAL.State
local TheWorld = GLOBAL.TheWorld
local BufferedAction = GLOBAL.BufferedAction
local ActionHandler = GLOBAL.ActionHandler
local EventHandler = GLOBAL.EventHandler
local FRAMES = GLOBAL.FRAMES


function rapier(inst)
	inst:PushEvent("onrapier")
end
AddModRPCHandler("sendi", "rapier", rapier)

local function ForceStopHeavyLifting(inst) 
    if inst.components.inventory:IsHeavyLifting() then
        inst.components.inventory:DropItem(
            inst.components.inventory:Unequip(EQUIPSLOTS.BODY),
            true,
            true
        )
    end
end

local function OnStartSkillGeneral(inst)
	inst:AddTag("inskill")
	inst.components.locomotor:Stop()
	inst.components.locomotor:Clear()
    inst:ClearBufferedAction()
	ForceStopHeavyLifting(inst)
	if inst.components.playercontroller ~= nil then
		inst.components.playercontroller:RemotePausePrediction()
		inst.components.playercontroller:Enable(false)
	end
	inst:PerformBufferedAction()
	inst.IsMovementPrediction = Profile:GetMovementPredictionEnabled()
	inst:EnableMovementPrediction(false)
end

local function OnFinishSkillGeneral(inst)
	inst:RemoveTag("inskill")
	inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
	if inst.components.playercontroller ~= nil then	
		inst.components.playercontroller:Enable(true)
	end
	inst:EnableMovementPrediction(inst.IsMovementPrediction ~= nil and inst.IsMovementPrediction or true)
end

local function GetPlayerAngle(inst)
	local playerpos = inst:GetPosition()
    local mousepos = TheInput:GetWorldPosition()
    local xdiff = mousepos.x - playerpos.x
    local zdiff = mousepos.z - playerpos.z
    local angle = -math.atan2(zdiff, xdiff) + (90 / 180 * math.pi)
end

local function nullfn()  -- AddAction's third argument type must be function. And I won't use action.fn at all.
	return true 
end

local RAPIER = AddAction("RAPIER", "rapier", nullfn)

local rapier_server = State { 
	name = "rapier",
	tags = { "busy", "doing", "skill", "pausepredict", "aoe", "nointerrupt", "nomorph"},

	onenter = function(inst)
		OnStartSkillGeneral(inst)
		inst.sg:SetTimeout(1)
		inst.AnimState:PlayAnimation("whip_pre")
        inst.AnimState:PushAnimation("whip", false)

        inst.sg.statemem.angle = GetPlayerAngle(inst)
		inst.components.sendiskill:OnStartRapier(inst, inst.sg.statemem.angle)
	end,

	timeline =
	{
		TimeEvent(4 * FRAMES, function(inst)
			inst.Physics:SetMotorVel(10, 0, 0)
			inst.components.sendiskill.shouldcharge = true
			inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt") -- 트리가드 때리는 소리
		end),
		TimeEvent(30 * FRAMES, function(inst)
			inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
			inst.components.sendiskill.shouldcharge = false
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
		inst.Physics:Stop()
        inst.Physics:SetMotorVel(0, 0, 0)
		inst.components.sendiskill:OnFinishRapier(inst)
		OnFinishSkillGeneral(inst)
	end,
	
	onexit = function(inst)	
		inst.components.sendiskill:OnFinishRapier(inst)
		OnFinishSkillGeneral(inst)
	end,
}

local rapier_client = State {
	name = "rapier",
	tags = { "doing", "attack", "skill" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
        inst.components.locomotor:Clear()
		inst.entity:FlattenMovementPrediction()
		inst.AnimState:PlayAnimation("whip_pre")
		inst.AnimState:PushAnimation("whip", false)
		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(1)
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

AddStategraphState("wilson", rapier_server)
AddStategraphState("wilson_client", rapier_client)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.RAPIER, "rapier"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.RAPIER, "rapier"))