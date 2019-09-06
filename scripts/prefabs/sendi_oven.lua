require "prefabutil"
local TechTree = require("techtree") --레시피 더미

local assets =
{
	Asset("ANIM", "anim/sendi_oven.zip"),
	Asset("ANIM", "anim/ui_chester_shadow_3x4.zip"),
}

local prefabs = {
    "sendi_ovenfire",
	"sendi_ovenfire_cold",
    "collapse_small",
}

local containers = require "containers"	
local slotpos = {}
for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

local sendi_oven = {
    widget = {
        slotpos = slotpos,
		animbank = "ui_chester_shadow_3x4",
		animbuild = "ui_chester_shadow_3x4",
        pos = Vector3(0, 180, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

local _widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
	if container.inst.prefab == "sendi_oven" or prefab == "sendi_oven" then
		data = sendi_oven
		
		for k,v in pairs(sendi_oven) do
			container[k] = v
		end
		container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
		return
	else
		return _widgetsetup(container, prefab, data, ...)
	end
end

local function cooked(inst)
	
	local container = inst.components.container

	if not inst.on_cold then
		for i = 1, container:GetNumSlots() do
			local item = container:GetItemInSlot(i)
			if item then 
				local replacement = nil 
				
				if item.components.cookable or
				item.prefab == "spoiled_food" or
				item.prefab == "sendi_food_cocoa_cup" or 
				item.prefab == "sendi_food_wolfsteak" or
				--음식
				item.prefab == "sendi_food_pie_light_berry" or
				item.prefab == "sendi_food_cake_banana" or
				item.prefab == "sendi_food_rice_eel" or
				--2차음식
				item.prefab == "sendi_food_bread_muffin" or
				item.prefab == "sendi_food_rice_tuna_cooked" or
				item.prefab == "sendi_food_bread_but" or
				--3차음식 
				item.prefab == "sendi_food_chicken" or
				item.prefab == "sendi_food_pie_berry" or
				item.prefab == "sendi_food_dumpling" or
				--5차 
				
				item.prefab == "log" then  --붕괴 애니메이션
					inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 
					local fx = SpawnPrefab("collapse_small")
					local pos = Vector3(inst.Transform:GetWorldPosition())
					fx.Transform:SetScale(0.5, 0.5, 0.5)
					fx.Transform:SetPosition(pos:Get())
	
					local fx2 = SpawnPrefab("emote_fx")
					fx2.entity:SetParent(inst.entity)
					fx2.Transform:SetPosition(0, 3, 0)
				end
				
				------------------------------------------------------------------------------------------------
				if item.components.cookable then 
				replacement = item.components.cookable:GetProduct()
				
				
				elseif item.prefab == "log" then  --나무를 넣으면
					replacement = "charcoal" --숯이나옴
				--1차추가음식
				elseif item.prefab == "sendi_food_cocoa_cup" then -- 컵을 넣으면
					replacement = "sendi_food_cocoa" 
				elseif item.prefab == "sendi_food_wolfsteak" then -- 스테이크를 넣으면
					replacement = "sendi_food_wolfsteak_cooked" 
				-- 2차 추가 음식들	
					
				elseif item.prefab == "sendi_food_pie_light_berry" then -- 푸른파이반죽
					replacement = "sendi_food_pie_light_berry_cooked" --					
				elseif item.prefab == "sendi_food_cake_banana" then -- 바나나반죽
					replacement = "sendi_food_cake_banana_cooked" --
				elseif item.prefab == "sendi_food_rice_eel" then --장어와 밥
					replacement = "sendi_food_rice_eel_cooked" --	
				
				--3차 추가 음식들
				
				elseif item.prefab == "sendi_food_bread_muffin" then --머핀
					replacement = "sendi_food_bread_muffin_cooked" --
				elseif item.prefab == "sendi_food_rice_tuna" then --참치비빔밥 
					replacement = "sendi_food_rice_tuna_cooked" --
				elseif item.prefab == "sendi_food_bread_but" then --식빵
					replacement = "sendi_food_bread_but_cooked" --
					
					--5차 추가음식들
				elseif item.prefab == "sendi_food_chicken" then --머핀
					replacement = "sendi_food_chicken_cooked" --
				elseif item.prefab == "sendi_food_pie_berry" then --참치비빔밥 
					replacement = "sendi_food_pie_berry_cooked" --
				elseif item.prefab == "sendi_food_dumpling" then --식빵
					replacement = "sendi_food_dumpling_cooked" --	
				

				--------------------------------------------------------------------------------------------------
				

				
				elseif item.components.burnable and not item.prefab == "log" then  ---불이 꺼졌는데 나무를 넣는다면
					replacement = "ash"	--변화가 일어나지않음.
					
				elseif item.components.burnable and not item.prefab == "spoiled_food" then 
					replacement = "ash"	
					
				elseif item.components.burnable and not item.prefab == "sendi_food_cocoa_cup" then 
					replacement = "ash"		

				elseif item.components.burnable and not item.prefab == "sendi_food_wolfsteak" then 
					replacement = "ash"							

	
					
				
				-- 2차 추가 음식들

				elseif item.components.burnable and not item.prefab == "sendi_food_pie_light_berry" then 
					replacement = "ash"		

				elseif item.components.burnable and not item.prefab == "sendi_food_cake_banana" then 
					replacement = "ash"		

				elseif item.components.burnable and not item.prefab == "sendi_food_rice_eel" then 
					replacement = "ash"							
					
					
				-- 3차 추가 음식들

				elseif item.components.burnable and not item.prefab == "sendi_food_bread_muffin" then 
					replacement = "ash"		

				elseif item.components.burnable and not item.prefab == "sendi_food_rice_tuna" then 
					replacement = "ash"		

				elseif item.components.burnable and not item.prefab == "sendi_food_bread_but" then 
					replacement = "ash"		
				--5차추가음식들
				
				elseif item.components.burnable and not item.prefab == "sendi_food_chicken" then 
					replacement = "ash"		

				elseif item.components.burnable and not item.prefab == "sendi_food_pie_berry" then 
					replacement = "ash"		

				elseif item.components.burnable and not item.prefab == "sendi_food_dumpling" then 
					replacement = "ash"	
				
				end  
				
				
				
				
				--------------------------------------------------------------------------------------------------
				
				
				if replacement then 
					local stacksize = 1 
					if item.components.stackable then 
						stacksize = item.components.stackable:StackSize()
					end 

					local newprefab = SpawnPrefab(replacement)
					if newprefab.components.stackable then 
						newprefab.components.stackable:SetStackSize(stacksize)
					end 
					container:RemoveItemBySlot(i)
					item:Remove()
					container:GiveItem(newprefab, i)
				end 
			end 
		end 
		return false 
	end 

	if inst.on_cold then ------------------찬불일떄
		for i = 1, container:GetNumSlots() do
			local item = container:GetItemInSlot(i)
			if item then 
				local replacement = nil  --애니메이션
				if item.prefab == "watermelon" or 
				item.prefab == "butter" or 
				item.prefab == "cave_banana" or
				item.prefab == "sendi_food_cocoa" or
				item.prefab == "sendi_food_pudding_light_berrybanana" then 
					inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") 
					local fx = SpawnPrefab("collapse_small")
					local pos = Vector3(inst.Transform:GetWorldPosition())
					fx.Transform:SetScale(0.5, 0.5, 0.5)
					fx.Transform:SetPosition(pos:Get())
				end
				
				if item.prefab == "watermelon" then 
					replacement = "watermelonicle"
				elseif item.prefab == "butter" then 
					replacement = "icecream"
				elseif item.prefab == "cave_banana" then  --
					replacement = "bananapop"	
				--음식
				elseif item.prefab == "sendi_food_cocoa" then --코코아를넣으면
					replacement = "sendi_food_cocoa_cold"--아이스코코아~
				elseif item.prefab == "sendi_food_pudding_light_berrybanana" then --푸른 바나나 푸딩을 넣으면
					replacement = "sendi_food_pudding_light_berrybanana_cooked"	-- 베리나 푸딩
				--시드변환				
					
				end  

				if replacement then 
					local stacksize = 1 
					if item.components.stackable then 
						stacksize = item.components.stackable:StackSize()
					end 
					local newprefab = SpawnPrefab(replacement)
					if newprefab.components.stackable then 
						newprefab.components.stackable:SetStackSize(stacksize)
					end 
					container:RemoveItemBySlot(i)
					item:Remove()
					container:GiveItem(newprefab, i)
				end 
			end 
		end 
		return false 
	end 
end
	
local function onopen(inst) 
	if not inst.burning then
		inst.AnimState:SetBuild("sendi_oven_open")
	end
	inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
	--inst.SoundEmitter:PlaySound("dontstarve/common/craftable/icebox_open")
end 

local function onclose(inst) 
	if inst.burning then
		cooked(inst)
	end
	if not inst.burning then
		inst.AnimState:SetBuild("sendi_oven")
	end
	inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
	--inst.SoundEmitter:PlaySound("dontstarve/common/craftable/icebox_close")		
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	local ash = SpawnPrefab("ash")
	ash.Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local function OnHaunt(inst, haunter)
    if math.random() <= TUNING.HAUNT_CHANCE_RARE and
        inst.components.fueled ~= nil and
        not inst.components.fueled:IsEmpty() then
			inst.components.fueled:DoDelta(TUNING.MED_FUEL)
			inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function onhit(inst, worker)
	inst.components.container:DropEverything()
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle")
end

local function onignite(inst)
	inst.burning = true
	inst.AnimState:SetBuild("sendi_oven_open")
    if not inst.components.cooker then
        inst:AddComponent("cooker")
    end
end

local function on_fire(inst, data)
	if not inst.on_fire and inst.components.burnable:IsBurning() then
		inst.components.burnable:Extinguish() 
		inst:RemoveComponent("burnable") 
	end

	if not inst.components.burnable then
		inst:AddComponent("burnable")
	end

	inst.on_fire = true
	inst.on_cold = false
	inst:RemoveTag("fridge")
	inst.components.talker:Say("[[Warm Fire]]\nOven-(On)")
	inst.components.burnable:AddBurnFX("sendi_ovenfire", Vector3(0,0,0) )
end
local function on_cold(inst, data)
	if not inst.on_cold and inst.components.burnable:IsBurning() then
		inst.components.burnable:Extinguish() 
		inst:RemoveComponent("burnable") 
	end

	if not inst.components.burnable then
		inst:AddComponent("burnable") 
	end

	inst.on_cold = true
	inst.on_fire = false
	inst:AddTag("fridge")
	inst.components.talker:Say("[[Cold Fire]]\nCooler Box-(On)")
	inst.components.burnable:AddBurnFX("sendi_ovenfire_cold", Vector3(0,0,0) )
end

local function onextinguish(inst)
	inst.burning = false
	inst.AnimState:SetBuild("sendi_oven")
    if inst.components.cooker then
        inst:RemoveComponent("cooker")
    end
    if inst.components.fueled then
        inst.components.fueled:InitializeFuelLevel(0)
    end
end

--[[
local function Add_SendiChef(inst, observer)
	if observer:HasTag("sendi") then -- 오라를 받는 대상의 조건
		observer:AddTag("sendichef")
		--observer:DoTaskInTime(10, observer:AddTag("sendichef"))
		
		end
		--observer:RemoveTag("sendichef")
		--observer:DoTaskInTime(3, observer:RemoveTag("sendichef"))
	return 0
end
--]]

--태그제거

local SENDICHEFTAGSETTER = function(inst, inrng, outrng)
   local x, y, z = inst.Transform:GetWorldPosition()
   local target
   local inrange = TheSim:FindEntities(x, y, z, inrng, { "sendi" } )
   local outrange = TheSim:FindEntities(x, y, z, outrng, { "sendi" } )
   for k, v in pairs(outrange) do
      v:RemoveTag("sendichef")
   end
   for k, v in pairs(inrange) do
      v:AddTag("sendichef")
   end
end

--]]

local function fn(Sim)

   local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
	
	--[[
	inst.MiniMapEntity:SetIcon( "sendi_oven.tex" )--발견한 자신의 미니맵 이름 /
	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aurafn = Add_SendiChef
	
	-- inst:AddComponent("prototyper")
	-- inst.components.prototyper.trees = TechTree.Create({SENDICRAFT = 1})
	--]]
	
	SENDICHEFTAGSETTER(inst, 5, 10) --태그제거 
	--]]
	
    MakeObstaclePhysics(inst, .3)

    inst:AddTag("campfire")
    inst:AddTag("structure")
	inst:AddTag("wildfireprotected")
    inst:AddTag("oven")--오븐태그
	
    inst.AnimState:SetBank("sendi_oven")
    inst.AnimState:SetBuild("sendi_oven")
    inst.AnimState:PlayAnimation("idle", false)    
    inst.MiniMapEntity:SetIcon( "sendi_oven.tex" )

    -----------------------
    inst:AddComponent("burnable")
    --inst.components.burnable:SetFXLevel(2)
	
	if not inst.on_cold then
		inst.components.burnable:AddBurnFX("sendi_ovenfire", Vector3(0,0,0) )
	elseif inst.on_cold then
		inst.components.burnable:AddBurnFX("sendi_ovenfire_cold", Vector3(0,0,0) )
	end
   
    inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
		
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = on_fire
    inst.components.machine.turnofffn = on_cold
    inst.components.machine.cooldowntime = 0	

	inst:AddComponent("talker")
    inst.components.talker.fontsize = 30
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, 1, 1, 1)
    inst.components.talker.offset = Vector3(0, -500, 0)
    inst.components.talker.symbol = "swap_object"

   	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()
	-------------------------
 	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("sendi_oven", sendi_oven)
   
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    
      -------------------------
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)    

    -------------------------
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
    
    inst.components.fueled:SetSections(5)
    inst.components.fueled.bonusmult = 5
    inst.components.fueled.ontakefuelfn = function() 
		inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")  
		local fx2 = SpawnPrefab("small_puff")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(0, 3, 0)
	end
    inst.components.fueled.rate = 1

    inst.components.fueled:SetUpdateFn( function()
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
        end
    end)
    inst.components.fueled:InitializeFuelLevel(TUNING.FIREPIT_FUEL_START)    
    
    -----------------------------

    inst:AddComponent("hauntable")
    inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_HUGE
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    -----------------------------   
    
    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = function(inst)
        local sec = inst.components.fueled:GetCurrentSection()
        if sec == 0 then 
            return "OUT"
        elseif sec <= 4 then
            local t = {"EMBERS","LOW","NORMAL","HIGH"}
            return t[sec]
        end
    end
    
    inst:ListenForEvent("onbuilt",function()
        inst.AnimState:PlayAnimation("place")
        inst.AnimState:PushAnimation("idle",false)
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end)
    
    return inst
end

return Prefab( "common/objects/sendi_oven", fn, assets, prefabs),
		MakePlacer( "common/sendi_oven_placer", "chiminea", "sendi_oven", "preview" ) 
