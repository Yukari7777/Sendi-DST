local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local Recipe = GLOBAL.Recipe

local SENDITAB = AddRecipeTab(GLOBAL.STRINGS.SENDITABNAME, 777, "images/inventoryimages/senditab.xml", "senditab.tex", "sendicraft") 
-- 전용 레시피탭을 추가.

AddRecipe("sendipack", 
{Ingredient("gears", 2), Ingredient("bedroll_furry", 2), Ingredient("purplegem", 1)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendipack.xml", "sendipack.tex")
-- "sendicraft"는 전용태그 뜻한다. YUKARI : 전용탭x, 전용태그(이 태그가 있는사람만 제작가능)
-- 이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
-----------------------------------센디 백팩




AddRecipe("sendisedmask", 
{Ingredient("cutstone", 20), Ingredient("marble", 20), Ingredient("nightmarefuel", 20)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendisedmask.xml", "sendisedmask.tex")	

local sendisedmask = Ingredient( "sendisedmask", 1) 
sendisedmask.atlas ="images/inventoryimages/sendisedmask.xml"
---------------------------------- 센디 마스크
AddRecipe("sendi_hat_crown", 
{Ingredient("goldnugget", 40), Ingredient("pigskin", 40), Ingredient("carrot", 40)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_hat_crown.xml", "sendi_hat_crown.tex")	

local MonarchCrown = Ingredient( "sendi_hat_crown", 1) 
MonarchCrown.atlas ="images/inventoryimages/sendi_hat_crown.xml"
---------------------------------- 프랜드 헬멧
AddRecipe("sendi_hat_goggles", 
{MonarchCrown, Ingredient("dragon_scales", 1), Ingredient("deserthat", 1)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_hat_goggles.xml", "sendi_hat_goggles.tex")	

local frandgoggles = Ingredient( "sendi_hat_goggles", 1) 
frandgoggles.atlas ="images/inventoryimages/sendi_hat_goggles.xml"

---------------------------------- 프랜드 고글
AddRecipe("sendi_hat_spider", 
{MonarchCrown, Ingredient("spiderhat", 1), Ingredient("nightmarefuel", 20)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_hat_spider.xml", "sendi_hat_spider.tex")	

local sendihatspider = Ingredient( "sendi_hat_spider", 1) 
sendihatspider.atlas ="images/inventoryimages/sendi_hat_spider.xml"

---------------------------------- 스파이더 헬멧




AddRecipe("sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("rabbit", 1), Ingredient("heatrock", 1)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex")

local sendiarmor = Ingredient( "sendi_armor_01", 1) 
sendiarmor.atlas ="images/inventoryimages/sendi_armor_01.xml"
---------------------------------- 머플러 아머
AddRecipe("sendi_armor_02", 
{sendiarmor, Ingredient("bluegem", 10), Ingredient("deerclops_eyeball", 2)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_02.xml", "sendi_armor_02.tex")

local lifearmor = Ingredient( "sendi_armor_02", 1) 
lifearmor.atlas ="images/inventoryimages/sendi_armor_02.xml"
---------------------------------- 라이프아머





AddRecipe("sendi_rapier_wood", 
{Ingredient("spear", 1), Ingredient("log", 20), Ingredient("rope", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_wood.xml", "sendi_rapier_wood.tex")

local sendirapierwood = Ingredient( "sendi_rapier_wood", 1)  
sendirapierwood.atlas = "images/inventoryimages/sendi_rapier_wood.xml"
---------------------------------- 목재 레이피어 
AddRecipe("sendi_rapier", 
{sendirapierwood, Ingredient("tentaclespike", 1), Ingredient("goldnugget", 20)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier.xml", "sendi_rapier.tex")

local sendirapier = Ingredient( "sendi_rapier", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendirapier.atlas = "images/inventoryimages/sendi_rapier.xml"
----------------------------------  센디레이피어 
AddRecipe("sendi_rapier_ignia", 
{sendirapier, Ingredient("redgem", 10), Ingredient("dragon_scales", 2)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_ignia.xml", "sendi_rapier_ignia.tex")

local igniarapier = Ingredient( "sendi_rapier_ignia", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
igniarapier.atlas = "images/inventoryimages/sendi_rapier_ignia.xml"
---------------------------------- 이그니아 레이피어

AddRecipe("sendi_oven", 
{Ingredient("boards", 10), Ingredient("cutstone", 10), Ingredient("purplegem", 1)}, 
SENDITAB, TECH.SCIENCE_TWO, "sendi_oven_placer", nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_oven.xml", "sendi_oven.tex" ) 
---------------------------------- 센디 오븐

AddRecipe("sendiobject_hut", 
{Ingredient("log", 40), Ingredient("rope", 5), Ingredient("boards", 5)}, 
SENDITAB, TECH.SCIENCE_TWO, "sendi_oven_placer", nil, nil, nil, "sendicraft", "images/inventoryimages/sendiobject_hut.xml", "sendiobject_hut.tex" ) 
---------------------------------- 센디 오두막
AddRecipe("sendiobject_warehouse", 
{Ingredient("log", 40), Ingredient("rope", 5), Ingredient("boards", 5)}, 
SENDITAB, TECH.SCIENCE_TWO, "sendi_oven_placer", nil, nil, nil, "sendicraft", "images/inventoryimages/sendiobject_hut.xml", "sendiobject_hut.tex" ) 
---------------------------------- 센디 창고

