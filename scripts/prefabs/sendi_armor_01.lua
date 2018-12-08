local assets =
{
    Asset("ANIM", "anim/sendi_armor_01.zip"),
    Asset("ATLAS", "images/inventoryimages/sendi_armor_01.xml"),
    Asset("IMAGE", "images/inventoryimages/sendi_armor_01.tex"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "sendi_armor_01", "swap_body")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sendi_armor_01")
    inst.AnimState:SetBuild("sendi_armor_01")
    inst.AnimState:PlayAnimation("anim")
	
    --inst.AnimState:SetMultColour(1, 1, 1, 0.6)


    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sendi_armor_01"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_armor_01.xml"

	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
	--이동속도 : 케인
	
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(1000, 0.55)   
	--내구도,방여력
	
	inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(400)
	--보온률 400

	
	
	local function sanityability(inst)
	inst.components.equippable.dapperness = 1
	
    MakeHauntableLaunch(inst)
	
	
	

	--정신력을 회복 합니다.
	
end
	
    return inst
	
	
end

return Prefab("common/inventory/sendi_armor_01", fn, assets)