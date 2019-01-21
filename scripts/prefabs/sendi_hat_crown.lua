local assets={  
    Asset("ANIM", "anim/sendi_hat_crown.zip"),
    Asset("ANIM", "anim/sendi_hat_crown_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/sendi_hat_crown.xml"),
    Asset("IMAGE", "images/inventoryimages/sendi_hat_crown.tex"),
}

local prefabs = { }

local function sendi_hat_crown_disable(inst)
    if inst.updatetask ~= nil then
        inst.updatetask:Cancel()
        inst.updatetask = nil
    end
end

local function pigqueen_update( inst )  --돼지 팔로워 
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner ~= nil and inst.components.inventoryitem.owner.components.leader ~= nil and inst.components.inventoryitem.owner

    local x,y,z = owner.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, { "pig" }, { "werepig" })
    for k,v in pairs(ents) do
        if v.components.follower ~= nil and not v.components.follower.leader ~= nil and not owner.components.leader:IsFollower(v) and owner.components.leader.numfollowers < 10 then
            owner.components.leader:AddFollower(v)
        end
    end
		
    for k,v in pairs(owner.components.leader.followers) do
        if k:HasTag("pig") and k.components.follower ~= nil then
            k.components.follower:AddLoyaltyTime(2)
        end
    end	
end

local function sendi_hat_crown_enable(inst) --돼지 팔로워 
    inst.updatetask = inst:DoPeriodicTask(1, pigqueen_update, 1)
end

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_crown_swap", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_crown", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

	sendi_hat_crown_enable(inst)	
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")

	sendi_hat_crown_disable(inst)
end

local function fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()      

	MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("sendi_hat_crown")
    inst.AnimState:SetBuild("sendi_hat_crown")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("hat")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine() -- YUKARI : 이거 꼭 있는지 확인!

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_hat_crown.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("waterproofer") --방수
    inst.components.waterproofer:SetEffectiveness(0.25)
    inst:AddComponent("inspectable") --조사 가능하도록 설정
    return inst
end

return  Prefab("sendi_hat_crown", fn, assets, prefabs)