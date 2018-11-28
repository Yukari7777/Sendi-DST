local assets={ 
    Asset("ANIM", "anim/sendisedmask.zip"),
    Asset("ANIM", "anim/sendisedmask_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/sendisedmask.xml"),
    Asset("IMAGE", "images/inventoryimages/sendisedmask.tex"),
	
}

local prefabs = 
{
}


local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "sendisedmask_swap", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "sendisedmask", "swap_hat")
									--덧씌울 애니메이션인 뱅크명 / build[sendisedmask_swap] 위에서 언급한 부품들 / build가 들어있는 폴더명
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
 		
		inst.isWeared = true
		inst.isDropped = false

	
end

local function OnUnequip(inst, owner) 
        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
	
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
    
    anim:SetBank("beehat")-- "sendisedmask"에서 수정함.
    anim:SetBuild("sendisedmask")-- "sendisedmask"에서 수정함.
    anim:PlayAnimation("anim")

	
	if not TheWorld.ismastersim then
        return inst
    end
    

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendisedmask.xml"
	
	
 
    --inst:AddComponent("armor")
	--inst.components.armor:InitCondition(TUNING.ARMORMARBLE, TUNING.ARMORWOOD_ABSORPTION)    
	--방어율 수치 : 나무 갑옷 여기서 TUNING.ARMORWOOD_ABSORPTION를 0.9로 바꿔주면 90%의 방어율을 가진다. 

    inst:AddComponent("armor")
	inst.components.armor:InitCondition(9999999999999999999999999999999999999999999, 0.45)    
	-- 내구도와 방어구를 뜻합니다.  (내구도, 0.방어력) 
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	
	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0.25)
	-- 방수율을 뜻합니다 (0.방수율)
	
	--inst:AddComponent("insulator")
    --inst.components.insulator:SetInsulation(100)
	-- 보온율을 뜻합니다. 보온율은 100단위 입니다.
	

	
	if not inst.components.sendispecific then
	inst:AddComponent("sendispecific")
	end
	
	
	
 
	inst.components.sendispecific:SetOwner("sendi")
	inst.components.sendispecific:SetStorable(true)


    return inst
end


return  Prefab("sendisedmask", fn, assets, prefabs)