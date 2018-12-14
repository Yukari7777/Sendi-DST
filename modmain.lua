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
	"sendi_rapier_ignia",--이그니아 레이피어 SENDI_RAPIER_IGNIA	
	--------레이피어-----------
	"sendi_armor_01", --센디의 니트 갑옷
	"sendi_armor_02", --센디의 여름용 갑옷
	"sendi_rapier_ignia",--이그니아 레이피어 SENDI_RAPIER_IGNIA		

	"sendi_oven", -- 센디 오븐
}

--캐릭터 아이템의 이름을 지정합니다. 
                  --[    아래  ]  이자리엔 지정할 이름이 들어갑니다.
GLOBAL.STRINGS.NAMES.SENDIPACK = "센디의 책가방"
GLOBAL.STRINGS.NAMES.SENDISEDMASK = "센디의 눈물 마스크"
GLOBAL.STRINGS.NAMES.SENDI_ARMOR_01 = "센디의 니트갑옷"
GLOBAL.STRINGS.NAMES.SENDI_RAPIER = "센디의 레이피어"
GLOBAL.STRINGS.NAMES.SENDI_RAPIER_WOOD = "연습용 목재 레이피어"
GLOBAL.STRINGS.NAMES.SENDI_ARMOR_02 = "센디의 라이프아머"
GLOBAL.STRINGS.NAMES.SENDI_RAPIER_IGNIA = "이그니아 레이피어"

--캐릭터 아이템의 이름을 지정합니다. 끝 

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

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Language =  GetModConfigData("language")

local containers = GLOBAL.require("containers")
local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab)
    if not prefab and container.inst.prefab == "sendipack" then
        prefab = "backpack"
		-- 센디의 가방 크기 : backpack[일반 가방], krampus_sack[크람푸스 가방]
    end
    oldwidgetsetup(container, prefab)
end

-- The character select screen lines
-- 센디가 만들수있는 레시피를 뜻하는듯합니다. 

STRINGS.CHARACTER_TITLES.sendi = "센디"
STRINGS.CHARACTER_NAMES.sendi = "센디"
STRINGS.CHARACTER_DESCRIPTIONS.sendi = "이동속도가 빠르지만, 데미지와 체력이 약하며 허기가 빨리 감소합니다!\n배가 부르면 밤, 혹은 동굴에서 몸에 희미한 빛을 냅니다.[허기가 더 빨리 감소]\n낮~저녁에 체력을 빠르게 회복합니다!"
STRINGS.CHARACTER_QUOTES.sendi = "\"원래 세계로 돌아갈 때까지\n저의 여행은 멈추지 않을 거예요!\""

---센디의 커스텀을 만듭니다 시작 
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local resolvefilepath = GLOBAL.resolvefilepath
local Recipe = GLOBAL.Recipe

	GLOBAL.STRINGS.NAMES.SENDISEDMASK = "센디의 눈물 마스크"
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDISEDMASK = "이 마스크엔 많은 사연이 있어."
	-- 센디 마스크
	GLOBAL.STRINGS.NAMES.SENDI_ARMOR_01 = "센디의 니트갑옷" -- STRINGS.NAMES : 지정할 이름 
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_01 = "이 머플러, 사실은 내 옷이야!" --DESCRIBE : 말하게 하는 명령어
	-- 센디 아머 [임의 추가] 
	GLOBAL.STRINGS.NAMES.SENDI_RAPIER = "센디의 레이피어" -- STRINGS.NAMES : 지정할 이름 
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER = "내가 애용하던것과 닮은 레이피어야! 수제지만 예쁘지?" --DESCRIBE : 말하게 하는 명령어
	--센디 레이피어
	GLOBAL.STRINGS.NAMES.SENDI_RAPIER_WOOD = "연습용 목재 레이피어" -- STRINGS.NAMES : 지정할 이름 
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_WOOD = "연습할때 쓰던걸 본따 만들었어. 그래도 쓸만 하다구!" --DESCRIBE : 말하게 하는 명령어	
	--센디 연습용 목재 레이피어
	GLOBAL.STRINGS.NAMES.SENDIPACK = "센디의 책가방" -- STRINGS.NAMES : 지정할 이름 
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDIPACK = "귀여운 가방이야. 냉장고 기능도 있어! 과학은 정말 대단해!" --DESCRIBE : 말하게 하는 명령어	
	--센디팩
	GLOBAL.STRINGS.NAMES.SENDI_ARMOR_02 = "센디의 라이프아머" -- STRINGS.NAMES : 지정할 이름 
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_02 = "기존의 갑옷의 갑옷보다 조금더 튼튼하고 효율적으로 만들었어!" --DESCRIBE : 말하게 하는 명령어
	-- 센디 아머 [임의 추가] 
	GLOBAL.STRINGS.NAMES.SENDI_RAPIER_IGNIA = "이그니아 레이피어" -- STRINGS.NAMES : 지정할 이름 
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_RAPIER_IGNIA = "이그니아의 힘을 실채화 시킨 레이피어야! 조금 과격한가?" --DESCRIBE : 말하게 하는 명령어		
	--센디 오븐
	GLOBAL.STRINGS.NAMES.MUSHA_OVEN = "센디의 오븐" -- STRINGS.NAMES : 지정할 이름 
	GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_OVEN = "한번에 구워 버리는거야! 여러번 구우면 귀찮잖아?" --DESCRIBE : 말하게 하는 명령어		
	
	
--------------------레시피시작

local sendipack = GLOBAL.Recipe("sendipack", {Ingredient("gears", 2), Ingredient("bedroll_furry", 2)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendipack.xml", "sendipack.tex")
STRINGS.RECIPE_DESC.SENDIPACK = "센디의 하얀 가방 입니다. [냉장고]"
				-- nil, nil, nil, nil, "sendicraft" 여기서 "sendicraft"는 센디의 전용탭을 뜻한다.
				
-----------------------------------센디의 책가방
-- 내 목숨을 아이어에
-----------------------------------센디 백팩
--이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
local sendisedmask = GLOBAL.Recipe("sendisedmask", 
{ Ingredient("cutstone", 4), Ingredient("marble", 4)}, 
			
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendisedmask.xml", "sendisedmask.tex")	
STRINGS.RECIPE_DESC.SENDISEDMASK = "슬픈 사연이 담긴 마스크.[방수 25%]"
-- SURVIVAL[생존] DRESS[ 드레스 ]

AddRecipe("sendi_rapier_wood", 
{Ingredient("spear", 1), Ingredient("log", 8), Ingredient("rope", 2)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_wood.xml", "sendi_rapier_wood.tex")
STRINGS.RECIPE_DESC.SENDI_RAPIER_WOOD = "센디의 연습용 레이피어 입니다."

---------------------------------- 목재 레이피어 

local sendirapierwood = Ingredient( "sendi_rapier_wood", 1) 
sendirapierwood.atlas ="images/inventoryimages/sendi_rapier_wood.xml"

AddRecipe("sendi_rapier", 
{sendirapierwood, Ingredient("tentaclespike", 1), Ingredient("hambat", 1)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier.xml", "sendi_rapier.tex")
STRINGS.RECIPE_DESC.SENDI_RAPIER = "센디의 레이피어 입니다."

----------------------------------  레이피어 
local sendiarmor = Ingredient( "sendi_armor_01", 1) 
sendiarmor.atlas ="images/inventoryimages/sendi_armor_01.xml"

AddRecipe("sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("rabbit", 1), Ingredient("heatrock", 1)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex")
STRINGS.RECIPE_DESC.SENDI_ARMOR_01 = "센디의 갑옷 입니다.[보온+이속]" 

---------------------------------- 머플러 아머
AddRecipe("sendi_armor_02", 
{sendiarmor, Ingredient("bluegem", 8), Ingredient("heatrock", 2)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_02.xml", "sendi_armor_02.tex")
STRINGS.RECIPE_DESC.SENDI_ARMOR_02 = "센디의 라이프아머 입니다.[따뜻,시원+이속]" 
		
---------------------------------- 라이프아머 
		
local sendirapier = Ingredient( "sendi_rapier", 1) -- 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendirapier.atlas ="images/inventoryimages/sendi_rapier.xml"

AddRecipe("sendi_rapier_ignia", 
{sendirapier, Ingredient("nightsword", 1), Ingredient("redgem", 12)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_ignia.xml", "sendi_rapier_ignia.tex")
STRINGS.RECIPE_DESC.sendi_rapier_ignia = "불타는 레이피어 입니다.[불꽃지속딜]"
---------------------------------- 이그니아 레이피어

local sendi_oven = AddRecipe("sendi_oven", { glowdust3, Ingredient("rocks", 10), Ingredient("froglegs", 5), Ingredient("purplegem", 1) }, RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO, "sendi_oven_placer" ) 
sendi_oven.atlas = "images/inventoryimages/sendi_oven.xml"
sendi_oven.tagneeded = false
sendi_oven.builder_tag ="sendi"

---------------------------------- 센디 오븐

local _SUFFIX = "_en"
if Language == "AUTO" then
	local KnownModIndex = GLOBAL.KnownModIndex
	for _, moddir in ipairs(KnownModIndex:GetModsToLoad()) do
		local modname = KnownModIndex:GetModInfo(moddir).name
		if modname == "한글 모드 서버 버전" or modname == "한글 모드 클라이언트 버전" then 
			_SUFFIX = "" -- 한국어
--		elseif modname == "Chinese modname Pack" or modname == "Chinese Plus" then
--			_SUFFIX = "_ch"
--		elseif modname == "Russian modname Pack" or modname == "Russification Pack for DST" or modname == "Russian For Mods (Client)" then
--			_SUFFIX = "_ru"
		end 
	end 
else
	_SUFFIX = Language
end
STRINGS.CHARACTERS.SENDI = require("speech_sendi".._SUFFIX )

-- The character's name as appears in-game 
STRINGS.NAMES.SENDI = "sendi"

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("sendi", "FEMALE")

modimport "scripts/action_sendi.lua"