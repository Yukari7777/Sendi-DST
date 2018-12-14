-- 그래픽 자원 설정. 예시엔 드랍 이미지, 장착 이미지, 인벤토리 이미지, 인벤토리 이미지 xml이 설정됨.

local assets ={
    Asset("ANIM", "anim/sendi_rapier.zip"),
    Asset("ANIM", "anim/swap_sendi_rapier.zip"),
   
   Asset("ATLAS", "images/inventoryimages/sendi_rapier.xml"),
   Asset("IMAGE", "images/inventoryimages/sendi_rapier.tex"),
}

local function UpdateDamage(inst)
    if inst.components.perishable and inst.components.weapon then
        local dmg = TUNING.HAMBAT_DAMAGE * inst.components.perishable:GetPercent()
        dmg = Remap(dmg, 0, TUNING.HAMBAT_DAMAGE, TUNING.HAMBAT_MIN_DAMAGE_MODIFIER*TUNING.HAMBAT_DAMAGE, TUNING.HAMBAT_DAMAGE)
        inst.components.weapon:SetDamage(dmg)
    end
end

local function OnLoad(inst, data)
   -- UpdateDamage(inst)
end
            --onunequip
local function onequip(inst, owner)

   
    owner.AnimState:OverrideSymbol("swap_object", "swap_sendi_rapier_01", "swap")
									--"?? " "네임" "애니메이션 경로"
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	
	-- 장착 시 설정.
	-- owner.AnimState:OverrideSymbol("애니메이션 뱅크명", "빌드명", "빌드 폴더명")
	-- 그 아래 2줄은 물건을 들고 있는 팔 모습을 활성화하고, 빈 팔 모습을 비활성화.


   end

   
local function onunequip(inst, owner)
    --UpdateDamage(inst)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
  --  local skin_build = inst:GetSkinBuild()
   -- if skin_build ~= nil then
   --     owner:PushEvent("unequipskinneditem", inst:GetSkinName())
   -- end
end


local function fn()

    local inst = CreateEntity()

   
   local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
   -- 아기쥐 추가   
   
    inst.entity:AddNetwork()
 
    MakeInventoryPhysics(inst)


   
    inst.AnimState:SetBank("sendi_rapier")
    inst.AnimState:SetBuild("sendi_rapier")
    inst.AnimState:PlayAnimation("idle")
   --떨군 이미지추가 
   
    inst:AddTag("sharp") 
    inst:AddTag("pointy") 
	-- 태그 설정, 이 두 태그는 없어도 됨(실행 확인)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --inst:AddComponent("perishable")
  --  inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
   -- inst.components.perishable:StartPerishing()
  --  inst.components.perishable.onperishreplacement = "spoiled_food"
   --유통기한
   
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(40)
   -- 무기로 설정. 아래는 피해 설정
    inst.OnLoad = OnLoad

    -------
    --[[
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.healthvalue = -TUNING.HEALING_MEDSMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
    inst.components.edible.sanityvalue = -TUNING.SANITY_MED
    --]]
	-- 내구도 설정. 이 구간을 지워버리면 무한 내구도가 될 것이라 추정. a는 최대 내구도, b는 제작 완료 시 내구도. 대부분 a = b.
  
   
    inst:AddComponent("inspectable")
	--조사 가능하도록 설정
	
    inst:AddComponent("inventoryitem")
   inst.components.inventoryitem.imagename = "sendi_rapier"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_rapier.xml"
   --인벤토리 아이템으로 설정됨
   
    MakeHauntableLaunchAndPerish(inst)
   
   

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	--장착 가능하도록, 장착밑 해제시의 위의 두 펑션을 작동
	
    return inst
end

return Prefab("sendi_rapier", fn, assets) 