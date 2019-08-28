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
	--"mangotea", --[mangotea] 이름[따끈따끈 코코아] : tea_cocoa
	"aos_seed",
	"aos_seed_purple",	
	"aos_seed_black",	
	
	"aos_seed_boss_black",
	"aos_seed_boss_orange",
	"aos_seed_boss_red",
	"aos_seed_boss_sky",
	"aos_seed_boss_white",
	
	"aos_seed_middle",
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

	Asset( "ATLAS", "images/inventoryimages/sendi_icon_iced.xml"),	
	--------------------- 전용 음식    
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

function ChangeSkin(inst)
	inst:ChangeSkin()
end
AddModRPCHandler("sendi", "skin", ChangeSkin)
--센디스킨

STRINGS.NAMES.SENDI = "sendi"
modimport "scripts/sendimana_init.lua"
modimport "scripts/skills_sendi.lua"
modimport "scripts/recipes_sendi.lua"
AddModCharacter("sendi", "FEMALE")