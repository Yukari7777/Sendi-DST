
--  sendi_rapier_ignia


-- 그래픽 자원 설정. 예시엔 드랍 이미지, 장착 이미지, 인벤토리 이미지, 인벤토리 이미지 xml이 설정됨.
--MH: 미쉘이추가한 코드. 미쉘 추가한거 바로 보시려면 컨 + F MH검색.

local assets ={
    Asset("ANIM", "anim/sendi_rapier_ignia.zip"),
    Asset("ANIM", "anim/swap_sendi_rapier_ignia.zip"), --<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< swap파일을 로드 하지 않았습니다. 쥐님.
   
   Asset("ATLAS", "images/inventoryimages/sendi_rapier_ignia.xml"),
   Asset("IMAGE", "images/inventoryimages/sendi_rapier_ignia.tex"),
}

local prefabs = {
	"firesplash_fx", --YUKARI : 이펙트 같은 외부 파일들을 로드해야할땐 반드시 prefabs 어규먼트를 넣어주세요.
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
    owner.AnimState:OverrideSymbol("swap_object", "swap_sendi_rapier_ignia", "swap")
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

local DEFAULTBURNTIME = 3
local BURNDAMAGE = 3
local BURNADDTIME = 2
local BURNPERIOD = 1

local function onattack(inst, attacker, target)
	local fx = SpawnPrefab("firesplash_fx")
	fx.Transform:SetScale(0.5, 0.5, 0.5)
	fx.Transform:SetPosition(target:GetPosition():Get())
	if target.DotDamageTask ~= nil then 
		target.burntime = target.burntime + BURNADDTIME
	else 
		local BurnTime = target.components.burnable ~= nil and target.components.burnable.burntime -- 해당 개체의 불탈 시간이 존재한다면 그 값을 가져옴
		local function OnIgnite(target)
			target.AnimState:SetMultColour(0.8, 0.5, 0.5, 1)
			if target.components.health ~= nil then
				target.components.health:DoDelta(-BURNDAMAGE)
			end
		end
		OnIgnite(target)
		target.burntime = BurnTime ~= nil and (BurnTime / 3) or DEFAULTBURNTIME -- BurnTime이 nil이면 3 대입 (불타던 시간 / 3 만큼 타거나, 3초동안 탐)
		target.DotDamageTask = target.DoPeriodicTask(target, BURNPERIOD, function() -- 함수를 실행하고 그 참조값을 해당 개체에 남긴다. (외부에서 참조할 수 있게됨)
			if target.burntime > 0 then
				OnIgnite(target)
				target.burntime = target.burntime - 1
			else
				target.AnimState:SetMultColour(1, 1, 1, 1) --원래 색깔로
				target.burntime = 0 -- burntime은 위의 연산에서 음수일 수도 있음
			end
		end)
	end -- Yukari : 커스텀 도트데미지 함수 작성함.
end


local function fn()

	local inst = CreateEntity()  
	-- local trans = inst.entity:AddTransform() <<<<<<<<<< YUKARI : 이거와 같은 경우에, trans라는 변수가 더이상 쓰이지 않을것 같을땐 변수로 할당하지 않는 습관을 들여주세요.(메모리 낭비됨)
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)


   
    inst.AnimState:SetBank("sendi_rapier_ignia")
    inst.AnimState:SetBuild("sendi_rapier_ignia")
    inst.AnimState:PlayAnimation("idle")
   --떨군 이미지추가 
   
    inst:AddTag("sharp") 
    inst:AddTag("pointy") 
	-- 태그 설정, 이 두 태그는 없어도 됨(실행 확인)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

   
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(50)
   -- 무기로 설정. 아래는 피해 설정
	inst.components.weapon:SetRange(1.2)
	--공격범위
   
    inst:AddComponent("inspectable")
	--조사 가능하도록 설정
	
    inst:AddComponent("inventoryitem")
   inst.components.inventoryitem.imagename = "sendi_rapier_ignia"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_rapier_ignia.xml"
   --인벤토리 아이템으로 설정됨
   
    MakeHauntableLaunchAndPerish(inst)
   
   

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	--장착 가능하도록, 장착밑 해제시의 위의 두 펑션을 작동
	
	inst.components.weapon:SetOnAttack(onattack)--MH불꽃데미지 

	inst.OnLoad = OnLoad
	--YUKARI : OnLoad, OnSave, OnPreLoad 함수들은 마지막에 입력해주세요. 

    return inst
end

return Prefab("sendi_rapier_ignia", fn, assets, prefabs) --YUKARI : prefab 어규먼트