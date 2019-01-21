local assets={  
    Asset("ANIM", "anim/hat_crown.zip"),
    Asset("ANIM", "anim/hat_crown_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/hat_crown.xml"),
    Asset("IMAGE", "images/inventoryimages/hat_crown.tex"),
}

local prefabs = 
{
}

local function hat_crown_disable(inst)
    if inst.updatetask then
        inst.updatetask:Cancel()
        inst.updatetask = nil
    end

end

local banddt = 1

local function pigqueen_update( inst )  --돼지 팔로워 
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
	
    if owner and owner.components.leader then
        local x,y,z = owner.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, {"pig"}, {'werepig'})
        for k,v in pairs(ents) do
            if v.components.follower and not v.components.follower.leader  and not owner.components.leader:IsFollower(v) and owner.components.leader.numfollowers < 10 then
                owner.components.leader:AddFollower(v)

            end
        end
		
        for k,v in pairs(owner.components.leader.followers) do
            if k:HasTag("pig") and k.components.follower then
                k.components.follower:AddLoyaltyTime(0.30)
            end
        end	
    else
        local x,y,z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, {"pig"}, {'werepig'})
        for k,v in pairs(ents) do
            if v.components.follower and not v.components.follower.leader  and not inst.components.leader:IsFollower(v) and inst.components.leader.numfollowers < 10 then
                inst.components.leader:AddFollower(v)

            end
        end
        for k,v in pairs(inst.components.leader.followers) do
            if k:HasTag("pig") and k.components.follower then
                k.components.follower:AddLoyaltyTime(180)
            end
        end

    end
end

local function hat_crown_enable(inst) --돼지 팔로워 
    inst.updatetask = inst:DoPeriodicTask(banddt, pigqueen_update, 1)
end

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "hat_crown_swap", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "hat_crown", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

		hat_crown_enable(inst)	
	
		inst.isWeared = true
		inst.isDropped = false

	
end

local function OnUnequip(inst, owner) 
        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
		hat_crown_disable(inst)
		inst.isWeared = false
		inst.isDropped = false

	end
	
	

local function fn(Sim)

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()      
	
	inst:AddTag("hat")
    
    anim:SetBank("hat_crown")
    anim:SetBuild("hat_crown")
    anim:PlayAnimation("idle")
	
	if not TheWorld.ismastersim then
        return inst
    end
    

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_crown.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst.components.inventoryitem.keepondeath = true

	inst:AddComponent("waterproofer") --방수
    inst.components.waterproofer:SetEffectiveness(0.25)
	
    return inst
end

return  Prefab("hat_crown", fn, assets, prefabs)