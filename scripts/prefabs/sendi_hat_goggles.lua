local assets={  
    Asset("ANIM", "anim/sendi_hat_goggles.zip"),
    Asset("ANIM", "anim/sendi_hat_goggles_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/sendi_hat_goggles.xml"),
    Asset("IMAGE", "images/inventoryimages/sendi_hat_goggles.tex"),
}

local prefabs = { }

local function sendi_hat_goggles_disable(inst)
    if inst.updatetask ~= nil then
        inst.updatetask:Cancel()
        inst.updatetask = nil
    end
end

--분기점에따라 바뀌는 코드
local slotpos = {}

for y = 0, 3 do
	table.insert(slotpos, Vector3(-162, -y*75 + 114 ,0))
	table.insert(slotpos, Vector3(-162 +75, -y*75 + 114 ,0))
end


local function ChangeInsulation(inst, temperature)
	if temperature < 5 then -- 추워하는 화면 이펙트가 생기는 것의 분기점
		inst.components.insulator:SetWinter()
	else
		inst.components.insulator:SetSummer()
	end
end
	
--분기점에따라 바뀌는 코드 닫기


local function pigqueen_update( inst )  --돼지 팔로워 
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner ~= nil and inst.components.inventoryitem.owner.components.leader ~= nil and inst.components.inventoryitem.owner

    local x,y,z = owner.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, { "pig" }, { "werepig" })
    for k,v in pairs(ents) do
        if v.components.follower ~= nil and not v.components.follower.leader ~= nil and not owner.components.leader:IsFollower(v) and owner.components.leader.numfollowers < 10 then
            owner.components.leader:AddFollower(v)
        end
    end
		
    for k,v in pairs(owner.components.leader.followers) do
        if k:HasTag("pig") and k.components.follower ~= nil then
            k.components.follower:AddLoyaltyTime(1.5)
        end
    end	
end

local function sendi_hat_goggles_enable(inst) --돼지 팔로워 
    inst.updatetask = inst:DoPeriodicTask(1, pigqueen_update, 1)
end

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_goggles_swap", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_goggles", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	
	sendi_hat_goggles_enable(inst)	
		owner:AddTag("ignoreMeat") --고기옵션 
		owner:AddTag("insect")--태그부여
		owner:AddTag("houndfriend")--태그부여
		owner:AddTag("spiderwhisperer") 
	inst.isWeared = true
	inst.isDropped = false	
	
end

local function OnUnequip(inst, owner)  
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	
	sendi_hat_goggles_disable(inst)
		owner:RemoveTag("ignoreMeat") --고기 옵션
		owner:RemoveTag("insect")--태그부여 삭제
		owner:RemoveTag("houndfriend")--태그부여	삭제
		owner:RemoveTag("spiderwhisperer") 
	inst.isWeared = false
	inst.isDropped = false
end


local function fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()      

	MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("sendi_hat_goggles")
    inst.AnimState:SetBuild("sendi_hat_goggles")
    inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("hat")
	inst:AddTag("goggles")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine() -- YUKARI : 이거 꼭 있는지 확인!

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_hat_goggles.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	
	
	inst:AddComponent("armor") --내구도, 방어도 설정
	inst.components.armor:InitIndestructible(0.7) --무한 내구도
	
	--주요 능력치
	inst:AddComponent("insulator")--보온율
    inst.components.insulator:SetInsulation(300) 
	
	inst:AddComponent("waterproofer") --방수
    inst.components.waterproofer:SetEffectiveness(0.80)
	
    inst.components.equippable.walkspeedmult = 1.2 --이동속도 : 케인
	inst.components.equippable.dapperness = 0.4 --정신력
	
    inst:AddComponent("inspectable") --조사 가능하도록 설정

	inst.components.inventoryitem.keepondeath = true --죽어도 떨어뜨리지 않음.
	
	
	MakeHauntableLaunch(inst)

	ChangeInsulation(inst, TheWorld.state.temperature) 
	inst:WatchWorldState("temperature", ChangeInsulation) --YUKARI : 기온에 따라 바뀌게 함수 개선

	
    return inst
end


return  Prefab("sendi_hat_goggles", fn, assets, prefabs)