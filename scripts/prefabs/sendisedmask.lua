local assets={ 
    Asset("ANIM", "anim/sendisedmask.zip"),
    Asset("ANIM", "anim/sendisedmask_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/sendisedmask.xml"),
    Asset("IMAGE", "images/inventoryimages/sendisedmask.tex"),
	
}

local prefabs = {}


local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "sendisedmask_swap", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "sendisedmask", "swap_hat")
									
								--{{ 덧씌울 애니메이션인 뱅크명 / build[sendisedmask_swap] 위에서 언급한 부품들 / build가 들어있는 폴더명, [스프라이터에서 animations 위에있는 이름.]
								
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
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()      

	MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("sendisedmask")
    inst.AnimState:SetBuild("sendisedmask")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("hat")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine() -- YUKARI : 이거 꼭 있는지 확인!

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendisedmask.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("waterproofer") --방수
    inst.components.waterproofer:SetEffectiveness(0.80)
	inst.components.equippable.dapperness = -1
	
	-- 방수율을 뜻합니다 (0.방수율)
	
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(5500, 0.9)    
	-- 내구도와 방어구를 뜻합니다.  (내구도, 0.방어력) 
	
    inst:AddComponent("inspectable") --조사 가능하도록 설정
	inst.components.inventoryitem.keepondeath = true--죽어도 떨어뜨리지않음
	
    return inst
end

return  Prefab("sendisedmask", fn, assets, prefabs)