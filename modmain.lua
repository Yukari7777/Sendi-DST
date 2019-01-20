PrefabFiles = {
--센디 전용 아이템등을 추가
	"sendi_classified",
	"sendi",
	"sendi_none",
	--------캐릭터요소---------
	"sendipack", 
	--------기타---------
	"sendisedmask",
	--------모자----------
	"sendi_rapier_wood", --우드 레이피어
	"sendi_rapier", --레이피어
	"sendi_rapier_ignia", --이그니아레이피어
	--------레이피어-----------
	"sendi_armor_01", --센디의 니트 갑옷
	"sendi_armor_02", --센디의 여름용 갑옷
	--------갑옷--------------
	"sendi_oven", -- 센디 오븐
	"sendi_ovenfire_fx", -- 센디 오븐의 불꽃이펙트
	-------오브젝트[오븐]-------
	--"mangotea", --[mangotea] 이름[따끈따끈 코코아] : tea_cocoa
	
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
	
	Asset( "IMAGE", "images/inventoryimages/sendi_armor_01.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_armor_01.xml"),
	-------센디의 니트갑옷 [임의 지정]
	Asset( "IMAGE", "images/inventoryimages/sendi_armor_02.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_armor_02.xml"),
	--------라이프 아머
	
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
	
	--Asset( "IMAGE", "images/inventoryimages/mangotea.tex"),
	--Asset( "ATLAS", "images/inventoryimages/mangotea.xml"),
	--------코코아
	
}
AddMinimapAtlas("images/map_icons/sendi.xml")

---------------- 라이브러리, 함수 오버라이드 (건들지 마세요)
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Language =  GetModConfigData("language")
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

function ChangeSkin(inst)
	inst:ChangeSkin()
end
AddModRPCHandler("sendi", "skin", ChangeSkin)
--센디스킨

STRINGS.NAMES.SENDI = "sendi"
modimport "scripts/skills_sendi.lua"
modimport "scripts/recipes_sendi.lua"
AddModCharacter("sendi", "FEMALE")