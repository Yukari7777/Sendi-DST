--토끼수인이 고기를 들어도 공격하지않게만들려면  해당 장비 루아의 OnEquip에 [owner:RemoveTag("ignoreMeat")] OnUnequip에  [owner:RemoveTag("ignoreMeat")] 를 추가하세요.

PrefabFiles = {
--센디 전용 아이템등을 추가
	"sendi_classified",
	"sendi",
	"sendi_none",
	--------캐릭터요소---------
	"sendipack", 
	--------기타---------
	"sendisedmask", --센디마스크
	"sendi_hat_crown", -- 군주의 왕관
	"sendi_hat_goggles", -- 프랜드 고글
	"sendi_hat_spider", -- 스파이더 헬멧
	--------모자----------
	"sendi_rapier_wood", --우드 레이피어
	"sendi_rapier", --레이피어
	"sendi_rapier_ignia", --이그니아레이피어
	--------레이피어-----------
	"sendi_armor_01", --센디의 니트 갑옷
	"sendi_armor_02", --센디의 여름용 갑옷

	--"sendi_amulet",	--sendi_amulet
	--------갑옷--------------
	"sendi_oven", -- 센디 오븐
	"sendi_ovenfire_fx", -- 센디 오븐의 불꽃이펙트
	"sendiobject_hut", -- 센디 오두막
	"sendiobject_warehouse", -- 센디 창고
	-------오브젝트[오븐]-------
	"aos_seed",
	-------시드---------------
	
	"sendi_food",
	
	--------음식------------
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/sendi.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/sendi.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/sendi.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/sendi.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/sendi_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/sendi_silho.xml" ),

    Asset( "IMAGE", "bigportraits/sendi.tex" ),
    Asset( "ATLAS", "bigportraits/sendi.xml" ),
	
	Asset( "IMAGE", "images/map_icons/sendi.tex" ),
	Asset( "ATLAS", "images/map_icons/sendi.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_sendi.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_sendi.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_sendi.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_sendi.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_sendi.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_sendi.xml" ),
	
	Asset( "IMAGE", "images/names_sendi.tex" ),
    Asset( "ATLAS", "images/names_sendi.xml" ),
	
	Asset( "IMAGE", "images/names_gold_sendi.tex" ),
    Asset( "ATLAS", "images/names_gold_sendi.xml" ),
	
    Asset( "IMAGE", "bigportraits/sendi_none.tex" ),
    Asset( "ATLAS", "bigportraits/sendi_none.xml" ),
	
	Asset( "IMAGE", "images/inventoryimages/senditab.tex" ),
	Asset( "ATLAS", "images/inventoryimages/senditab.xml" ),
	
	-----------아이템을 추가 합니다. 
	Asset( "IMAGE", "images/inventoryimages/sendipack.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendipack.xml"),
	------- 센디의 책가방
	Asset( "IMAGE", "images/inventoryimages/sendisedmask.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendisedmask.xml"),
	------- 센디의 눈물 마스크 
	Asset( "IMAGE", "images/inventoryimages/sendi_hat_crown.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_hat_crown.xml"),
	------- 프랜드 폭시 헬멧
	Asset( "IMAGE", "images/inventoryimages/sendi_hat_goggles.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_hat_goggles.xml"),
	------- 군주의 고글	
	Asset( "IMAGE", "images/inventoryimages/sendi_hat_spider.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_hat_spider.xml"),
	------- 스파이더 헬멧
	Asset( "IMAGE", "images/inventoryimages/sendi_armor_01.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_armor_01.xml"),
	-------센디의 니트갑옷 [임의 지정]
	Asset( "IMAGE", "images/inventoryimages/sendi_armor_02.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_armor_02.xml"),
	--------라이프 아머    
	
	-- Asset( "IMAGE", "images/inventoryimages/sendi_amulet.tex"),
	-- Asset( "ATLAS", "images/inventoryimages/sendi_amulet.xml"),	
	
	
	Asset( "IMAGE", "images/inventoryimages/sendi_rapier_wood.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_rapier_wood.xml"),
	--------연습용 목재 레이피어
	Asset( "IMAGE", "images/inventoryimages/sendi_rapier.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_rapier.xml"),
	--------센디의 레이피어
	Asset( "IMAGE", "images/inventoryimages/sendi_rapier_ignia.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_rapier_ignia.xml"),
	--------이그니아 레이피어
	Asset("ANIM", "anim/sendi_oven.zip"),
	Asset("ANIM", "anim/sendi_oven_open.zip"),
	Asset("ANIM", "anim/sendi_oven_fire.zip"),
	Asset("ANIM", "anim/sendi_oven_fire_cold.zip"),
	Asset("ATLAS", "images/inventoryimages/sendi_oven.xml"),
	--------센디오븐
	Asset( "IMAGE", "images/inventoryimages/sendiobject_hut.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendiobject_hut.xml"),
	--------센디의 오두막
	Asset( "IMAGE", "images/inventoryimages/sendiobject_warehouse.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendiobject_warehouse.xml"),
	--------센디의 창고
	Asset("ANIM", "anim/csmana.zip"),
	Asset("ANIM", "anim/sendi_ui_chest_4x4.zip"),
	--------------------- ui
	Asset( "IMAGE", "images/inventoryimages/aos_seed.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/aos_seed_purple.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_purple.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/aos_seed_black.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_black.xml"),
	--------------------- 제작시드
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_black.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_black.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_orange.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_orange.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_red.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_red.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_sky.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_sky.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_white.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_white.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_autumn.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_autumn.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_green.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_green.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/aos_seed_boss_yellow.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_boss_yellow.xml"),
				
	Asset( "IMAGE", "images/inventoryimages/aos_seed_middle.tex"), 
	Asset( "ATLAS", "images/inventoryimages/aos_seed_middle.xml"),
	--------------------- 드롭시드
	Asset( "IMAGE", "images/inventoryimages/sendi_food_cocoapowder.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_cocoapowder.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/sendi_food_cocoa_cup.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_cocoa_cup.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_cocoa.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_cocoa.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_wolfsteak.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_wolfsteak.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_wolfsteak_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_wolfsteak_cooked.xml"),	

	--2차 추가 음식들 
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_ricewheat.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_ricewheat.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/sendi_food_bread.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_bread.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_salad_banana.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_salad_banana.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_juice_light_berry.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_juice_light_berry.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_light_berry.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_light_berry.xml"),	
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_light_berry_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_light_berry_cooked.xml"),
		
	Asset( "IMAGE", "images/inventoryimages/sendi_food_cake_banana.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_cake_banana.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_cake_banana_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_cake_banana_cooked.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_pudding_light_berrybanana.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_pudding_light_berrybanana.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_pudding_light_berrybanana_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_pudding_light_berrybanana_cooked.xml"),	
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_eel.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_eel.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_eel_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_eel_cooked.xml"),	
	--3차 전용음식
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_sausage.tex"), --소세지팡
	Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_sausage.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_muffin.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_muffin.xml"),--머핀
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_muffin_cooked.tex"), --완성머핀
	Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_muffin_cooked.xml"),	
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_tuna.tex"), --참치밥 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_tuna.xml"),	
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_rice_tuna_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_rice_tuna_cooked.xml"),--참치비빔
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_but.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_but.xml"),	--식빵
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_bread_but_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_bread_but_cooked.xml"),		--식빵완성
	
	--4차 전용음식
	Asset( "IMAGE", "images/inventoryimages/sendi_food_milk_strong.tex"), --튼튼밀크
	Asset( "ATLAS", "images/inventoryimages/sendi_food_milk_strong.xml"),		
	--5차 전용음식
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_chicken.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_chicken.xml"),--치킨
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_chicken_cooked.tex"), --치킨완성
	Asset( "ATLAS", "images/inventoryimages/sendi_food_chicken_cooked.xml"),	
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_berry.tex"), --파이 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_berry.xml"),	
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_pie_berry_cooked.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_pie_berry_cooked.xml"),--파이완성
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_dumpling.tex"), 
	Asset( "ATLAS", "images/inventoryimages/sendi_food_dumpling.xml"),	--만두
	
	Asset( "IMAGE", "images/inventoryimages/sendi_food_dumpling_cooked.tex"), --만두완성
	Asset( "ATLAS", "images/inventoryimages/sendi_food_dumpling_cooked.xml"),	
	
	--------------------- 전용 음식    
	
	
	Asset( "ATLAS", "images/inventoryimages/sendi_icon_iced.xml"),	
	
	--------------------- 아이콘
	
}
AddMinimapAtlas("images/map_icons/sendi.xml")

---------------- 라이브러리, 함수 오버라이드
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Language =  GetModConfigData("language")
--
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local resolvefilepath = GLOBAL.resolvefilepath
local Recipe = GLOBAL.Recipe
require "util"

local containers = require("containers")
local IsServer = GLOBAL.TheNet:GetIsServer()
--
GLOBAL.SendiForceOverrideSkin = GetModConfigData("skinoverride")

modimport "scripts/tunings_sendi.lua" -- 튜닝 파일 로드

GLOBAL.SENDI_LANGUAGE_SUFFIX = "_en" -- 언어 설정관련
if Language == "AUTO" then
	local KnownModIndex = GLOBAL.KnownModIndex
	for _, moddir in ipairs(KnownModIndex:GetModsToLoad()) do
		local modname = KnownModIndex:GetModInfo(moddir).name
		if modname == "한글 모드 서버 버전" or modname == "한글 모드 클라이언트 버전" then 
			GLOBAL.SENDI_LANGUAGE_SUFFIX = "" -- 한국어
--		elseif modname == "Chinese Language Pack" or modname == "Chinese Plus" then
--			GLOBAL.SENDI_LANGUAGE_SUFFIX = "_ch"
--		elseif modname == "Russian Language Pack" or modname == "Russification Pack for DST" or modname == "Russian For Mods (Client)" then
--			GLOBAL.SENDI_LANGUAGE_SUFFIX = "_ru"
		end 
	end 
else
	GLOBAL.SENDI_LANGUAGE_SUFFIX = Language
end
STRINGS.CHARACTERS.SENDI = require("speech_sendi"..GLOBAL.SENDI_LANGUAGE_SUFFIX ) -- 대사 파일 로드
modimport "scripts/strings_sendi.lua" -- 언어 파일 로드

local Cookable = require "components/cookable"  -- sendi_oven 관련
function Cookable:GetProduct()
    local prefab = nil 
    if self.product ~= nil then 
        prefab = self.product
        if type(self.product) == "function" then
            prefab = self.product(self.inst)
        end
    end 
    return prefab
end 

-- 미트무시 , 옮기지 말아주세요.
		local function is_meat(item)
			return item.components.edible ~= nil  and item.components.edible.foodtype == GLOBAL.FOODTYPE.MEAT 
		end

		local function myBunnymanRetargetFn(inst)
			return GLOBAL.FindEntity(inst, TUNING.PIG_TARGET_DIST,  
				function(guy)
					return inst.components.combat:CanTarget(guy)
						and (
							guy:HasTag("monster") or (
								not guy:HasTag("ignoreMeat") and    --우선순위를 몬스터 상태인지를 판단 후, 고기 라벨이 무시되는 여부를 판단해, 공격하지 않는 상태로 만듭니다.
								guy.components.inventory ~= nil and 
								guy:IsNear(inst, TUNING.BUNNYMAN_SEE_MEAT_DIST) and
								guy.components.inventory:FindItem(is_meat) ~= nil
							)
						)
				end,
				{ "_combat", "_health" },
				nil,
				{ "monster", "player" })
		end

		local function myBunnyBattlecry(combatcmp, target)
			local strtbl =
				target ~= nil and
				not target:HasTag("ignoreMeat") and --- 고기라벨을 무시하고 공격이 없는지를 결정하는 조건을 추가합니다.
				target.components.inventory ~= nil and
				target.components.inventory:FindItem(is_meat) ~= nil and
				"RABBIT_MEAT_BATTLECRY" or
				"RABBIT_BATTLECRY"
			return strtbl, math.random(#STRINGS[strtbl])
		end

		AddPrefabPostInit("bunnyman", function(inst)    -- api를 통해 토끼의 인식 적 기능을 다시 작성하십시오.
			if GLOBAL.TheWorld.ismastersim then
				inst.components.combat:SetRetargetFunction(3, myBunnymanRetargetFn)
				inst.components.combat.GetBattleCryString = myBunnyBattlecry
			end
		end)
--미트무시

--드롭 exp
function TESTFUNCAAA(inst)
   print (inst.name)
end

local mammalia = {"pigman", "bunnyman", "deerclops", "bearger" } -- 포유류인 경우 리스트

local function AddChanceLoot(inst, loots)
	if inst.components.health ~= nil and inst.components.lootdropper ~= nil then
		for i = 1, #loots, 2 do
			inst.components.lootdropper:AddChanceLoot(loots[i], loots[i+1])
		end

		if table.contains(mammalia, inst.prefab) then
			for i = 0, 2 do
				if inst.components.health.maxhealth >= 1000 * i then
					inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
				end
			end
		end
	end
end

AddPrefabPostInit("deerclops",  --[[대상 몬스터 스폰명]] function(inst)
	AddChanceLoot(inst, {"aos_seed_boss_white", 0.5, "aos_seed_boss_sky", 1}) -- (아이템 스폰명), (수량) 순으로 적으면 됨
end)

AddPrefabPostInit("dragonfly", function(inst)
	AddChanceLoot(inst, {"aos_seed_boss_red", 1, "aos_seed_boss_white", 0.5, "aos_seed_boss_sky", 0.5})
end)
--[[
AddPrefabPostInitAny(function(inst)
   if inst.components.health and inst.components.lootdropper and inst.components.health.maxhealth <= 900000 then
      --inst:ListenForEvent("death", TESTFUNCAAA) --몬스터를잡으면 이름이뜸
      
      --inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
		
      if inst.name == STRINGS.NAMES.DEERCLOPS then
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_sky", 1)--디어클롭스
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
      elseif inst.name == STRINGS.NAMES.DRAGONFLY then
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_red", 1) --용파리 
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)
      elseif inst.name == STRINGS.NAMES.BEARGER then
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_autumn", 1) --베어거 
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
      elseif inst.name == STRINGS.NAMES.MOOSE then
		inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.2)

      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_green", 1) --무스구스 
      elseif inst.name == STRINGS.NAMES.ANTLION then
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_orange", 1) --개미사자
      elseif inst.name == STRINGS.NAMES.BEEQUEEN then
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)

      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_yellow", 1) --비퀸 
      
	  
      elseif inst.name == STRINGS.NAMES.STALKER_ATRIUM then
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_black", 1) --퓨얼위버 
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_black", 1) --퓨얼위버 	 
	  
      elseif inst.name == STRINGS.NAMES.TOADSTOOL then
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_black", 1) --토드스툴      
      elseif inst.name == STRINGS.NAMES.TOADSTOOL_DARK then
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_black", 1) --비참한 토드스툴
      
      elseif inst.name == STRINGS.NAMES.KLAUS then
	  inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 0.5)
      inst.components.lootdropper:AddChanceLoot("aos_seed_boss_white", 1) --클라우스     
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
      
      --중보스
      elseif inst.name == STRINGS.NAMES.KRAMPUS then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 0.2) --크람푸스
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
      elseif inst.name == STRINGS.NAMES.MINOTAUR then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 1) --가디언
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
      elseif inst.name == STRINGS.NAMES.SPIDERQUEEN then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 1) --거미여왕  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
      elseif inst.name == STRINGS.NAMES.LEIF then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 1) --트리가드
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  
      elseif inst.name == STRINGS.NAMES.DEER_RED then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 1) --사슴보석   
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
      elseif inst.name == STRINGS.NAMES.DEER_BLUE then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 1) --사슴보석      
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
      elseif inst.name == STRINGS.NAMES.MOSSLING then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 0.5) --모슬링
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
      elseif inst.name == STRINGS.NAMES.LAVAE then
      inst.components.lootdropper:AddChanceLoot("aos_seed_middle", 0.2) --용암이
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
      
      --퍼플잼 
      elseif inst.name == STRINGS.NAMES.BATCAVE then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --박쥐집 
	  
      elseif inst.name == STRINGS.NAMES.GHOST then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --유령         
      elseif inst.name == STRINGS.NAMES.SPIDERDEN then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --거미집   
      elseif inst.name == STRINGS.NAMES.SPIDERDEN_2 then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --거미집   2
      elseif inst.name == STRINGS.NAMES.PIGGUARD then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --미친 피그맨2  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
      elseif inst.name == STRINGS.NAMES.TENTACLE then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --텐타클   
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
      elseif inst.name == STRINGS.NAMES.WORM then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --동굴지렁이  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  
      elseif inst.name == STRINGS.NAMES.FIREHOUND then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --레드하운드    
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
      elseif inst.name == STRINGS.NAMES.ICEHOUND then
      inst.components.lootdropper:AddChanceLoot("aos_seed_purple", 1) --블루하운드    
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
      --블랙잼
      elseif inst.name == STRINGS.NAMES.BATCAVE then
      inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1) --박쥐집         
      elseif inst.name == STRINGS.NAMES.HOUNDMOUND then
      inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1) --하운드마운드      
      elseif inst.name == STRINGS.NAMES.SLURTLEHOLE then
      inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1) --슬러틀마운드      
      elseif inst.name == STRINGS.NAMES.SPIDERDEN_3 then
      inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1) --거미집   
	  elseif inst.name == STRINGS.NAMES.TERRORBEAK then 
	  inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1) --악몽 부리  
	
	  elseif inst.name == STRINGS.NAMES.WARG then 
	  inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1) --바그   	 
	  inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed_black", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
	  
	  --일반시드
	  elseif inst.name == STRINGS.NAMES.KOALEFANT_WINTER then --코알라펀트 
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.KOALEFANT_SUMMER then --코알라펀트 
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  
	  elseif inst.name == STRINGS.NAMES.PERD then --칠면조  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.BISHIOP then --비숍  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.KNIGHT then --나이트
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.ROOK then --룩   
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.WALRUS then --맥터스크 
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.BEEFALO then --비팔로 
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.SPIDER_WARRIOR then --병정거미  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.CRAWLINGHORROR then --크로킹호러  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.TALLBIRD then --톨버드  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.TEENBIRD then --톨버드  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.SMALLBIRD then --톨버드  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.MONKEY then --ㅁㅇ키  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 0.7)
	  elseif inst.name == STRINGS.NAMES.PENGUIN then --팽귄  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  elseif inst.name == STRINGS.NAMES.LIGHTNINGGOAT then --염소   
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.SPAT then --점액양    
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.RABBIT then --토끼    
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.CATCOON then --캣쿤    
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.BAT then --박쥐    
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.BUNNYMAN then --버니맨    
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.PIGMAN then --피그맨  
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.DEER then --눈없는사슴
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.DEERANTLER then --눈없는사슴
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)
	  elseif inst.name == STRINGS.NAMES.HOUND then --하운드 
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 1)
	  inst.components.lootdropper:AddChanceLoot("sendi_food_milk_strong", 1)  
	  elseif inst.name == STRINGS.NAMES.KILLERBEE then
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 0.3) --킬러비
	  elseif inst.name == STRINGS.NAMES.BEE then
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 0.3) --킬러비
	  elseif inst.name == STRINGS.NAMES.BEEGUARD then
	  inst.components.lootdropper:AddChanceLoot("aos_seed", 0.3) --킬러비
	  
      else
      inst.components.lootdropper:AddChanceLoot("aos_seed", 1) --그외 전부 시드 1
      end   
      
      end
end)
]]--

--드롭 exp
function ChangeSkin(inst)
	inst:ChangeSkin()
	--]] -- 태그제거 
end
AddModRPCHandler("sendi", "skin", ChangeSkin)
--센디스킨

STRINGS.NAMES.SENDI = "sendi"
modimport "scripts/sendimana_init.lua"
modimport "scripts/skills_sendi.lua"
modimport "scripts/recipes_sendi.lua"
AddModCharacter("sendi", "FEMALE")