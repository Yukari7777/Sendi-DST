local CONST = TUNING.SENDI

local assets = {
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


local function ontakefuel(inst)
    local armor = inst.components.armor
    local afterrepair = armor.condition + 200

    armor:SetCondition(afterrepair >= CONST.ARMOR1_CONDITION and CONST.ARMOR1_CONDITION or afterrepair)
    armor.absorb_percent = CONST.ARMOR1_EFFICIENCY -- 수리 하면 방어율 복원

    inst:PushEvent("percentusedchange", { percent = armor:GetPercent() })
end

--수리
local function SetConditionTweak(self, amount)
    self.condition = math.min(amount, self.maxcondition)
    if self.condition <= 0 then
        self.condition = 0
        self.absorb_percent = 0
    end

    self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
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

    inst:AddTag("sleevefix")-- YUKARI 센디 스킨옵션 관련 
    inst:AddTag("sendis")-- YUKARI 센디 스킨옵션 관련 

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "sendi_armor_01"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_armor_01.xml"


    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    --inst.components.equippable.dapperness = 0.2-- 초당 정신 회복 
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.2 --이동속도 : 케인

    inst:AddComponent("fueled") --연료가 있는.
    inst.components.fueled.fueltype = "CREASEED"
    inst.components.fueled:InitializeFuelLevel(10)
    inst.components.fueled.accepting = true
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:StopConsuming()
    -- ---연료

    inst:AddComponent("armor")
    inst.components.armor.SetCondition = SetConditionTweak
    inst.components.armor:InitCondition(CONST.ARMOR1_CONDITION, CONST.ARMOR1_EFFICIENCY)   --내구도, 방어력

    inst:AddComponent("insulator")--보온율
    inst.components.insulator:SetInsulation(200)

    return inst
end

return Prefab("common/inventory/sendi_armor_01", fn, assets)