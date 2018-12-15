PrefabFiles = {
	"sendi_classified",
	"sendi",
	"sendi_none",
	--------캐릭터요소---------
	"sendipack", 
	--------기타---------
	"sendisedmask",
	--------모자----------
	"sendi_rapier", -- SENDI_RAPIER
	"sendi_rapier_wood", 
	"sendi_rapier_ignia", --이그니아 레이피어 SENDI_RAPIER_IGNIA	
	--------레이피어-----------
	"sendi_armor_01", --센디의 니트 갑옷
	"sendi_armor_02", --센디의 여름용 갑옷

	"sendi_oven", -- 센디 오븐
	"sendi_ovenfire_fx", -- 센디 오븐의 불꽃이펙트
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
	
	Asset( "IMAGE", "images/inventoryimages/sendi_rapier.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_rapier.xml"),
	--------센디의 레이피어
	
	Asset( "IMAGE", "images/inventoryimages/sendi_rapier_wood.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_rapier_wood.xml"),
	--------연습용 목재 레이피어
	Asset( "IMAGE", "images/inventoryimages/sendi_armor_02.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_armor_02.xml"),
	--------이그니아 레이피어
	Asset( "IMAGE", "images/inventoryimages/sendi_rapier_ignia.tex"),
	Asset( "ATLAS", "images/inventoryimages/sendi_rapier_ignia.xml"),
	--------센디오븐
	Asset("ANIM", "anim/sendi_oven.zip"),
	Asset("ANIM", "anim/sendi_oven_open.zip"),
	Asset("ANIM", "anim/sendi_oven_fire.zip"),
	Asset("ANIM", "anim/sendi_oven_fire_cold.zip"),
	Asset("ATLAS", "images/inventoryimages/sendi_oven.xml"),

}
AddMinimapAtlas("images/map_icons/sendi.xml")

---------------- 라이브러리, 함수 오버라이드 (건들지 마세요)
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Language =  GetModConfigData("language")

GLOBAL.SENDI_LANGUAGE_SUFFIX = "_en" -- 언어 설정관련
if Language == "AUTO" then
	local KnownModIndex = GLOBAL.KnownModIndex
	for _, moddir in ipairs(KnownModIndex:GetModsToLoad()) do
		local modname = KnownModIndex:GetModInfo(moddir).name
		if modname == "한글 모드 서버 버전" or modname == "한글 모드 클라이언트 버전" then 
			GLOBAL.SENDI_LANGUAGE_SUFFIX = "" -- 한국어
--		elseif modname == "Chinese modname Pack" or modname == "Chinese Plus" then
--			GLOBAL.SENDI_LANGUAGE_SUFFIX = "_ch"
--		elseif modname == "Russian modname Pack" or modname == "Russification Pack for DST" or modname == "Russian For Mods (Client)" then
--			GLOBAL.SENDI_LANGUAGE_SUFFIX = "_ru"
		end 
	end 
else
	GLOBAL.SENDI_LANGUAGE_SUFFIX = Language
end
STRINGS.CHARACTERS.SENDI = require("speech_sendi"..GLOBAL.SENDI_LANGUAGE_SUFFIX ) -- 대사 파일 로드
modimport "scripts/string_sendi.lua" -- 언어 파일 로드

local Cookable = require "components/cookable"  -- sendi_oven 관련
function Cookable:GetProduct()
    local prefab = nil 
    if self.product then 
        prefab = self.product
        if type(self.product) == "function" then
            prefab = self.product(self.inst)
        end
    end 
    return prefab
end 

--------------------레시피시작
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local Recipe = GLOBAL.Recipe

local SENDITAB = AddRecipeTab(STRINGS.SENDITABNAME, 777, "images/inventoryimages/senditab.xml", "senditab.tex", "sendicraft") 
-- 전용 레시피탭을 추가.

AddRecipe("sendipack", 
{Ingredient("gears", 2), Ingredient("bedroll_furry", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendipack.xml", "sendipack.tex")
-- "sendicraft"는 전용태그 뜻한다. YUKARI : 전용탭x, 전용태그(이 태그가 있는사람만 제작가능)
-- 이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
STRINGS.RECIPE_DESC.SENDIPACK = "센디의 하얀 가방 입니다. [냉장고]"
-----------------------------------센디 백팩
AddRecipe("sendisedmask", 
{Ingredient("cutstone", 4), Ingredient("marble", 4)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendisedmask.xml", "sendisedmask.tex")	
-- RECIPETABS.SURVIVAL[생존탭], RECIPETABS.DRESS[드레스탭], RECIPETABS.LIGHT[조명탭], SENDITAB[센디 전용탭]
STRINGS.RECIPE_DESC.SENDISEDMASK = "슬픈 사연이 담긴 마스크.[방수 25%]"
---------------------------------- 센디 마스크
AddRecipe("sendi_rapier_wood", 
{Ingredient("spear", 1), Ingredient("log", 8), Ingredient("rope", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_wood.xml", "sendi_rapier_wood.tex")
STRINGS.RECIPE_DESC.SENDI_RAPIER_WOOD = "센디의 연습용 레이피어 입니다."
---------------------------------- 목재 레이피어 
local sendirapierwood = Ingredient( "sendi_rapier_wood", 1) 
sendirapierwood.atlas ="images/inventoryimages/sendi_rapier_wood.xml"

AddRecipe("sendi_rapier", 
{sendirapierwood, Ingredient("tentaclespike", 1), Ingredient("hambat", 1)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier.xml", "sendi_rapier.tex")
STRINGS.RECIPE_DESC.SENDI_RAPIER = "센디의 레이피어 입니다."
----------------------------------  레이피어 
local sendiarmor = Ingredient( "sendi_armor_01", 1) 
sendiarmor.atlas ="images/inventoryimages/sendi_armor_01.xml"

AddRecipe("sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("rabbit", 1), Ingredient("heatrock", 1)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex")
STRINGS.RECIPE_DESC.SENDI_ARMOR_01 = "센디의 갑옷 입니다.[보온+이속]" 
---------------------------------- 머플러 아머
AddRecipe("sendi_armor_02", 
{sendiarmor, Ingredient("bluegem", 8), Ingredient("heatrock", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_02.xml", "sendi_armor_02.tex")
STRINGS.RECIPE_DESC.SENDI_ARMOR_02 = "센디의 라이프아머 입니다.[따뜻,시원+이속]" 
---------------------------------- 라이프아머 
local sendirapier = Ingredient( "sendi_rapier", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendirapier.atlas ="images/inventoryimages/sendi_rapier.xml"

AddRecipe("sendi_rapier_ignia", 
{sendirapier, Ingredient("nightsword", 1), Ingredient("redgem", 12)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_ignia.xml", "sendi_rapier_ignia.tex")
STRINGS.RECIPE_DESC.SENDI_RAPIER_IGNIA = "불타는 레이피어 입니다.[불꽃지속딜]" 
-- STRINGS.RECIPE_DESC.sendi_rapier_ignia <<<<<<<<<<<<<<<<<<<<<<<< 안됩니다. 대문자로 써주세요.
---------------------------------- 이그니아 레이피어
AddRecipe("sendi_oven", 
{Ingredient("rocks", 10), Ingredient("froglegs", 5), Ingredient("purplegem", 1) }, 
SENDITAB, TECH.SCIENCE_TWO, "sendi_oven_placer", nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_oven.xml", "sendi_oven.tex" ) 
STRINGS.RECIPE_DESC.SENDI_OVEN = "센디의오븐입니다다다다다다다다다다다다다다다다다다다다다다다다다" --적절한 어그로(수정바람)
---------------------------------- 센디 오븐

STRINGS.NAMES.SENDI = "sendi"
AddModCharacter("sendi", "FEMALE")

modimport "scripts/action_sendi.lua"