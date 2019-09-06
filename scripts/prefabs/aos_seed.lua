local seeds = {
    test = {
        health = 2, --체력
        hunger = 0, --허기
        sanity = 5, --정신력
        exp = 1, -- 경험치(보스 시드엔 수치가 없음에 주의)

        --기타 옵션
        perishtime = 5000, -- 유통 기간 (이 옵션을 넣지 않으면 썩지 않게됨)
        rotten = "seeds", -- 썩으면 변할 물건 (썩은 것으로 변하게 할거면 안적어도 됨)
        tags = { "testest", "cattoy" }, --붙일 태그들 | "noeat" 먹을 수 없게 하는 태그 
        floater = {"small", nil, nil}, --바다에 뜨는 성질 설정
        temperature = TUNING.HOT_FOOD_BONUS_TEMP, -- 시원한 음식에는 TUNING.COLD_FOOD_BONUS_TEMP
        temperatureduration = TUNING.FOOD_TEMP_LONG, -- TUNING.FOOD_TEMP_BRIEF 짧음 | TUNING.FOOD_TEMP_AVERAGE 중간 | TUNING.FOOD_TEMP_LONG 길음
        stacksize = 1, -- 스택 최대크기, 기본값 TUNING.STACK_SIZE_SMALLITEM (40)
        asset = "_middle", -- 강제로 적용 시킬 외형 파일 이름
        oneatenfn = function(inst, eater) -- 먹었을 때 실행 함수
            eater.components.talker:Say("마싯다.")
        end,
    },

    [""] = {
        health = 0,
        hunger = 2,
        sanity = 0,
        exp = 1,
    },
    
    middle = {
        health = 0,
        hunger = 12,
        sanity = 10,
        exp = 20,
    },

    purple = {
        health = 0,
        hunger = 15,
        sanity = -10,
        perishtime = 480,
        rotten = "aos_seed",
		exp = -5,
    },

    black = {
        health = 0,
        hunger = 0,
        sanity = -10,
		exp = -30,

        perishtime = 1440,
        rotten = "aos_seed",
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
    },

    boss_sky = {
        health = 500,
        hunger = 0,
        sanity = 500,
        exp = 350 -- bigseed 먹으면 바로 레벨업 하는 태그
    },

    boss_black = {
        health = 500,
        hunger = 0,
        sanity = 500,
        tags = {"bigseed"},
    },

    boss_red = {
        health = 500,
        hunger = 0,
        sanity = 500,
        exp = 300,
    },

    boss_white = {
        health = 500,
        hunger = 0,
        sanity = 500,
        tags = {"bigseed"},
    },

    boss_orange = {
        health = 500,
        hunger = 0,
        sanity = 500,
        exp = 250,
    },

    boss_autumn = {
        health = 250,
        hunger = 250,
        sanity = 250,
        exp = 250,
    },

    boss_green = {
        health = 500,
        hunger = 0,
        sanity = 500,
        exp = 220,
    },

    boss_yellow = {
        health = 500,
        hunger = 500,
        sanity = 500,
        exp = 300,
    },

	
	

}

for k, v in pairs(seeds) do 
    v.name = k 
end

local function MakeSeed(data)
    local name = data.name == "" and "" or "_"..data.name
    local pname = "aos_seed"..name
    local fname = "aos_seed"..(data.asset or name)
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

        inst.AnimState:SetBank(fname)
        inst.AnimState:SetBuild(fname)
        inst.AnimState:PlayAnimation("idle", true)

        if data.floater ~= nil then
            MakeInventoryFloatable(inst, data.floater[1], data.floater[2], data.floater[3])
        else
            MakeInventoryFloatable(inst, "small")
        end
    
        inst.entity:SetPristine()
    
        if not TheWorld.ismastersim then
            return inst
        end
    
        inst:AddComponent("inspectable")
        inst:AddComponent("tradable")
        
        if not inst:HasTag("noeat") then
            inst:AddComponent("edible")
            inst.components.edible.hungervalue = data.health
            inst.components.edible.healthvalue = data.hunger
            inst.components.edible.sanityvalue = data.sanity
            inst.components.edible.foodtype = data.foodtype or FOODTYPE.GENERIC
            inst.components.edible.temperaturedelta = data.temperature or 0
            inst.components.edible.temperatureduration = data.temperatureduration or 0

            local function OnEaten(inst, eater) 
                if eater:HasTag("sendi") then
                    if data.exp ~= nil then
                        eater.components.sendilevel:AddExp(data.exp)
                    elseif inst:HasTag("bigseed") then
                        eater.components.sendilevel:LevelUp()
                    end
                end
                
                if data.oneatenfn ~= nil then
                    data.oneatenfn(inst, eater)
                end
            end
            inst.components.edible:SetOnEatenFn(OnEaten)
        end
    
        if data.perishtime ~= nil then
            inst:AddComponent("perishable")
            inst.components.perishable:SetPerishTime(data.perishtime)
            inst.components.perishable:StartPerishing()
            inst.components.perishable.onperishreplacement = data.rotten or "spoiled_food"
        end
        
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = atlas
        
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = data.stacksize or TUNING.STACK_SIZE_SMALLITEM
        
        MakeHauntableLaunch(inst)
    
        return inst
    end
    
    return Prefab("common/inventory/"..pname, fn, assets)
end

local prefs = {}
for k, v in pairs(seeds) do
    table.insert(prefs, MakeSeed(v))
end

return unpack(prefs)