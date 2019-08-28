--업그레이드 더미파일이 숨어있음.

local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
	Asset("ANIM", "anim/sendi_skin_longtail.zip"),
	--------센디스킨
	Asset("ANIM", "anim/sendi_skin_christmas.zip"), -- 크리스마스 사이드테일
	Asset("ANIM", "anim/sendi_skin_christmas_b.zip"),  --크리스마스 롱테일 
	Asset("ANIM", "anim/sendi_skin_ignia.zip"), --ver.이그니아 
	Asset("ANIM", "anim/sendi_skin_ignias.zip"), --ver.이그니아 금발
	
	--스킨파일이 추가됐을때마다 전부 추가해주세요
	
	}

local prefabs = {

}

local start_inv = {
-- 맞춤시작 인벤토리 시작 
	"sendipack",
	"sendi_rapier_wood"
}

local function SendiOnSetOwner(inst)
	if TheWorld.ismastersim then
        inst.sendi_classified.Network:SetClassifiedTarget(inst)
    end
end

local function AttachClassified(inst, classified)
	inst.sendi_classified = classified
    inst.ondetachsendiclassified = function() inst:DetachSendiClassified() end
    inst:ListenForEvent("onremove", inst.ondetachsendiclassified, classified)
end

local function DetachClassified(inst)
	inst.sendi_classified = nil
    inst.ondetachsendiclassified = nil
end

local function OverrideOnRemoveEntity(inst)
	inst.OnRemoveSendi = inst.OnRemoveEntity
	function inst.OnRemoveEntity(inst)
		if inst.jointask ~= nil then
			inst.jointask:Cancel()
		end

		if inst.sendi_classified ~= nil then
			if TheWorld.ismastersim then
				inst.sendi_classified:Remove()
				inst.sendi_classified = nil
			else
				inst:RemoveEventCallback("onremove", inst.ondetachsendiclassified, inst.sendi_classified)
				inst:DetachSendiClassified()
			end
		end
		return inst:OnRemoveSendi()
	end
end

local function onbecamehuman(inst)
-- 인물이 인간에게서 부활 할때
   inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sendi_speed_mod", 1.1)
   -- 유령이 아닌경우 속도 설정.
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sendi_speed_mod", 2.0)
   -- 귀신이 될때 속도 수정자 제거
end

local function onload(inst)
-- 캐릭터를 로드 하거나, 스폰 하는 경우 
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

--MH 모드옵션 불러오기
--local modoption = GetModConfigData("modoption")
--MH 모드옵션 불러오기

------------------------------/아래/-미쉘의  허기불꽃 시스템-/아래/--------------------------------
local function sendi_light(inst, data) --YUKARI : 주석의 의미에 맞게 코드를 좀더 명확하게 재작성
	if not inst:HasTag("playerghost") then 	--MH 모드 옵션 불러와서 세팅(할 예정)
		local Light = inst.Light or inst.entity:AddLight()  -- YUKARI : inst에 이미 Light가 있으면 불필요하게 추가하지 않게 하기위해서 이렇게 작성
															 -- AddLight는 한번만 사용해도 됩니다.
		if (TheWorld.state.isnight or TheWorld:HasTag("cave")) and not TheWorld.state.isfullmoon then
			if inst.components.hunger.current > 50 then --허기수치가 n 초과일때
				inst.Light:SetRadius(1.1)
				inst.Light:SetFalloff(1.2)
				inst.Light:SetIntensity(.5)
				inst.Light:SetColour(255, 255, 20/255, 25, 255)
				inst.Light:Enable(true) -- YUKARI : Light를 끄거나 키는데에 사용.
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
			else
				Light:Enable(false)
				
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
			end
			inst.components.health.regen.amount = 0
		else
			Light:Enable(false)
			inst.components.health.regen.amount = 0.2
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
		end
	end
end
----------------------------/ 위 /미쉘의  허기불꽃 시스템 / 위 /---------------------------------



local skins = { -- "sendi_skin_" [스킨] 뒤에 나오는 이름
	"DEFAULT", "longtail", "christmas", "christmas_b", "ignia", "ignias"
}

local function SetSkinBuild(inst) -- YUKARI 센디 스킨옵션 관련 
	local index = inst.skinindex

	if index == 1 then
		inst.AnimState:SetBuild("sendi")
	else
		local OverrideSkin =_G.SendiForceOverrideSkin
		inst.AnimState:SetBuild("sendi_skin_"..skins[index])

		if OverrideSkin == 2 then
			inst.AnimState:ClearOverrideSymbol("swap_body")
		elseif OverrideSkin == 3 and not inst.components.inventory:EquipHasTag("sendis") then
			inst.AnimState:ClearOverrideSymbol("swap_body")
		end

		if inst.components.inventory:EquipHasTag("sleevefix") then
			inst.AnimState:OverrideSymbol("arm_upper", "sendi", "arm_upper")
		else
			inst.AnimState:ClearOverrideSymbol("arm_upper")
		end
	end
end

local function OnChangeSkin(inst) -- YUKARI 스킨관련
	inst.skinindex = inst.skinindex >= #skins and 1 or inst.skinindex + 1
	SetSkinBuild(inst)
	-- TODO : 감정표현 추가
end

local function OnEquip(inst, data) 
	if data.eslot == EQUIPSLOTS.BODY then
		SetSkinBuild(inst)
	end
end

----------스킨 끝


local common_postinit = function(inst) 
	--센디의 커스텀레시피를 추가합니다. 
	inst.MiniMapEntity:SetIcon( "sendi.tex" )

	inst:AddTag("bookbuilder")-- 위커바컴의 책을 제조합니다.
	inst:AddTag("reader")
	inst:AddTag("sendi")-- 센디 제작 태그를 추가합니다
	

	inst:ListenForEvent("setowner", SendiOnSetOwner)
  
	OverrideOnRemoveEntity(inst)
	inst.AttachSendiClassified = AttachClassified
	inst.DetachSendiClassified = DetachClassified
end

local master_postinit = function(inst)
	inst.sendi_classified = SpawnPrefab("sendi_classified")
	inst:AddChild(inst.sendi_classified)
	inst.skinindex = 1

	inst.soundsname = "willow"
	-- 이 캐릭터의 사운드 윌로우로 설정함.
	inst.starting_inventory = start_inv

	inst:AddComponent("reader")
	inst:AddComponent("sendimana")
	inst:AddComponent("sendiskill")

	--------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------
	inst:WatchWorldState("phase", sendi_light)
	inst:ListenForEvent("hungerdelta", sendi_light)
	--------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------

	-- Stats   
	inst.components.health:SetMaxHealth(130) -- 피
	inst.components.hunger:SetMax(170) -- 배고팡
	inst.components.sanity:SetMax(90) -- 정신
	-- 최대피, 허기, 정신을 표시합니다.

	inst.components.health.fire_damage_scale = 0.01 --불딜
	inst.components.combat.damagemultiplier = 1 -- 데미지 계수 0.75로 설정
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
	
	inst.components.combat.min_attack_period = 0.15--공격속도 
	inst.components.health:StartRegen(0.3, 0.6)  --피리젠
	inst.OnLoad = onload
	inst.OnNewSpawn = onload
	inst.ChangeSkin = OnChangeSkin
	inst:ListenForEvent("equip", OnEquip )
	inst:ListenForEvent("unequip", OnEquip )
   
end

return MakePlayerCharacter("sendi", prefabs, assets, common_postinit, master_postinit)

















--업그레이드 더미파일 
-- local MakePlayerCharacter = require "prefabs/player_common"

-- local assets = {
	-- Asset("ANIM", "anim/sendi_skin_longtail.zip"),
	-- --------센디스킨
	-- Asset("ANIM", "anim/sendi_skin_christmas.zip"), -- 크리스마스 사이드테일
	-- Asset("ANIM", "anim/sendi_skin_christmas_b.zip"),  --크리스마스 롱테일 
	-- Asset("ANIM", "anim/sendi_skin_ignia.zip"), --ver.이그니아 
	-- Asset("ANIM", "anim/sendi_skin_ignias.zip"), --ver.이그니아 금발
	
	-- --스킨파일이 추가됐을때마다 전부 추가해주세요
	
	-- }

-- local prefabs = {

-- }

-- local start_inv = {
-- -- 맞춤시작 인벤토리 시작 
	-- "sendipack",
	-- "spear",
	-- "rope",
	-- "rope"
-- }
-- ---센디의 레벨업


-- local function applyupgrades(inst)
    -- local max_upgrades = 15 --최대 업그레이드 수치
    -- inst.level = math.min(inst.level, max_upgrades)

    -- local hunger_percent = inst.components.hunger:GetPercent()
    -- local health_percent = inst.components.health:GetPercent()
    -- local sanity_percent = inst.components.sanity:GetPercent()
	
    -- inst.components.hunger.max = math.ceil(TUNING.WX78_MIN_HUNGER + inst.level * (TUNING.WX78_MAX_HUNGER - TUNING.WX78_MIN_HUNGER) / max_upgrades)
    -- --최대 허기증가
	-- inst.components.health.maxhealth = math.ceil(TUNING.WX78_MIN_HEALTH + inst.level * (TUNING.WX78_MAX_HEALTH - TUNING.WX78_MIN_HEALTH) / max_upgrades)
    -- --최대 체력 증가
	-- inst.components.sanity.max = math.ceil(TUNING.WX78_MIN_SANITY + inst.level * (TUNING.WX78_MAX_SANITY - TUNING.WX78_MIN_SANITY) / max_upgrades)
	-- --최대 정신증가
	
    -- inst.components.hunger:SetPercent(hunger_percent)
    -- inst.components.health:SetPercent(health_percent)

    -- local ignoresanity = inst.components.sanity.ignore
    -- inst.components.sanity.ignore = false
    -- inst.components.sanity:SetPercent(sanity_percent)
    -- inst.components.sanity.ignore = ignoresanity
-- end

-- local function oneat(inst, food)
    -- if food and food.components.edible and food.components.edible.foodtype == FOODTYPE.AOS_SEED then
        -- inst.level = inst.level + 1
        -- applyupgrades(inst) 
        -- inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
    -- end
-- end

-- -- local function onpreload(inst, data) --로드 순서 클리핑문제로인해 저장 데이터를 다시 설정함.
    -- -- if data ~= nil and data.level ~= nil then
        -- -- inst.level = data.level
        -- -- applyupgrades(inst)
        -- -- --로드 순서 클리핑문제로인해 저장 데이터를 다시 설정함.
        -- -- if data.health ~= nil and data.health.health ~= nil then
            -- -- inst.components.health:SetCurrentHealth(data.health.health)
        -- -- end
        -- -- if data.hunger ~= nil and data.hunger.hunger ~= nil then
            -- -- inst.components.hunger.current = data.hunger.hunger
        -- -- end
        -- -- if data.sanity ~= nil and data.sanity.current ~= nil then
            -- -- inst.components.sanity.current = data.sanity.current
        -- -- end
        -- -- inst.components.health:DoDelta(0)
        -- -- inst.components.hunger:DoDelta(0)
        -- -- inst.components.sanity:DoDelta(0)
    -- -- end
-- -- end


-- local function onload(inst, data) --불러옴
    -- if data ~= nil and data.charge_time ~= nil then
        -- startovercharge(inst, data.charge_time)
    -- end
-- end

-- local function onsave(inst, data) --저장함
    -- data.level = inst.level > 0 and inst.level or nil
 -- --   data.charge_time = inst.charge_time > 0 and inst.charge_time or nil
-- end


-- -- local function ondeath(inst) --죽으면
    -- -- if inst.level > 0 then
        -- -- local dropaos_seed = math.random(math.floor(inst.level / 3), math.ceil(inst.level / 2))
        -- -- if dropaos_seed > 0 then
            -- -- for i = 1, dropaos_seed do
                -- -- local gear = SpawnPrefab("aos_seed")
                -- -- if gear ~= nil then
                    -- -- local x, y, z = inst.Transform:GetWorldPosition()
                    -- -- if gear.Physics ~= nil then
                        -- -- local speed = 2 + math.random()
                        -- -- local angle = math.random() * 2 * PI
                        -- -- gear.Transform:SetPosition(x, y + 1, z)
                        -- -- gear.Physics:SetVel(speed * math.cos(angle), speed * 3, speed * math.sin(angle))
                    -- -- else
                        -- -- gear.Transform:SetPosition(x, y, z)
                    -- -- end
                    -- -- if gear.components.propagator ~= nil then
                        -- -- gear.components.propagator:Delay(5)
                    -- -- end
                -- -- end
            -- -- end
        -- -- end
        -- -- inst.level = 0
        -- -- applyupgrades(inst)
    -- -- end
-- -- end

-- ---센디의레벨업


-- local function SendiOnSetOwner(inst)
	-- if TheWorld.ismastersim then
        -- inst.sendi_classified.Network:SetClassifiedTarget(inst)
    -- end
-- end

-- local function AttachClassified(inst, classified)
	-- inst.sendi_classified = classified
    -- inst.ondetachsendiclassified = function() inst:DetachSendiClassified() end
    -- inst:ListenForEvent("onremove", inst.ondetachsendiclassified, classified)
-- end

-- local function DetachClassified(inst)
	-- inst.sendi_classified = nil
    -- inst.ondetachsendiclassified = nil
-- end

-- local function OverrideOnRemoveEntity(inst)
	-- inst.OnRemoveSendi = inst.OnRemoveEntity
	-- function inst.OnRemoveEntity(inst)
		-- if inst.jointask ~= nil then
			-- inst.jointask:Cancel()
		-- end

		-- if inst.sendi_classified ~= nil then
			-- if TheWorld.ismastersim then
				-- inst.sendi_classified:Remove()
				-- inst.sendi_classified = nil
			-- else
				-- inst:RemoveEventCallback("onremove", inst.ondetachsendiclassified, inst.sendi_classified)
				-- inst:DetachSendiClassified()
			-- end
		-- end
		-- return inst:OnRemoveSendi()
	-- end
-- end

-- local function onbecamehuman(inst)
-- -- 인물이 인간에게서 부활 할때
   -- inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sendi_speed_mod", 1.1)
   -- -- 유령이 아닌경우 속도 설정.
-- end

-- local function onbecameghost(inst)
   -- inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sendi_speed_mod", 2.0)
   -- -- 귀신이 될때 속도 수정자 제거
-- end

-- local function onload(inst)
-- -- 캐릭터를 로드 하거나, 스폰 하는 경우 
    -- inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    -- inst:ListenForEvent("ms_becameghost", onbecameghost)

    -- if inst:HasTag("playerghost") then
        -- onbecameghost(inst)
    -- else
        -- onbecamehuman(inst)
    -- end
-- end

-- --MH 모드옵션 불러오기
-- --local modoption = GetModConfigData("modoption")
-- --MH 모드옵션 불러오기

-- ------------------------------/아래/-미쉘의  허기불꽃 시스템-/아래/--------------------------------
-- local function sendi_light(inst, data) --YUKARI : 주석의 의미에 맞게 코드를 좀더 명확하게 재작성
	-- if not inst:HasTag("playerghost") then 	--MH 모드 옵션 불러와서 세팅(할 예정)
		-- local Light = inst.Light or inst.entity:AddLight()  -- YUKARI : inst에 이미 Light가 있으면 불필요하게 추가하지 않게 하기위해서 이렇게 작성
															 -- -- AddLight는 한번만 사용해도 됩니다.
		-- if (TheWorld.state.isnight or TheWorld:HasTag("cave")) and not TheWorld.state.isfullmoon then
			-- if inst.components.hunger.current > 50 then --허기수치가 n 초과일때
				-- inst.Light:SetRadius(1.1)
				-- inst.Light:SetFalloff(1.2)
				-- inst.Light:SetIntensity(.5)
				-- inst.Light:SetColour(255, 255, 20/255, 25, 255)
				-- inst.Light:Enable(true) -- YUKARI : Light를 끄거나 키는데에 사용.
				-- inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
			-- else
				-- Light:Enable(false)
				
				-- inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
			-- end
			-- inst.components.health.regen.amount = 0
		-- else
			-- Light:Enable(false)
			-- inst.components.health.regen.amount = 0.2
			-- inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
		-- end
	-- end
-- end
-- ----------------------------/ 위 /미쉘의  허기불꽃 시스템 / 위 /---------------------------------



-- local skins = { -- "sendi_skin_" [스킨] 뒤에 나오는 이름
	-- "DEFAULT", "longtail", "christmas", "christmas_b", "ignia", "ignias"
-- }

-- local function SetSkinBuild(inst) -- YUKARI 센디 스킨옵션 관련 
	-- local index = inst.skinindex

	-- if index == 1 then
		-- inst.AnimState:SetBuild("sendi")
	-- else
		-- local OverrideSkin =_G.SendiForceOverrideSkin
		-- inst.AnimState:SetBuild("sendi_skin_"..skins[index])

		-- if OverrideSkin == 2 then
			-- inst.AnimState:ClearOverrideSymbol("swap_body")
		-- elseif OverrideSkin == 3 and not inst.components.inventory:EquipHasTag("sendis") then
			-- inst.AnimState:ClearOverrideSymbol("swap_body")
		-- end

		-- if inst.components.inventory:EquipHasTag("sleevefix") then
			-- inst.AnimState:OverrideSymbol("arm_upper", "sendi", "arm_upper")
		-- else
			-- inst.AnimState:ClearOverrideSymbol("arm_upper")
		-- end
	-- end
-- end

-- local function OnChangeSkin(inst) -- YUKARI 스킨관련
	-- inst.skinindex = inst.skinindex >= #skins and 1 or inst.skinindex + 1
	-- SetSkinBuild(inst)
	-- -- TODO : 감정표현 추가
-- end

-- local function OnEquip(inst, data) 
	-- if data.eslot == EQUIPSLOTS.BODY then
		-- SetSkinBuild(inst)
	-- end
-- end

-- ----------스킨 끝


-- local common_postinit = function(inst) 
	-- --센디의 커스텀레시피를 추가합니다. 
	-- inst.MiniMapEntity:SetIcon( "sendi.tex" )

	-- inst:AddTag("bookbuilder")-- 위커바컴의 책을 제조합니다.
	-- inst:AddTag("reader")
	-- inst:AddTag("sendi")-- 센디 제작 태그를 추가합니다
	

	-- inst:ListenForEvent("setowner", SendiOnSetOwner)

	-- OverrideOnRemoveEntity(inst)
	-- inst.AttachSendiClassified = AttachClassified
	-- inst.DetachSendiClassified = DetachClassified
-- end







-- local master_postinit = function(inst)
	-- inst.sendi_classified = SpawnPrefab("sendi_classified")
	-- inst:AddChild(inst.sendi_classified)
	-- inst.skinindex = 1

	-- inst.soundsname = "willow"
	-- -- 이 캐릭터의 사운드 윌로우로 설정함.
	-- --inst.starting_inventory = start_inv

	-- inst:AddComponent("reader")
	-- inst:AddComponent("sendiskill")

	-- --레벨업
	-- inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

    -- inst.level = 1

    -- if inst.components.eater ~= nil then
        -- inst.components.eater.ignoresspoilage = true
        -- inst.components.eater:SetCanEatGears()
        -- inst.components.eater:SetOnEatFn(oneat)
    -- end
	
    -- applyupgrades(inst) --죽으면
	
	
	
	-- -- if TheNet:GetServerGameMode() == "lavaarena" then
        -- -- event_server_data("lavaarena", "prefabs/wx78").master_postinit(inst)
    -- -- elseif TheNet:GetServerGameMode() == "quagmire" then
        -- -- event_server_data("quagmire", "prefabs/wx78").master_postinit(inst)
    -- -- end
	
	
	-- --레벨업

	
	
	-- -- Stats   
	-- inst.components.health:SetMaxHealth(130) -- 피
	-- inst.components.hunger:SetMax(170) -- 배고팡
	-- inst.components.sanity:SetMax(90) -- 정신
	-- -- 최대피, 허기, 정신을 표시합니다.

	-- inst.components.health.fire_damage_scale = 0.01 --불딜
	-- inst.components.combat.damagemultiplier = 1 -- 데미지 계수 0.75로 설정
	-- inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
	
	-- inst.components.combat.min_attack_period = 0.15--공격속도 
	-- inst.components.health:StartRegen(0.3, 0.6)  --피리젠
	-- inst.OnNewSpawn = onload
	-- inst.ChangeSkin = OnChangeSkin
	-- inst:ListenForEvent("equip", OnEquip )
	-- inst:ListenForEvent("unequip", OnEquip )
   
   
   
   -- ----레벨업
   
    -- inst.OnSave = onsave
    -- inst.OnLoad = onload
	-- --inst.OnPreLoad = onpreload
   
   -- ----레벨업
   
   
	-- --------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------
	-- inst:WatchWorldState("phase", sendi_light)
	-- inst:ListenForEvent("hungerdelta", sendi_light)
	-- --------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------
	
-- end

-- return MakePlayerCharacter("sendi", prefabs, assets, common_postinit, master_postinit)