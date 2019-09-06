local CONST = TUNING.SENDI --이것이붙어야 방어값과 내구도를 불러온다

local assets={  
    Asset("ANIM", "anim/sendi_hat_crown.zip"),
    Asset("ANIM", "anim/sendi_hat_crown_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/sendi_hat_crown.xml"),
    Asset("IMAGE", "images/inventoryimages/sendi_hat_crown.tex"),
}

local prefabs = { }

local function sendi_hat_crown_disable(inst)
    if inst.updatetask ~= nil then
        inst.updatetask:Cancel()
        inst.updatetask = nil
    end
end

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

local function sendi_hat_crown_enable(inst) --돼지 팔로워 
    inst.updatetask = inst:DoPeriodicTask(1, pigqueen_update, 1)
end

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_crown_swap", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_crown", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	
	sendi_hat_crown_enable(inst)	
	owner:AddTag("ignoreMeat") --고기옵션 
	
	inst.isWeared = true
	inst.isDropped = false	
	
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	
	sendi_hat_crown_disable(inst)
	owner:RemoveTag("ignoreMeat") --고기 옵션
	
	inst.isWeared = false
	inst.isDropped = false
end

local function ontakefuel(inst)--수리 
    local armor = inst.components.armor
    local afterrepair = armor.condition + 200

    armor:SetCondition(afterrepair >= CONST.ARMOR1_CONDITION and CONST.ARMOR1_CONDITION or afterrepair)
    armor.absorb_percent = CONST.ARMOR1_EFFICIENCY -- 수리 하면 방어율 복원

    inst:PushEvent("percentusedchange", { percent = armor:GetPercent() })
end


local function SetConditionTweak(self, amount)--수리
    self.condition = math.min(amount, self.maxcondition)
    if self.condition <= 0 then
        self.condition = 0
        self.absorb_percent = 0
    end

    self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
end


local function fn()

    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()      

	MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("sendi_hat_crown")
    inst.AnimState:SetBuild("sendi_hat_crown")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("hat")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine() -- YUKARI : 이거 꼭 있는지 확인!

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_hat_crown.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	
	inst:AddComponent("fueled") --연료가 있는.
    inst.components.fueled.fueltype = "BURNABLE"
    inst.components.fueled:InitializeFuelLevel(10)
    inst.components.fueled.accepting = true
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:StopConsuming()
    

    inst:AddComponent("armor")--- 내구도 값
    inst.components.armor.SetCondition = SetConditionTweak
    inst.components.armor:InitCondition(CONST.ARMOR1_CONDITION, CONST.ARMOR1_EFFICIENCY)-- * 튜닝샌디 루아에서 가져오는값이다.

	
	inst:AddComponent("insulator")--보온율
	inst.components.insulator:SetInsulation(240)
	
	----주요 옵션
	--inst.components.equippable.dapperness = 0.1 --정신력 오라
	inst.components.equippable.walkspeedmult = 1.1 --이동속도 : 케인
	
	inst:AddComponent("waterproofer") --방수
    inst.components.waterproofer:SetEffectiveness(0.50)

	
    inst:AddComponent("inspectable") --조사 가능하도록 설정
	
	
    return inst
end


return  Prefab("sendi_hat_crown", fn, assets, prefabs)