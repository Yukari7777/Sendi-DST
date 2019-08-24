
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
	"firesplash_fx", --YK : 이펙트 같은 외부 파일들을 로드해야할땐 반드시 prefabs 어규먼트를 넣어주세요.
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
	inst.Light:Enable(true)
	-- 장착 시 설정.
	-- owner.AnimState:OverrideSymbol("애니메이션 뱅크명", "빌드명", "빌드 폴더명")
	-- 그 아래 2줄은 물건을 들고 있는 팔 모습을 활성화하고, 빈 팔 모습을 비활성화.
end

local function onunequip(inst, owner)
    --UpdateDamage(inst)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
	inst.Light:Enable(false)
  --  local skin_build = inst:GetSkinBuild()
   -- if skin_build ~= nil then
   --     owner:PushEvent("unequipskinneditem", inst:GetSkinName())
   -- end
end

local DEFAULTBURNTIME = 9
local BURNDAMAGE = 3 -- 데미지
local BURNADDTIME = 9 --지속시간
local BURNPERIOD = 0.2 --도트데미지 간격

local function Enlight(thing)
	print(thing)
	--thing.entity:AddLight()
	thing.Light:SetRadius(.5)
	thing.Light:SetFalloff(.2)
	thing.Light:SetIntensity(.8)
	thing.Light:SetColour(1, 0.6, 0.6)
	thing.Light:Enable(true)
	thing:DoTaskInTime(0.5, function() 
		thing.Light:Enable(false)
	end)
end

local function onattack(inst, attacker, target)--파이어 관련 코딩
	local fx = SpawnPrefab("firesplash_fx")
	fx.Transform:SetScale(0.5, 0.5, 0.5)
	fx.Transform:SetPosition(target:GetPosition():Get())
	--Enlight(inst)

	if inst.EnlightTask ~= nil then 
		inst.rad = 0.5
	else 
		local function Dim(inst)
			inst.Light:Enable(true)
			inst.Light:SetRadius(inst.rad)
			inst.rad = inst.rad - 0.1
		end
		inst.entity:AddLight()
		inst.rad = 0.5
		inst.Light:SetRadius(.5)
		inst.Light:SetFalloff(.2)
		inst.Light:SetIntensity(.8)
		inst.Light:SetColour(1, 0.6, 0.6)
		inst.Light:Enable(true)
		inst.EnlightTask = inst.DoPeriodicTask(inst, 0.1, function()
			if inst.rad > 0 then
				Dim(inst)
			else
				inst.rad = 0
				inst.Light:Enable(false)
			end
		end)
	end 

	if target.DotDamageTask ~= nil then 
		target.burntime = target.burntime + BURNADDTIME
	else 
		local BurnTime = target.components.burnable ~= nil and target.components.burnable.burntime or nil 
		-- 해당 개체의 불탈 시간이 존재한다면 그 값을 가져옴
		local function OnIgnite(target)
			target.AnimState:SetMultColour(0.8, 0.5, 0.5, 1)
			if target.components.health ~= nil then
				target.components.health:DoDelta(-BURNDAMAGE)
			end
		end
		OnIgnite(target)
		target.burntime = BurnTime ~= nil and (BurnTime / 3) or DEFAULTBURNTIME 
		-- BurnTime이 nil이면 3 대입 (불타던 시간 / 3 만큼 타거나, 3초동안 탐)
		
		target.DotDamageTask = target.DoPeriodicTask(target, BURNPERIOD, function() 
		-- 함수를 실행하고 그 참조값을 해당 개체에 남긴다. (외부에서 참조할 수 있게됨)
			if target.burntime > 0 then
				OnIgnite(target)
				target.burntime = target.burntime - 1
			else
				target.AnimState:SetMultColour(1, 1, 1, 1) 
				--원래 색깔로
				target.burntime = 0 
				-- burntime은 위의 연산에서 음수일 수도 있음
			end
		end)
	end -- Yukari : 커스텀 도트데미지 함수 작성함.
end


local function fn()

	local inst = CreateEntity()  
	-- local trans = inst.entity:AddTransform() <<<<<<<<<< YK : 이거와 같은 경우에, trans라는 변수가 더이상 쓰이지 않을것 같을땐 변수로 할당하지 않는 습관을 들여주세요.(메모리 낭비됨)
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

	inst.entity:AddLight()
	inst.Light:SetRadius(.2)
	inst.Light:SetFalloff(.8)
	inst.Light:SetIntensity(.5)
	inst.Light:SetColour(0.9, 0.3, 0.3)
	inst.Light:Enable(false)

    inst.AnimState:SetBank("sendi_rapier_ignia")
    inst.AnimState:SetBuild("sendi_rapier_ignia")
    inst.AnimState:PlayAnimation("idle") --떨군 이미지추가 
   
    inst:AddTag("sharp") -- 태그 설정, 이 두 태그는 없어도 됨(실행 확인)
    inst:AddTag("pointy") 
	
    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()

   
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(65) 
	-- 무기로 설정. 아래는 피해 설정
	inst.components.weapon:SetRange(1.2) --공격범위
	inst.components.weapon:SetOnAttack(onattack)--YK불꽃데미지 
	
    inst:AddComponent("inspectable") --조사 가능하도록 설정
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sendi_rapier_ignia"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_rapier_ignia.xml" --인벤토리 아이템으로 설정됨
   
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	MakeHauntableLaunchAndPerish(inst)
	
	inst.OnLoad = OnLoad
	--YK : OnLoad, OnSave, OnPreLoad 함수들은 마지막에 입력해주세요. 
	inst.components.inventoryitem.keepondeath = true
    return inst
end

return Prefab("sendi_rapier_ignia", fn, assets, prefabs) --YK : prefab 어규먼트