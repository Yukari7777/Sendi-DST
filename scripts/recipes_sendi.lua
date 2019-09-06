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
-- AddRecipe("sendi_food_milk_strong", --튼튼밀크
-- {Ingredient("cutgrass", 2)}, 
-- RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 2, "theseedsnill", "images/inventoryimages/sendi_food_milk_strong.xml", "sendi_food_milk_strong.tex")

local sendi_food_milk_strong = Ingredient("sendi_food_milk_strong", 1)
local sendi_food_milk_strong2 = Ingredient("sendi_food_milk_strong", 2)
for k, v in pairs({sendi_food_milk_strong, sendi_food_milk_strong2}) do 
    v.atlas = "images/inventoryimages/sendi_food_milk_strong.xml"
end --밀크


AddRecipe("sendi_food_ricewheat", --벼리밀
{Ingredient("cutgrass", 4), Ingredient("seeds", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 2, "character", "images/inventoryimages/sendi_food_ricewheat.xml", "sendi_food_ricewheat.tex")

local sendi_food_ricewheat = Ingredient("sendi_food_ricewheat", 1)
local sendi_food_ricewheat2 = Ingredient("sendi_food_ricewheat", 2)
local sendi_food_ricewheat4 = Ingredient("sendi_food_ricewheat", 4)
for k, v in pairs({sendi_food_ricewheat, sendi_food_ricewheat2, sendi_food_ricewheat4}) do 
    v.atlas = "images/inventoryimages/sendi_food_ricewheat.xml"
end


AddRecipe("sendi_food_cocoapowder", --코코아 파우더 sendi_food_cocoapowder   
{Ingredient("berries_cooked", 3)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 2, "character", "images/inventoryimages/sendi_food_cocoapowder.xml", "sendi_food_cocoapowder.tex")

local sendi_food_cocoapowder = Ingredient("sendi_food_cocoapowder", 1)
local sendi_food_cocoapowder2 = Ingredient("sendi_food_cocoapowder", 2)

for k, v in pairs({sendi_food_cocoapowder, sendi_food_cocoapowder2}) do 
    v.atlas = "images/inventoryimages/sendi_food_cocoapowder.xml"
end



AddRecipe("sendi_food_cocoa_cup", --조리 되기전의 컵
{sendi_food_cocoapowder2, sendi_food_milk_strong}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_cocoa_cup.xml", "sendi_food_cocoa_cup.tex")

local sendi_food_cocoa_cup = Ingredient("sendi_food_cocoa_cup", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendi_food_cocoa_cup.atlas = "images/inventoryimages/sendi_food_cocoa_cup.xml"

AddRecipe("sendi_food_wolfsteak", --스테이크
{aos_seed, sendi_food_cocoapowder, Ingredient("cookedmonstermeat", 2), sendi_food_milk_strong}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_wolfsteak.xml", "sendi_food_wolfsteak.tex")

local sendi_food_wolfsteak = Ingredient("sendi_food_wolfsteak", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
sendi_food_wolfsteak.atlas = "images/inventoryimages/sendi_food_wolfsteak.xml"

--2차 추가 음식들



AddRecipe("sendi_food_bread", --빵
{sendi_food_ricewheat2, sendi_food_milk_strong}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_bread.xml", "sendi_food_bread.tex")

local sendi_food_bread = Ingredient("sendi_food_bread", 1)
local sendi_food_bread2 = Ingredient("sendi_food_bread", 2)

for k, v in pairs({sendi_food_bread, sendi_food_bread2}) do 
    v.atlas = "images/inventoryimages/sendi_food_bread.xml"
end

AddRecipe("sendi_food_salad_banana", --이끼바나나 샐러드
{Ingredient("cutlichen", 2), Ingredient("cave_banana", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_salad_banana.xml", "sendi_food_salad_banana.tex")

AddRecipe("sendi_food_juice_light_berry", --빛나는 베리 주스
{Ingredient("lightbulb", 2), Ingredient("wormlight_lesser", 2),sendi_food_milk_strong}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_juice_light_berry.xml", "sendi_food_juice_light_berry.tex")

AddRecipe("sendi_food_pie_light_berry", --푸른파이반죽
{Ingredient("wormlight_lesser", 2), sendi_food_ricewheat4, sendi_food_milk_strong}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_pie_light_berry.xml", "sendi_food_pie_light_berry.tex")

AddRecipe("sendi_food_cake_banana", --달콤한 바나나 반죽
{sendi_food_ricewheat2, Ingredient("cave_banana", 1), Ingredient("bird_egg", 1)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_cake_banana.xml", "sendi_food_cake_banana.tex")

AddRecipe("sendi_food_pudding_light_berrybanana", --바나나 푸딩
{Ingredient("bird_egg", 2), sendi_food_milk_strong2}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_pudding_light_berrybanana.xml", "sendi_food_pudding_light_berrybanana.tex")

AddRecipe("sendi_food_rice_eel", --장어와 밥
{sendi_food_ricewheat2, Ingredient("eel_cooked", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_rice_eel.xml", "sendi_food_rice_eel.tex")

---3차 추가음식

AddRecipe("sendi_food_bread_sausage", --소세지빵
{sendi_food_bread, Ingredient("cookedmeat", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_bread_sausage.xml", "sendi_food_bread_sausage.tex")

AddRecipe("sendi_food_bread_muffin", --머핀반죽
{sendi_food_ricewheat2, Ingredient("butterflywings", 2), sendi_food_milk_strong}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_bread_muffin.xml", "sendi_food_bread_muffin.tex")

AddRecipe("sendi_food_bread_but", --식빵반죽
{sendi_food_bread2, Ingredient("seeds_cooked", 2), Ingredient("acorn", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_bread_but.xml", "sendi_food_bread_but.tex")

AddRecipe("sendi_food_rice_tuna", --참치밥
{sendi_food_ricewheat2, Ingredient("fish", 2), Ingredient("carrot", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_rice_tuna.xml", "sendi_food_rice_tuna.tex")
--5차음식 
AddRecipe("sendi_food_chicken", --치킨
{sendi_food_ricewheat4, sendi_food_milk_strong, Ingredient("drumstick_cooked", 4)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_chicken.xml", "sendi_food_chicken.tex")

AddRecipe("sendi_food_pie_berry", --파이
{sendi_food_ricewheat4, sendi_food_milk_strong, Ingredient("berries_cooked", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_pie_berry.xml", "sendi_food_pie_berry.tex")

AddRecipe("sendi_food_dumpling", --만두 
{sendi_food_ricewheat2, Ingredient("cookedsmallmeat", 2), Ingredient("carrot", 2)}, 
RECIPETABS.FARM, TECH.NONE, nil, nil, nil, 1, "character", "images/inventoryimages/sendi_food_dumpling.xml", "sendi_food_dumpling.tex")
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
local aos_seed250 = Ingredient("aos_seed", 250)

for k, v in pairs({aos_seed, aos_seed2, aos_seed10, aos_seed20, aos_seed50, aos_seed100, aos_seed150, aos_seed200, aos_seed250}) do 
    v.atlas = "images/inventoryimages/aos_seed.xml"
end

-----------------------------

AddRecipe("aos_seed_black", --크리에이시드 블랙
{Ingredient("nightmarefuel", 6)}, 
SENDITAB, TECH.NONE, nil, nil, nil, 1, "sendi", "images/inventoryimages/aos_seed_black.xml", "aos_seed_black.tex")

local aos_seed_black = Ingredient("aos_seed_black", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
local aos_seed_black10 = Ingredient("aos_seed_black", 10) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.

for k, v in pairs({aos_seed_black, aos_seed_black10}) do 
    v.atlas = "images/inventoryimages/aos_seed_black.xml"
end


AddRecipe("aos_seed_purple", --크리에이시드 퍼플
{Ingredient("silk", 3), Ingredient("spidergland", 3)}, 
SENDITAB, TECH.NONE, nil, nil, nil, 1, "sendi", "images/inventoryimages/aos_seed_purple.xml", "aos_seed_purple.tex")

local aos_seed_purple = Ingredient("aos_seed_purple", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.

for k, v in pairs({aos_seed_purple}) do 
    v.atlas = "images/inventoryimages/aos_seed_purple.xml"
end

-- AddRecipe("aos_seed_boss_red", --크리에이시드 보스
-- {aos_seed50}, 
-- SENDITAB, TECH.NONE, nil, nil, nil, 1, "sendi", "images/inventoryimages/aos_seed_boss_red.xml", "aos_seed_boss_red.tex")

-- local aos_seed_boss_red = Ingredient("aos_seed_boss_red", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.

-- for k, v in pairs({aos_seed_boss_red}) do 
    -- v.atlas = "images/inventoryimages/aos_seed_boss_red.xml"
-- end

AddRecipe("aos_seed_middle", --크리에이시드 미들제작  2
{aos_seed20}, 
SENDITAB, TECH.NONE, nil, nil, nil, 1, "sendi", "images/inventoryimages/aos_seed_middle.xml", "aos_seed_middle.tex")

local aos_seed_middle12 = Ingredient("aos_seed_middle", 12) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.

for k, v in pairs({aos_seed_middle12}) do 
    v.atlas = "images/inventoryimages/aos_seed_middle.xml"
end

AddRecipe("aos_seed_boss_yellow", --크리에이시드 보스 제작 2
{aos_seed_middle12}, 
SENDITAB, TECH.NONE, nil, nil, nil, 1, "sendi", "images/inventoryimages/aos_seed_boss_yellow.xml", "aos_seed_boss_yellow.tex")

local aos_seed_boss_yellow = Ingredient("aos_seed_boss_yellow", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_yellow}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_yellow.xml"
end

local aos_seed_boss_sky = Ingredient("aos_seed_boss_sky", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_sky}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_sky.xml"
end --스카이

local aos_seed_boss_red = Ingredient("aos_seed_boss_red", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_red}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_red.xml"
end--레드

local aos_seed_boss_autumn = Ingredient("aos_seed_boss_autumn", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_autumn}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_autumn.xml"
end--가을

local aos_seed_boss_green = Ingredient("aos_seed_boss_green", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_green}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_green.xml"
end--봄

local aos_seed_boss_orange = Ingredient("aos_seed_boss_orange", 1) -- YUKARI : 어떤 모드아이템이 재료로 들어가야 할경우 이렇게 추가해야함.
for k, v in pairs({aos_seed_boss_orange}) do 
    v.atlas = "images/inventoryimages/aos_seed_boss_orange.xml"
end--태양
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
{aos_seed50, Ingredient("pigskin", 40), Ingredient("beefalohat", 1)}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_crown.xml", "sendi_hat_crown.tex")   

local MonarchCrown = Ingredient( "sendi_hat_crown", 1) 
MonarchCrown.atlas ="images/inventoryimages/sendi_hat_crown.xml"
---------------------------------- 프랜드 헬멧
AddRecipe("sendi_hat_spider", 
{Ingredient("spidereggsack", 3),Ingredient("hivehat", 1), aos_seed_middle12}, 
SENDITAB, TECH.SCIENCE_TWO, nil, nil, nil, nil, "sendi", "images/inventoryimages/sendi_hat_spider.xml", "sendi_hat_spider.tex")   

local SendiHatspider = Ingredient( "sendi_hat_spider", 1) 
SendiHatspider.atlas ="images/inventoryimages/sendi_hat_spider.xml"

---------------------------------- 스파이더 헬멧

AddRecipe("sendi_hat_goggles", 
{MonarchCrown, SendiHatspider, aos_seed_boss_yellow}, 
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
{sendiarmor, Ingredient("greengem", 6), aos_seed_boss_sky}, 
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
{sendirapier, aos_seed_boss_red, Ingredient("dragon_scales", 2)}, 
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