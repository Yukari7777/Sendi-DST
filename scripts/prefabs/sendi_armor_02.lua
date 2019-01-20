local assets =
{
    Asset("ANIM", "anim/sendi_armor_02.zip"),
    Asset("ATLAS", "images/inventoryimages/sendi_armor_02.xml"),
    Asset("IMAGE", "images/inventoryimages/sendi_armor_02.tex"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "sendi_armor_02", "swap_body")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function ChangeInsulation(inst, temperature)
	if temperature < 5 then -- 추워하는 화면 이펙트가 생기는 것의 분기점
		inst.components.insulator:SetWinter()
	else
		inst.components.insulator:SetSummer()
	end
end
	
	
local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sendi_armor_02")
    inst.AnimState:SetBuild("sendi_armor_02")
    inst.AnimState:PlayAnimation("anim")
	
	inst:AddTag("sleevefix") -- YUKARI 센디 스킨옵션 관련 
	inst:AddTag("sendis")-- YUKARI 센디 스킨옵션 관련 

    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sendi_armor_02"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_armor_02.xml"

	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	inst.components.equippable.dapperness = 0.25 --초당 정신력 회복 
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.25 --이동속도 : 케인
	
	inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.8) -- YUKARI : 무한 내구도
	--내구도,방여력
	
	inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(401)
	
	MakeHauntableLaunch(inst)

	ChangeInsulation(inst, TheWorld.state.temperature) 
	inst:WatchWorldState("temperature", ChangeInsulation) --YUKARI : 기온에 따라 바뀌게 함수 개선

    return inst
end

return Prefab("common/inventory/sendi_armor_02", fn, assets)