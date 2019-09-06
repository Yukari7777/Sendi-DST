local CONST = TUNING.SENDI
local food = {
    test = { -- 템 이름
        foodtype = FOODTYPE.MEAT, -- FOODTYPE.MEAT 고기 | FOODTYPE.VEGGIE 야채 | FOODTYPE.GOODIES 물건
        health = 100, -- 체력
        hunger = 100, -- 허기
        sanity = 100, -- 정신력
        mana = CONST.MANA_RESTORE_FULL, -- 마나(기본 마나 회복 규칙을 무시)
        perishtime = 5000, -- 유통 기간

        -- 기타옵션
        rotten = "seeds", -- 썩으면 변할 물건 (썩은 것으로 변하게 할거면 안적어도 됨)
        tags = { "testest", "cattoy", "nobait" }, --붙일 태그들 | nobait 태그 : 넣었을경우 미끼가 아니게 됨.
        floater = {"small", nil, nil}, --바다에 뜨는 성질 설정
        temperature = TUNING.HOT_FOOD_BONUS_TEMP, -- 시원한 음식에는 TUNING.COLD_FOOD_BONUS_TEMP
        temperatureduration = TUNING.FOOD_TEMP_LONG, -- TUNING.FOOD_TEMP_BRIEF 짧음 | TUNING.FOOD_TEMP_AVERAGE 중간 | TUNING.FOOD_TEMP_LONG 길음
        cooktime = .5, --요리시간 (미트볼 0.75)
        -- stacksize = 3, -- 스택 최대크기, 기본값 TUNING.STACK_SIZE_SMALLITEM (40)
        fuelvalue = 90, -- 불 넣었을때 불 타는 양 (통나무 = 7.5, 풀떼기 = 7.5)
        fertlizermult = 1, -- 비료 수치(ㄸ을 기준으로 비율, 썩은것 = 0.25ㄸ, 구아노 = 1.5ㄸ )
        asset = "cocoa_cup", -- 에셋파일 경로(외형 파일 이름)
        oneatenfn = function(inst, eater) -- 먹었을 때 실행 함수
            --eater.components.talker:Say("마싯다.")
        end,
    },
   --프리팹
    cocoapowder = {
        foodtype = FOODTYPE.VEGGIE,
        health = -1,
        hunger = 5,
        sanity = 5,
        perishtime = TUNING.PERISH_SLOW,
        tags = {"caffeine", "cattoy", "sendistaple", "fuel"}, -- caffeine 태그 : 플레이어가 아닌 엔티티가 먹으면 디버프가 걸리는 이스터 에그
        floater = {"small", nil, nil},
      exp = 1,
    }, --마법의가루   

   ricewheat = {
        foodtype = FOODTYPE.VEGGIE,
        health = 0,
        hunger = 3,
        sanity = -10,
        perishtime = TUNING.PERISH_SLOW,
        tags = {"cattoy", "sendistaple", "fuel"},
        floater = {"small", nil, nil},
      exp = 1,
      
    }, --벼리밀
	
    milk_strong = {
        foodtype = FOODTYPE.VEGGIE,
        health = 5,
        hunger = 7,
        sanity = 0,
        perishtime = TUNING.PERISH_SLOW,
        tags = {"cattoy", "sendistaple", "fuel"},
        floater = {"small", nil, nil},
      exp = 1,
    }, --튼튼밀크 
   
   ---재료
    cocoa_cup = {
        foodtype = FOODTYPE.VEGGIE,
        health = 0,
        hunger = 25,
        sanity = 0,
        perishtime = 480,
        tags = {"caffeine", "unfinished", "fuel"},
		rotten = "sendi_food_cocoa",
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_BRIEF,
		exp = 2,
      
    }, --코코아 얼음컵

    cocoa = { 
        foodtype = FOODTYPE.VEGGIE,
        health = 20,
        hunger = 35,
        sanity = 15,
        perishtime = 2700,
        tags = {"caffeine", "cattoy", "preparedfood", "sendistaple", "fuel"}, -- preparedfood 태그 : 오븐(쿡팟)에 조리된 음식
        floater = {"small", nil, nil},
        temperature = TUNING.HOT_FOOD_BONUS_TEMP * 2,
        temperatureduration = TUNING.FOOD_TEMP_BRIEF,
      exp = 4,
    },-- 오븐에 구운 코코아 컵

    cocoa_cold = { 
        foodtype = FOODTYPE.VEGGIE,
        health = 7,
        hunger = 35,
        sanity = 30,
        perishtime = 2700,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "ovencold", "preparedfood", "fuel"}, -- ovencold 태그 : 오븐에 의해 차가워진 음식
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
      exp = 4,
        asset = "cocoa", -- 기본 코코아(sendi_food_cocoa) 이미지를 사용
    },-- 냉오븐에 들어간 코코아

    wolfsteak = {
        foodtype = FOODTYPE.MEAT,
        health = -5,
        hunger = 55,
        sanity = -10,
        perishtime = 960,
        tags = {"preparedfood", "monstermeat", "unfinished", "fuel"},
        rotten = "sendi_food_wolfsteak_cooked",
        floater = {"small", nil, nil},
		exp = 2,
    },

    wolfsteak_cooked = { --조리된 울프스테이크
        foodtype = FOODTYPE.MEAT,
        health = 10,
        hunger = 65,
        sanity = 10,
        perishtime = 3360,
        cooktime = 2,
        tags = {"preparedfood", "monstermeat", "sendimeat", "preparedfood", "fuel"},
        floater = {"small", nil, nil},
      exp = 4,
    },--울프스테이크
   
   --2차 추가 음식들
   
   bread = {
        foodtype = FOODTYPE.VEGGIE,
        health = 0,
        hunger = 20,
        sanity = 5,
        perishtime = 3360,
        tags = {"caffeine", "cattoy", "sendistaple", "fuel"},
        floater = {"small", nil, nil},
      exp = 2,
      
    }, --빵
   
   salad_banana = {
        foodtype = FOODTYPE.VEGGIE,
        health = 15,
        hunger = 30,
        sanity = 0,
        perishtime = 1900,
      temperature = TUNING.COLD_FOOD_BONUS_TEMP, -- 시원한 음식에는 TUNING.COLD_FOOD_BONUS_TEMP
        tags = {"caffeine", "cattoy", "sendistaple", "fuel"},
        floater = {"small", nil, nil},
      exp = 4,
    }, --이끼 바나나 샐러드,
   
   juice_light_berry = {
        foodtype = FOODTYPE.VEGGIE,
        health = 0,
        hunger = 15,
        sanity = 15,
        perishtime = 1900,
      temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        tags = {"caffeine", "cattoy", "sendistaple", "fuel"},
        floater = {"small", nil, nil},
      
              oneatenfn = function(inst, eater)
            if eater.wormlight then
                eater.wormlight.components.spell.lifetime = 0
                eater.wormlight.components.spell:ResumeSpell()
            else
                local light = SpawnPrefab("wormlight_light")
                light.components.spell:SetTarget(eater)
                if not light.components.spell.target then
                    light:Remove()
                end
                light.components.spell:StartSpell()
            end
        end,
      exp = 4,
      
    }, -- 빛나는 베리 주스
   
   pie_light_berry = {
        foodtype = FOODTYPE.VEGGIE,
        health = -5,
        hunger = 55,
        sanity = -10,
        perishtime = 2660,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
      exp = 6,
    }, -- 조리전의 빛나는 베리 파이
   
   pie_light_berry_cooked = {
        foodtype = FOODTYPE.VEGGIE,
        health = 10,
        hunger = 65,
        sanity = 30,
        perishtime = 5320,
        tags = {"caffeine", "cattoy", "sendifood", "preparedfood", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.HOT_FOOD_BONUS_TEMP,
      oneatenfn = function(inst, eater)
            if eater.wormlight then
                eater.wormlight.components.spell.lifetime = 0
                eater.wormlight.components.spell:ResumeSpell()
            else
                local light = SpawnPrefab("wormlight_light")
                light.components.spell:SetTarget(eater)
                if not light.components.spell.target then
                    light:Remove()
                end
                light.components.spell:StartSpell()
            end
        end,
      exp = 9,
    }, -- 빛나는 베리 파이
   
   cake_banana = {
        foodtype = FOODTYPE.VEGGIE,
        health = -5,
        hunger = 32,
        sanity = -10,
        perishtime = 2660,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
      exp = 4,
    }, -- 바나나 반죽
      
   cake_banana_cooked = {
        foodtype = FOODTYPE.VEGGIE,
        health = 10,
        hunger = 42,
        sanity = 20,
        perishtime = 5320,
        tags = {"caffeine", "cattoy", "sendifood", "preparedfood", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.HOT_FOOD_BONUS_TEMP,
      exp = 8,
  }, -- 바나나 롤 케익

   pudding_light_berrybanana = {
        foodtype = FOODTYPE.VEGGIE,
        health = -5,
        hunger = 32,
        sanity = -10,
        perishtime = 1440,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		exp = 2,
      
    }, -- 베리 바나나 푸딩
   
   pudding_light_berrybanana_cooked = {
        foodtype = FOODTYPE.VEGGIE,
        health = 15,
        hunger = 42,
        sanity = 30,
        perishtime = 3360,
        tags = {"caffeine", "cattoy", "sendifood", "preparedfood", "ovencold", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP * 2,
   
		exp = 4,
    }, -- 바나나 푸딩
   
   rice_eel = {
        foodtype = FOODTYPE.MEAT,
        health = 5,
        hunger = 45,
        sanity = -5,
        perishtime = 2660,   
        temperature = TUNING.HOT_FOOD_BONUS_TEMP, 
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
      exp = 6,
    }, -- 장어와 밥
   
   rice_eel_cooked = {
        foodtype = FOODTYPE.MEAT,
        health = 30,
        hunger = 55,
        sanity = 10,
      temperature = TUNING.HOT_FOOD_BONUS_TEMP * 2,
        perishtime = 5320,
        tags = {"caffeine", "monstermeat", "sendifood", "sendimeat", "fuel"}, 
        floater = {"small", nil, nil},
      exp = 12,
    }, -- 장어 덮밥
   
   
   ---------3차 음식
 
 
   bread_sausage = {
        foodtype = FOODTYPE.MEAT,
        health = 10,
        hunger = 50,
        sanity = 0,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP * 2,
        perishtime = 5320,
        tags = {"caffeine", "monstermeat", "sendistaple", "fuel"},
        floater = {"small", nil, nil},
      exp = 4,
    }, -- 소세지빵
	
	bread_muffin = { 
        foodtype = FOODTYPE.VEGGIE,
        health = 5,
        hunger = 40,
        sanity = -5,
        perishtime = 1440,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"}, -- ovencold 태그 : 오븐에 의해 차가워진 음식
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
      exp = 3,
    },-- 버터-풀 머핀 반죽  
	
	
	bread_muffin_cooked = {
        foodtype = FOODTYPE.MEAT,
        health = 20,
        hunger = 50,
        sanity = 5,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP * 2,
        perishtime = 3360,
        tags = {"caffeine", "sendifood", "preparedfood", "fuel"},
        floater = {"small", nil, nil},
      exp = 5,
    }, -- 버터-풀 머핀
	
	bread_but = { 
        foodtype = FOODTYPE.VEGGIE,
        health = 0,
        hunger = 52,
        sanity = -5,
        perishtime = 2400,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		exp = 4,

		
    },-- 호토리식빵 반죽 
	
	bread_but_cooked = {
        foodtype = FOODTYPE.MEAT,
        health = 5,
        hunger = 62,
        sanity = 5,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
        perishtime = 6720,
        tags = {"caffeine", "monstermeat", "sendistaple", "preparedfood", "fuel"},
        floater = {"small", nil, nil},
		exp = 5,
    }, -- 호토리 식빵

	rice_tuna = {
        foodtype = FOODTYPE.MEAT,
        health = 5,
        hunger = 45,
        sanity = 0,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
        perishtime = 3360,
        tags = {"caffeine", "unfinished", "fuel"},
        floater = {"small", nil, nil},
		exp = 4,
    }, -- 참치와 밥 
	
	rice_tuna_cooked = {
        foodtype = FOODTYPE.MEAT,
        health = 20,
        hunger = 55,
        sanity = 5,
      temperature = TUNING.HOT_FOOD_BONUS_TEMP * 2,
        perishtime = 6720,
        tags = {"caffeine", "sendimeat", "preparedfood", "fuel"},
        floater = {"small", nil, nil},
      exp = 8,
    }, -- 참치 비빔밥
	-- 5차 추가음식
	
	chicken = { 
        foodtype = FOODTYPE.VEGGIE,
        health = -10,
        hunger = 60,
        sanity = -0,
        perishtime = 3360,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
      exp = 3,
    },-- 치킨

	chicken_cooked = { 
        foodtype = FOODTYPE.VEGGIE,
        health = 20,
        hunger = 70,
        sanity = 0,
        perishtime = 6720,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "preparedfood", "sendimeat", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
      exp = 6,
    },-- 치킨완성 

	pie_berry = { 
        foodtype = FOODTYPE.VEGGIE,
        health = -5,
        hunger = 50,
        sanity = -5,
        perishtime = 2660,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
      exp = 2,
    },-- 베리 파이 

	pie_berry_cooked = { 
        foodtype = FOODTYPE.VEGGIE,
        health = 5,
        hunger = 60,
        sanity = 20,
        perishtime = 5320,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "preparedfood", "sendifood", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
      exp = 5,
    },-- 베리파이 완성

	dumpling = { 
        foodtype = FOODTYPE.VEGGIE,
        health = -10,
        hunger = 54,
        sanity = -5,
        perishtime = 2400,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "unfinished", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
      exp = 3,
    },-- 만두 

	dumpling_cooked = { 
        foodtype = FOODTYPE.VEGGIE,
        health = 0,
        hunger = 64,
        sanity = 0,
        perishtime = 5600,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "preparedfood", "sendimeat", "fuel"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
      exp = 6,
    },-- 만두 완성 

	
	

	
	
   
   
}

for k, v in pairs(food) do 
    v.name = k 
end

local prefabs = {
    "spoiled_food",
}

function MakeFood(data)
    local name = data.name
    local pname = "sendi_food_"..name
    local fname = "sendi_food_"..(data.asset or name)
    local atlas = "images/inventoryimages/"..fname..".xml"

    local assets = {
        Asset("ANIM", "anim/"..fname..".zip"),
        Asset("ATLAS", atlas),
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        if data.tags ~= nil then
            for i,v in pairs(data.tags) do
                inst:AddTag(v)
            end
        end
        inst:AddTag("sendicook")

        inst.AnimState:SetBank(fname)
        inst.AnimState:SetBuild(fname)
        inst.AnimState:PlayAnimation("idle", true)

        if data.floater ~= nil then
            MakeInventoryFloatable(inst, data.floater[1], data.floater[2], data.floater[3])
        else
            MakeInventoryFloatable(inst)
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        if not inst:HasTag("nobait") then
          inst:AddComponent("bait")
        end

        inst:AddComponent("inspectable")
        inst:AddComponent("tradable")

        if data.fuelvalue ~= nil then
          inst:AddComponent("fuel")
          inst.components.fuel.fuelvalue = data.fuelvalue
        end

        if data.fertlizermult ~= nil then
          inst:AddComponent("fertilizer")
          inst.components.fertilizer.fertilizervalue = TUNING.POOP_FERTILIZE * data.fertlizermult
          inst.components.fertilizer.soil_cycles = TUNING.POOP_SOILCYCLES * data.fertlizermult
          inst.components.fertilizer.withered_cycles = TUNING.POOP_WITHEREDCYCLES * data.fertlizermult
        end

        inst:AddComponent("edible")
        inst.components.edible.healthvalue = data.health
        inst.components.edible.hungervalue = data.hunger
        inst.components.edible.sanityvalue = data.sanity
        inst.components.edible.foodtype = data.foodtype or FOODTYPE.GENERIC
        inst.components.edible.temperaturedelta = data.temperature or 0
        inst.components.edible.temperatureduration = data.temperatureduration or 0
        local function OnEaten(inst, eater) 
            local uppername = eater.prefab == "wilson" and "GENERIC" or string.upper(eater.prefab)
            local quote = STRINGS.CHARACTERS[uppername] ~= nil and STRINGS.CHARACTERS[uppername].ONEATSENDIFOOD[string.upper(data.name)]
            if quote then
                eater:DoTaskInTime(math.random(0.3, 1), eater.components.talker:Say(quote))
            end

            if data.exp ~= nil and eater.components.sendilevel ~= nil then
                eater.components.sendilevel:AddExp(data.exp)
            end

            if data.oneatenfn ~= nil then
                data.oneatenfn(inst, eater)
            end
        end
        inst.components.edible:SetOnEatenFn(OnEaten)
        inst.sendimana = data.mana
         
        inst.components.edible.cooktime = data.cooktime

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(data.perishtime)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = data.rotten or "spoiled_food"

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = fname
        inst.components.inventoryitem.atlasname = atlas

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
        
        MakeHauntableLaunch(inst)
        
        return inst
    end

    return Prefab(pname, fn, assets, prefabs)
end

local prefs = {}
for k, v in pairs(food) do
    table.insert(prefs, MakeFood(v))
end

return unpack(prefs)