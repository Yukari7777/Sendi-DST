local assets =
{
    Asset("ANIM", "anim/aos_seed_black.zip"),
	Asset("ATLAS", "images/inventoryimages/aos_seed_black.xml"),
}

local function moon_oneaten(inst, eater)

    if eater.wormlight then
        eater.wormlight.components.spell.lifetime = 0
        eater.wormlight.components.spell:ResumeSpell()
    else
        local light = SpawnPrefab("wormlight_light")
        light.components.spell:SetTarget(eater)
        if not light.components.spell.target then
            light:Remove()
        end
        light.components.spell:StartSpell()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("aos_seed_black")
    inst.AnimState:SetBuild("aos_seed_black")
    inst.AnimState:PlayAnimation("idle", true)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddTag("cattoy")
	
    inst:AddComponent("inspectable")
	inst:AddComponent("tradable")
	
	inst:AddComponent("edible")
	inst.components.edible.hungervalue = (0)
	inst.components.edible.healthvalue = (0)
	inst.components.edible.sanityvalue = (-20)
	inst.components.edible:SetOnEatenFn(moon_oneaten)
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(1440)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "aos_seed10"

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/aos_seed_black.xml"
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	MakeHauntableLaunch(inst)

    return inst
end

local function light_resume(inst, time)
    local percent = time/inst.components.spell.duration
    local var = inst.components.spell.variables
    if percent and time > 0 then
        inst.components.lighttweener:StartTween(inst.light, Lerp(0, var.radius, percent), 0.8, 0.5, {1,1,1}, 0)
        inst.components.lighttweener:StartTween(nil, 0, nil, nil, nil, time)
    end
end

local function light_onsave(inst, data)
    data.timealive = inst:GetTimeAlive()
end

local function light_onload(inst, data)
    if data and data.timealive then
        light_resume(inst, data.timealive)
    end
end

local function light_spellfn(inst, target, variables)
    if target then
        inst.Transform:SetPosition(target:GetPosition():Get())
    end
end

local function light_start(inst)
    local spell = inst.components.spell
    inst.components.lighttweener:StartTween(inst.light, spell.variables.radius, 0.8, 0.5, {169/255,231/255,245/255}, 0)
    inst.components.lighttweener:StartTween(nil, 0, nil, nil, nil, spell.duration)
end

local function light_ontarget(inst, target)
    if not target then return end
    target.wormlight = inst
    target:AddTag(inst.components.spell.spellname)
    target.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
end

local function light_onfinish(inst)
    if not inst.components.spell.target then
        return
    end
    inst.components.spell.target.wormlight = nil
    inst.components.spell.target.AnimState:ClearBloomEffectHandle()
end

local light_variables = {
    radius = 1,
}

local function lightfn()

    local inst = CreateEntity()
    inst.entity:AddTransform()

    inst:AddComponent("lighttweener")
    inst.light = inst.entity:AddLight()
    inst.light:Enable(true)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    local spell = inst:AddComponent("spell")
    inst.components.spell.spellname = "wormlight"
    inst.components.spell:SetVariables(light_variables)
    inst.components.spell.duration = 10
    inst.components.spell.ontargetfn = light_ontarget
    inst.components.spell.onstartfn = light_start
    inst.components.spell.onfinishfn = light_onfinish
    inst.components.spell.fn = light_spellfn
    inst.components.spell.resumefn = light_resume
    inst.components.spell.removeonfinish = true

    return inst
end

return Prefab("common/inventory/aos_seed_black", fn, assets)
