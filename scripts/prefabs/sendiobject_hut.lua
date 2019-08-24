require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/sendiobject_hut.zip"),
	Asset("ATLAS", "images/inventoryimages/sendiobject_hut.xml"),
}

-----------------------------------------------------------------------

local function sendiPlaySleepLoopSoundTask(inst, stopfn)
    inst.SoundEmitter:PlaySound("dontstarve/common/tent_sleep")
end

local function sendistopsleepsound(inst)
    if inst.sleep_tasks ~= nil then
        for i, v in ipairs(inst.sleep_tasks) do
            v:Cancel()
        end
        inst.sleep_tasks = nil
    end
end

local function startsleepsound(inst, len)
    sendistopsleepsound(inst)
    inst.sleep_tasks =
    {
        inst:DoPeriodicTask(len, sendiPlaySleepLoopSoundTask, 33 * FRAMES),
        inst:DoPeriodicTask(len, sendiPlaySleepLoopSoundTask, 47 * FRAMES),
    }
end
-----------------------------------------------------------------------

local function ontakefuel(inst)
	inst.components.fueled:DoDelta(1000)
    inst.components.talker:Say((math.floor(inst.components.fueled.currentfuel/100)).."/"..(math.floor(inst.components.fueled.maxfuel/100)))
	local pos = Vector3(inst.Transform:GetWorldPosition())--[[;pos.y = pos.y + 2--]]
	SpawnPrefab("poopcloud").Transform:SetPosition(pos:Get())
end

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        sendistopsleepsound(inst)
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", true)
    end
    if inst.components.sleepingbag ~= nil and inst.components.sleepingbag.sleeper ~= nil then
        inst.components.sleepingbag:DoWakeUp()
    end
end

local function onfinishedsound(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_twirl")
end

local function onfinished(inst)
    if not inst:HasTag("burnt") then
        sendistopsleepsound(inst)
        inst:ListenForEvent("animover", inst.Remove)
        inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_pre")
        inst.persists = false
        inst:DoTaskInTime(16 * FRAMES, onfinishedsound)
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/tent_craft")
end

local function onignite(inst)
    inst.components.sleepingbag:DoWakeUp()
end

local function wakeuptest(inst, phase)
    if phase ~= inst.sleep_phase then
        inst.components.sleepingbag:DoWakeUp()
	end
end

local function onwake(inst, sleeper, nostatechange)
    if inst.sleeptask ~= nil then
        inst.sleeptask:Cancel()
        inst.sleeptask = nil
    end
	
	if inst.sleeptask_fx ~= nil then
		inst.sleeptask_fx:Cancel()
		inst.sleeptask_fx = nil
	end

	inst:StopWatchingWorldState("phase", wakeuptest)
    sleeper:RemoveEventCallback("onignite", onignite, inst)

    if not nostatechange then
        if sleeper.sg:HasStateTag("tent") then
            sleeper.sg.statemem.iswaking = true
        end
        sleeper.sg:GoToState("wakeup")
    end

    if inst.sleep_anim ~= nil then
        inst.AnimState:PushAnimation("idle", true)
        sendistopsleepsound(inst)
    end

    inst.components.fueled:DoDelta(-100)
	inst.components.talker:Say((math.floor(inst.components.fueled.currentfuel/100)).."/"..(math.floor(inst.components.fueled.maxfuel/100)))
end

local function onsleeptick(inst, sleeper)
    local isstarving = sleeper.components.beaverness ~= nil and sleeper.components.beaverness:IsStarving()

    if sleeper.components.hunger ~= nil then
        sleeper.components.hunger:DoDelta(inst.hunger_tick, true, true)
        isstarving = sleeper.components.hunger:IsStarving()
    end

    if sleeper.components.sanity ~= nil and sleeper.components.sanity:GetPercentWithPenalty() < 1 then
        sleeper.components.sanity:DoDelta(TUNING.SLEEP_SANITY_PER_TICK, true)
    end

    if not isstarving and sleeper.components.health ~= nil then
        sleeper.components.health:DoDelta(TUNING.SLEEP_HEALTH_PER_TICK * 2, true, inst.prefab, true)
    end

    if sleeper.components.temperature ~= nil then
        if inst.is_cooling then
            if sleeper.components.temperature:GetCurrent() > TUNING.SLEEP_TARGET_TEMP_TENT then
                sleeper.components.temperature:SetTemperature(sleeper.components.temperature:GetCurrent() - TUNING.SLEEP_TEMP_PER_TICK)
            end
        elseif sleeper.components.temperature:GetCurrent() < TUNING.SLEEP_TARGET_TEMP_TENT then
            sleeper.components.temperature:SetTemperature(sleeper.components.temperature:GetCurrent() + TUNING.SLEEP_TEMP_PER_TICK)
        end
    end

    if isstarving then
        inst.components.sleepingbag:DoWakeUp()
    end
end

local function onsleep(inst, sleeper)
	if inst.components.fueled.currentfuel >= 100 then
	
		inst:StopWatchingWorldState("phase", wakeuptest)
		sleeper:ListenForEvent("onignite", onignite, inst)

		if inst.sleep_anim ~= nil then
			inst.AnimState:PlayAnimation(inst.sleep_anim, true)
			startsleepsound(inst, inst.AnimState:GetCurrentAnimationLength())
		end

		if inst.sleeptask ~= nil then
			inst.sleeptask:Cancel()
		end
		
		if inst.sleeptask_fx ~= nil then
			inst.sleeptask_fx:Cancel()
		end
		
		local fx = SpawnPrefab("green_leaves")
		fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
		
		inst.sleeptask_fx = inst:DoPeriodicTask(2.5, function() local fx = SpawnPrefab("green_leaves");fx.Transform:SetPosition(inst.Transform:GetWorldPosition()) end)
		
		inst.sleeptask = inst:DoPeriodicTask(TUNING.SLEEP_TICK_PERIOD, onsleeptick, nil, sleeper)
		
	else
		inst.components.talker:Say((math.floor(inst.components.fueled.currentfuel/100)).."/"..(math.floor(inst.components.fueled.maxfuel/100)))
	end
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize(6,4)
	
	inst.MiniMapEntity:SetIcon("sendiobject_hut.tex")
	
	MakeObstaclePhysics(inst, 1)

    inst.AnimState:SetBank("sendiobject_hut")
    inst.AnimState:SetBuild("sendiobject_hut")
    inst.AnimState:PlayAnimation("idle")
	
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 28
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0, -600, 0)
	inst.components.talker:MakeChatter()
	
    inst:AddTag("tent")
	inst:AddTag("house")
    inst:AddTag("structure")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.sleep_phase = "night"
	inst.sleep_anim = "sleep_loop"
	inst.hunger_tick = TUNING.SLEEP_HUNGER_PER_TICK / 3

    inst:AddComponent("inspectable")
	
    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(20)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "BURNABLE"
    inst.components.fueled:InitializeFuelLevel(10000)
	inst.components.fueled.accepting = true
	inst.components.fueled:SetTakeFuelFn(ontakefuel)
	inst.components.fueled:StopConsuming()
	
    inst:AddComponent("sleepingbag")
    inst.components.sleepingbag.onsleep = onsleep
    inst.components.sleepingbag.onwake = onwake
    inst.components.sleepingbag.dryingrate = math.max(0, -TUNING.SLEEP_WETNESS_PER_TICK / TUNING.SLEEP_TICK_PERIOD)

	inst:ListenForEvent("onbuilt", onbuilt)
	
	MakeHauntableWork(inst)

    return inst
end

return Prefab("common/objects/sendiobject_hut", fn, assets),
MakePlacer("common/sendiobject_hut_placer", "sendiobject_hut", "sendiobject_hut", "idle")