PrefabFiles = {
	"sendi",
	"sendi_none",
	"sendipack", 	--nanapack
	"sendisedmask",
	"sendi_armor_01", --SENDI_ARMOR_01	(SENDI_ARMOR_01)
	"sendi_rapier",
		--nanacap
}

--STRINGS.CHARACTERS.GENERIC.DESCRIBE.ONPICKUPSENDIARMOR = "이건 나의 물건이 아닌걸?" -- 센디외의 캐릭터가 물건들을 주웠을때 말하는 내용
--STRING.CHARACTERS.WX78.DESCRIBE.ONPICKUPSENDIARMOR = "이건 내것이 아님. 주인을 찾아줘야함." -- 캐릭터 설정이 가능. GENERIC를 캐릭터이름으로 바꾸자.

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

}

AddMinimapAtlas("images/map_icons/sendi.xml")

-- The character select screen lines
-- 센디가 만들수있는 레시피를 뜻하는듯합니다. 

---센디의 커스텀을 만듭니다 시작 
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TheWorld = GLOBAL.TheWorld

local TimeEvent = GLOBAL.TimeEvent
local ACTIONS = GLOBAL.ACTIONS
local State = GLOBAL.State
local BufferedAction = GLOBAL.BufferedAction
local ActionHandler = GLOBAL.ActionHandler
local EventHandler = GLOBAL.EventHandler
local FRAMES = GLOBAL.FRAMES

local RECIPETABS = GLOBAL.RECIPETABS
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local Recipe = GLOBAL.Recipe

local containers = require("containers")
local oldwidgetsetup = containers.widgetsetup
containers.widgetsetup = function(container, prefab)
    if not prefab and container.inst.prefab == "sendipack" then
        prefab = "backpack"
		-- 센디의 가방 크기 : backpack[일반 가방], krampus_sack[크람푸스 가방]
    end
    oldwidgetsetup(container, prefab)
end

STRINGS.NAMES.SENDISEDMASK = "센디의 눈물 마스크"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDISEDMASK = "이건 많은 사연이 있어. 음.. 알려주지 않을래."
-- 센디 마스크
STRINGS.NAMES.SENDI_ARMOR_01 = "센디의 니트갑옷" -- STRINGS.NAMES : 지정할 이름 
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SENDI_ARMOR_01 = "..! 이 머플러, 사실은 옷이야!" --DESCRIBE : 말하게 하는 명령어

STRINGS.NAMES.SENDIPACK = "센디의 책가방"
STRINGS.NAMES.SENDISEDMASK = "센디의 눈물 마스크"
STRINGS.NAMES.SENDI_ARMOR_01 = "센디의 니트갑옷"
--캐릭터 아이템의 이름을 지정합니다. 
                  --[    아래  ]  이자리엔 지정할 이름이 들어갑니다.
--캐릭터 아이템의 이름을 지정합니다. 끝 


	-- 센디 아머 [임의 추가] 
STRINGS.CHARACTER_TITLES.sendi = "The Sample Character"
STRINGS.CHARACTER_NAMES.sendi = "Esc"
STRINGS.CHARACTER_DESCRIPTIONS.sendi = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.sendi = "\"Quote\""

	--레시피를 뜻합니다.
	
local sendipack = Recipe("sendipack", {Ingredient("gears", 2), Ingredient("piggyback", 1)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendipack.xml", "sendipack.tex")
STRINGS.RECIPE_DESC.SENDIPACK = "센디의 하얀 가방 입니다. [냉장고]"
				-- nil, nil, nil, nil, "sendicraft" 여기서 "sendicraft"는 센디의 전용탭을 뜻한다.


local sendisedmask = Recipe("sendisedmask", 
{ Ingredient("cutstone", 4), Ingredient("marble", 4)}, 
					--이름, 재료, 탭, 기술 수준, 설치자, min_spacing, nounlock, 제작 시 주는 갯수, [ 재료란 builder_tag, atlas, image, testfn, product]
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendisedmask.xml", "sendisedmask.tex")	
STRINGS.RECIPE_DESC.SENDISEDMASK = "슬픈 사연이 담긴 마스크.[방수 25%]"
-- SURVIVAL[생존] DRESS[ 드레스 ]

-- AddRecipe 
AddRecipe("sendi_armor_01", 
{Ingredient("silk", 6), Ingredient("beefalowool", 4), Ingredient("manrabbit_tail", 2)}, 
RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "images/inventoryimages/sendi_armor_01.xml", "sendi_armor_01.tex")
STRINGS.RECIPE_DESC.SENDI_ARMOR_01 = "센디의 니트갑옷 입니다.[매우 따뜻해요.]" 
		
		--위가 안됄시
		--local sendi_armor_01 = Recipe("sendi_armor_01", 
		--{Ingredient("재료1", 재료1갯수), Ingredient("재료2", 재료2갯수), Ingredient("재료3", 재료3갯수)}, 
		--RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "아이콘 xml 경로", "아이콘 tex 경로")


---센디 아이템 명령 탬플릿

-- AddRecipe("이름", 
--{Ingredient("재료1", 재료1갯수), Ingredient("재료2", 재료2갯수)}, 
--RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "sendicraft", "이미지 xml 경로", "이미지 tex 경로")

---센디의 커스텀을 만듭니다 끝


-- Custom speech strings
STRINGS.CHARACTERS.SENDI = require "speech_sendi" -- 캐릭터의 대사집을 지정합니다

-- The character's name as appears in-game 
STRINGS.NAMES.SENDI = "sendi"

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("sendi", "FEMALE")


------------- skills --------------
function rapier(inst)
	if not inst:HasTag("inskill") and not inst.sg:HasStateTag("doing") then
		-- 랙걸리는 이유 : 액션이 실패하면 움직여선 안되니까?
		-- 점프아웃 커스텀 액션(실패시 physics stop을 위해서)
		
	end
end
AddModRPCHandler("sendi", "rapier", rapier)

local RAPIER = AddAction("RAPIER", "rapier", function(act)
	return true
end)
RAPIER.canforce = true

local state_rapier = State { 
	name = "rapier",
	tags = { "doing", "attack", "skill" },

	onenter = function(inst)
		print("onenter")
		inst:AddTag("inskill")
		inst.components.locomotor:Stop()
		if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(false)
        end
		inst.AnimState:PlayAnimation("jump_pre")
		inst.AnimState:PlayAnimation("jumpout")
		inst.Physics:SetMotorVel(0, 0, 0)
		
		inst.sg.statemem.action = inst.bufferedaction
		inst.sg:SetTimeout(2)
		if inst.HUD ~= nil then	
			print("is client")
			inst:PerformPreviewBufferedAction()
		end
		
		if TheWorld ~= nil and TheWorld.ismastersim then
			inst:PerformBufferedAction()
		end
	end,

	timeline =
	{
		TimeEvent(4 * FRAMES, function(inst)
			inst.sg:RemoveStateTag("busy")
		end),
		TimeEvent(9 * FRAMES, function(inst)
			
		end),
		TimeEvent(15.2 * FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
		end),
		TimeEvent(18 * FRAMES, function(inst)
			--inst.Physics:Stop()
		end),
	},
	
	events = {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
	
	onupdate = function(inst)
		if inst.HUD ~= nil then
			if inst:HasTag("doing") then
				if inst.entity:FlattenMovementPrediction() then
					inst.sg:GoToState("idle", "noanim")
				end
			elseif inst.bufferedaction == nil then
				inst.sg:GoToState("idle", true)
			end
		end
	end,
	
	ontimeout = function(inst)
		if inst.HUD ~= nil then
			inst:ClearBufferedAction()
		end
		inst.sg:GoToState("idle")
		inst.Physics:Stop()
		inst.Physics:SetMotorVel(0, 0, 0)
	end,
	
	onexit = function(inst)
		inst:RemoveTag("inskill")
		if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:Enable(true)
        end
		if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
		end
		inst.sg.statemem.action = nil
	end,
}
AddStategraphState("wilson", state_rapier)
AddStategraphState("wilson_client", state_rapier)
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.RAPIER, "rapier"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.RAPIER, "rapier"))