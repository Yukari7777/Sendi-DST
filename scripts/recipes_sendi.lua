local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local Recipe = GLOBAL.Recipe

local SENDITAB = AddRecipeTab(GLOBAL.STRINGS.SENDITABNAME, 777, "images/inventoryimages/senditab.xml", "senditab.tex", "sendicraft") 
-- 전용 레시피탭을 추가.

AddRecipe("sendipack", 
{Ingredient("gears", 2), Ingredient("bedroll_furry", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendipack.xml", "sendipack.tex")
-- "sendicraft"는 전용태그 뜻한다. YUKARI : 전용탭x, 전용태그(이 태그가 있는사람만 제작가능)
-- 이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
-----------------------------------센디 백팩
AddRecipe("sendisedmask", 
{Ingredient("cutstone", 4), Ingredient("marble", 4)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendisedmask.xml", "sendisedmask.tex")	
-- RECIPETABS.SURVIVAL[생존탭], RECIPETABS.DRESS[드레스탭], RECIPETABS.LIGHT[조명탭], SENDITAB[센디 전용탭]
---------------------------------- 센디 마스크
AddRecipe("sendi_rapier_wood", 
{Ingredient("spear", 1), Ingredient("log", 8), Ingredient("rope", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_wood.xml", "sendi_rapier_wood.tex")
---------------------------------- 목재 레이피어 
local sendirapierwood = Ingredient( "sendi_rapier_wood", 1) 
sendirapierwood.atlas = "images/inventoryimages/sendi_rapier_wood.xml"

AddRecipe("sendi_rapier", 
{sendirapierwood, Ingredient("tentaclespike", 1), Ingredient("hambat", 1)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier.xml", "sendi_rapier.tex")
----------------------------------  레이피어 
local sendiarmor = Ingredient( "sendi_armor_01", 1) 
sendiarmor.atlas ="images/inventoryimages/sendi_armor_01.xml"

AddRecipe("sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("rabbit", 1), Ingredient("heatrock", 1)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex")
---------------------------------- 머플러 아머
AddRecipe("sendi_armor_02", 
{sendiarmor, Ingredient("bluegem", 8), Ingredient("heatrock", 2)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_02.xml", "sendi_armor_02.tex")
---------------------------------- 라이프아머 
local sendirapier = Ingredient( "sendi_rapier", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendirapier.atlas = "images/inventoryimages/sendi_rapier.xml"

AddRecipe("sendi_rapier_ignia", 
{sendirapier, Ingredient("nightsword", 1), Ingredient("redgem", 12)}, 
SENDITAB, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_rapier_ignia.xml", "sendi_rapier_ignia.tex")

---------------------------------- 이그니아 레이피어
AddRecipe("sendi_oven", 
{Ingredient("boards", 10), Ingredient("cutstone", 10), Ingredient("purplegem", 1) }, 
SENDITAB, TECH.SCIENCE_TWO, "sendi_oven_placer", nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_oven.xml", "sendi_oven.tex" ) 
---------------------------------- 센디 오븐