local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local Recipe = GLOBAL.Recipe
CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT

local SENDITAB = AddRecipeTab(GLOBAL.STRINGS.SENDITABNAME, 777, "images/inventoryimages/senditab.xml", "senditab.tex", "sendi") 
local sendiaos_seed = Ingredient("aos_seed", 1)
-- 전용 레시피탭을 추가.

--일반오브젝트
----------------음식---------------

AddRecipe("sendi_food_cocoapowder", --코코아 파우더 sendi_food_cocoapowder   
{Ingredient("berries_cooked", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_cocoapowder.xml", "sendi_food_cocoapowder.tex")

local sendi_food_cocoapowder = Ingredient("sendi_food_cocoapowder", 2) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendi_food_cocoapowder.atlas = "images/inventoryimages/sendi_food_cocoapowder.xml"


AddRecipe("sendi_food_cocoa_cup", --조리 되기전의 컵
{sendi_food_cocoapowder, Ingredient("ice", 1)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_cocoa_cup.xml", "sendi_food_cocoa_cup.tex")

local sendi_food_cocoa_cup = Ingredient("sendi_food_cocoa_cup", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendi_food_cocoa_cup.atlas = "images/inventoryimages/sendi_food_cocoa_cup.xml"

AddRecipe("sendi_food_wolfsteak", --스테이크
{aos_seed, sendi_food_cocoapowder, Ingredient("cookedmonstermeat", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_wolfsteak.xml", "sendi_food_wolfsteak.tex")

local sendi_food_wolfsteak = Ingredient("sendi_food_wolfsteak", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendi_food_wolfsteak.atlas = "images/inventoryimages/sendi_food_wolfsteak.xml"




-----------------음식---------------
AddRecipe("aos_seed", --크리에이시드   
{Ingredient(CHARACTER_INGREDIENT.SANITY, 20)}, 
SENDITAB, TECH.NONE, nil, nil, nil, 2, "sendi", "images/inventoryimages/aos_seed.xml", "aos_seed.tex")

local aos_seed = Ingredient("aos_seed", 1)
local aos_seed2 = Ingredient("aos_seed", 2)
local aos_seed10 = Ingredient("aos_seed", 10)
local aos_seed20 = Ingredient("aos_seed", 20)
local aos_seed50 = Ingredient("aos_seed", 50)
local aos_seed100 = Ingredient("aos_seed", 100)
local aos_seed150 = Ingredient("aos_seed", 150)
local aos_seed200 = Ingredient("aos_seed", 200)
local aos_seed250 = Ingredient("aos_seed", 200)

for k, v in pairs({aos_seed, aos_seed2, aos_seed10, aos_seed20, aos_seed50, aos_seed100, aos_seed150, aos_seed200}) do 
    v.atlas = "images/inventoryimages/aos_seed.xml"
end

-----------------------------

AddRecipe("aos_seed_black", --크리에이시드 블랙
{Ingredient("nightmarefuel", 6)}, 
RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/aos_seed_black.xml", "aos_seed_black.tex")
local aos_seed_black = Ingredient("aos_seed_black", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
aos_seed_black.atlas = "images/inventoryimages/aos_seed_black.xml"
local aos_seed_black10 = Ingredient("aos_seed_black", 10) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
aos_seed_black.atlas = "images/inventoryimages/aos_seed_black.xml"


AddRecipe("aos_seed_purple", --크리에이시드 퍼플
{Ingredient("silk", 3), Ingredient("spidergland", 3)}, 
RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/aos_seed_purple.xml", "aos_seed_purple.tex")

local aos_seed_purple = Ingredient("aos_seed_purple", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
aos_seed_purple.atlas = "images/inventoryimages/aos_seed_purple.xml"

---------------------------------------------

AddRecipe("sendicampfire",--모닥불
{aos_seed2}, 
SENDITAB, TECH.NONE, "campfire_placer", nil, nil, nil, "sendi", nil, nil, nil, "campfire") 



AddRecipe("senditorch", --횃불 
{aos_seed}, --twigs
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendi", nil, nil, nil, "torch" ) 

AddRecipe("charcoal", --목탄 
{Ingredient("log", 2), aos_seed},  --체력 HEALTH/ 정신 SANITY / log   
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendi" ) 

AddRecipe("twigs", --나무가지 
{Ingredient("log", 1), Ingredient(CHARACTER_INGREDIENT.SANITY, 10)},  --체력 HEALTH/ 정신 SANITY / 허기
SENDITAB, TECH.NONE, nil, nil, nil, 2, "sendi" ) 

----





AddRecipe("sendipack", 
{Ingredient("gears", 2), Ingredient("bedroll_furry", 2), aos_seed100}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendipack.xml", "sendipack.tex")
-- "sendi" 전용태그(이 태그가 있는사람만 제작가능)
-- 이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
-----------------------------------센디 백팩
AddRecipe("sendisedmask", 
{Ingredient("cutstone", 20), Ingredient("marble", 20), aos_seed100}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendisedmask.xml", "sendisedmask.tex")   

local sendisedmask = Ingredient( "sendisedmask", 1) 
sendisedmask.atlas ="images/inventoryimages/sendisedmask.xml"
---------------------------------- 센디 마스크
AddRecipe("sendi_hat_crown", 
{aos_seed50, Ingredient("pigskin", 40), aos_seed_black10}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_crown.xml", "sendi_hat_crown.tex")   

local MonarchCrown = Ingredient( "sendi_hat_crown", 1) 
MonarchCrown.atlas ="images/inventoryimages/sendi_hat_crown.xml"
---------------------------------- 프랜드 헬멧
AddRecipe("sendi_hat_spider", 
{Ingredient("spidereggsack", 3),Ingredient("spiderhat", 1), aos_seed50}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_spider.xml", "sendi_hat_spider.tex")   

local sendihatspider = Ingredient( "sendi_hat_spider", 1) 
sendihatspider.atlas ="images/inventoryimages/sendi_hat_spider.xml"

---------------------------------- 스파이더 헬멧

AddRecipe("sendi_hat_goggles", 
{MonarchCrown, Ingredient("dragon_scales", 2), sendihatspider}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_goggles.xml", "sendi_hat_goggles.tex")   

local frandgoggles = Ingredient( "sendi_hat_goggles", 1) 
frandgoggles.atlas ="images/inventoryimages/sendi_hat_goggles.xml"

---------------------------------- 프랜드 고글



AddRecipe("sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("rabbit", 1), aos_seed50}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex")

local sendiarmor = Ingredient( "sendi_armor_01", 1) 
sendiarmor.atlas ="images/inventoryimages/sendi_armor_01.xml"
---------------------------------- 머플러 아머
AddRecipe("sendi_armor_02", 
{sendiarmor, Ingredient("greengem", 6), Ingredient("deerclops_eyeball", 2)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_armor_02.xml", "sendi_armor_02.tex")

local lifearmor = Ingredient( "sendi_armor_02", 1) 
lifearmor.atlas ="images/inventoryimages/sendi_armor_02.xml"
---------------------------------- 라이프아머


-- AddRecipe("sendi_amulet", 
-- {Ingredient("silk", 6), Ingredient("rabbit", 1), Ingredient("heatrock", 1)}, 
-- SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_amulet.xml", "sendi_amulet.tex")

-- local sendiarmor = Ingredient( "sendi_amulet", 1) 
-- sendiarmor.atlas ="images/inventoryimages/sendi_amulet.xml"
---------------------------------- 아뮬렛 sendi_amulet    



AddRecipe("sendi_rapier_wood", 
{Ingredient("spear", 1), Ingredient("log", 20), Ingredient("rope", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_rapier_wood.xml", "sendi_rapier_wood.tex")

local sendirapierwood = Ingredient( "sendi_rapier_wood", 1)  
sendirapierwood.atlas = "images/inventoryimages/sendi_rapier_wood.xml"
---------------------------------- 목재 레이피어 
AddRecipe("sendi_rapier", 
{sendirapierwood, Ingredient("tentaclespike", 1), aos_seed100}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_rapier.xml", "sendi_rapier.tex")

local sendirapier = Ingredient( "sendi_rapier", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendirapier.atlas = "images/inventoryimages/sendi_rapier.xml"
----------------------------------  센디레이피어 
AddRecipe("sendi_rapier_ignia", 
{sendirapier, aos_seed200, Ingredient("dragon_scales", 2)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_rapier_ignia.xml", "sendi_rapier_ignia.tex")

local igniarapier = Ingredient( "sendi_rapier_ignia", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
igniarapier.atlas = "images/inventoryimages/sendi_rapier_ignia.xml"
---------------------------------- 이그니아 레이피어






AddRecipe("sendi_oven", 
{Ingredient("boards", 10), Ingredient("cutstone", 10), aos_seed50}, 
RECIPETABS.TOWN, TECH.SCIENCE_TWO, "sendi_oven_placer", nil, nil, nil, "sendi", "images/inventoryimages/sendi_oven.xml", "sendi_oven.tex" ) 
---------------------------------- 센디 오븐

AddRecipe("sendiobject_hut", 
{Ingredient("wall_wood_item", 80), Ingredient("hammer", 1), aos_seed100}, 
RECIPETABS.TOWN, TECH.SCIENCE_TWO, "sendiobject_hut_placer", nil, nil, nil, "sendi", "images/inventoryimages/sendiobject_hut.xml", "sendiobject_hut.tex" ) 
---------------------------------- 센디 오두막
AddRecipe("sendiobject_warehouse", 
{Ingredient("wall_stone_item", 18), Ingredient("hammer", 1), aos_seed50}, 
RECIPETABS.TOWN, TECH.SCIENCE_TWO, "sendiobject_warehouse_placer", nil, nil, nil, "sendi", "images/inventoryimages/sendiobject_warehouse.xml", "sendiobject_warehouse.tex" ) 

---------------------------------- 센디 창고

--일반 소모품