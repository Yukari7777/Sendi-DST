local food = {
    test = { -- 템 이름
        foodtype = FOODTYPE.MEAT, -- FOODTYPE.MEAT 고기 | FOODTYPE.VEGGIE 야채 | FOODTYPE.GOODIES 물건
        health = 100, -- 체력
        hunger = 100, -- 허기
        sanity = 100, -- 정신력
        perishtime = 5000, -- 유통 기간
        cooktime = .5, --요리시간 (미트볼 0.75)
        tags = { "testest", "cattoy" }, --붙일 태그들
        floater = {"small", nil, nil}, --바다에 뜨는 성질 설정
        temperature = TUNING.HOT_FOOD_BONUS_TEMP, -- 시원한 음식에는 TUNING.COLD_FOOD_BONUS_TEMP
        temperatureduration = TUNING.FOOD_TEMP_LONG, -- TUNING.FOOD_TEMP_BRIEF 짧음 | TUNING.FOOD_TEMP_AVERAGE 중간 | TUNING.FOOD_TEMP_LONG 길음
        rotten = "seeds", -- 썩으면 변할 물건 (썩은 것으로 변하게 할거면 안적어도 됨)
        stacksize = 1, -- 스택 최대크기, 기본값 TUNING.STACK_SIZE_SMALLITEM(40)
        
        ----------------- 기타 옵션
        oneatenfn = function(inst, eater) --실행 함수
            eater.components.talker:Say("마싯다.")
        end,
    },

    cocoa_powder = {
        foodtype = FOODTYPE.VEGGIE,
        health = 2,
        hunger = 5,
        sanity = 5,
        perishtime = TUNING.PERISH_SLOW,
        rotten = "seeds",
        tags = {"caffeine", "cattoy"}, -- caffeine 태그 : 플레이어가 아닌 엔티티가 먹으면 디버프가 걸리는 이스터 에그
        floater = {"small", nil, nil},
    },

    cocoa_cup = { -- 얼음 + 코코아 파우더 제작템
        foodtype = FOODTYPE.VEGGIE,
        health = 15,
        hunger = 10,
        sanity = 0,
        perishtime = 480,
        tags = {"caffeine", "cattoy"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_BRIEF,
    },

    cocoa = { -- 오븐에 구운 코코아 컵
        foodtype = FOODTYPE.VEGGIE,
        health = 15,
        hunger = 15,
        sanity = 20,
        perishtime = 2700,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "preparedfood"}, -- preparedfood 태그 : 오븐(쿡팟)에 조리된 음식
        floater = {"small", nil, nil},
        temperature = TUNING.HOT_FOOD_BONUS_TEMP * 2,
        temperatureduration = TUNING.FOOD_TEMP_BRIEF,
    },

    cocoa_cold = { -- 냉오븐에 들어간 코코아
        foodtype = FOODTYPE.VEGGIE,
        health = 15,
        hunger = 10,
        sanity = 25,
        perishtime = 2700,
        cooktime = .5,
        tags = {"caffeine", "cattoy", "preparedfood"},
        floater = {"small", nil, nil},
        temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
    },

    wolfsteak = {
        foodtype = FOODTYPE.MEAT,
        health = 45,
        hunger = 5,
        sanity = 0,
        perishtime = 1440,
        tags = {"preparedfood", "monstermeat"},
        rotten = "sendi_food_wolfstaek_cooked",
        floater = {"small", nil, nil},
    },

    wolfsteak_cooked = { --조리된 울프스테이크
        foodtype = FOODTYPE.MEAT,
        health = 55,
        hunger = 10,
        sanity = 10,
        perishtime = 7200,
        cooktime = 2,
        tags = {"preparedfood", "monstermeat"},
        floater = {"small", nil, nil},
    }
}

local prefabs = {
    "spoiled_food",
}

function MakeFood(data)
    local name
    for k, v in pairs(food) do name = k end
    local fname = "sendi_food_"..name
    local atlas = "images/inventoryimages/"..fname..".xml"

    local assets = {
        Asset("ANIM", fname..".zip"),
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

        inst:AddComponent("bait")
        inst:AddComponent("inspectable")
        inst:AddComponent("tradable")

        inst:AddComponent("edible")
        inst.components.edible.healthvalue = data.health
        inst.components.edible.hungervalue = data.hunger
        inst.components.edible.sanityvalue = data.sanity
        inst.components.edible.foodtype = data.foodtype or FOODTYPE.GENERIC
        inst.components.edible.temperaturedelta = data.temperature or 0
        inst.components.edible.temperatureduration = data.temperatureduration or 0
        inst.components.edible:SetOnEatenFn(data.oneatenfn)

        inst.components.edible.cooktime = data.cooktime -- Custom variable

        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(data.perishtime)
        inst.components.perishable:StartPerishing()
        inst.components.perishable.onperishreplacement = data.rotten or "spoiled_food"

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = atlas
        
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
        
        MakeHauntableLaunch(inst)
        
        return inst
    end

    return Prefab(fname, fn, assets, prefabs)
end

local prefs = {}
for k, v in pairs(food) do
    table.insert(prefs, MakeFood(v))
end

return unpack(prefs)