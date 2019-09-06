local CONST = TUNING.SENDI --이것이붙어야 방어값과 내구도를 불러온다

local assets={ 
    Asset("ANIM", "anim/sendi_hat_spider.zip"),
    Asset("ANIM", "anim/sendi_hat_spider_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/sendi_hat_spider.xml"),
    Asset("IMAGE", "images/inventoryimages/sendi_hat_spider.tex"),
	
}

local prefabs = {}


local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_spider_swap", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "sendi_hat_spider", "swap_hat")
									
								--{{ 덧씌울 애니메이션인 뱅크명 / build[sendi_hat_spider_swap] 위에서 언급한 부품들 / build가 들어있는 폴더명, [스프라이터에서 animations 위에있는 이름.]
								
    owner.AnimState:Show("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
 		owner:AddTag("insect")--태그부여
		owner:AddTag("houndfriend")--태그부여
		owner:AddTag("spiderwhisperer") --거미들과 친구가 되어버린다!
		owner:AddTag(UPGRADETYPES.SPIDER.."_upgradeuser")
		
	inst.isWeared = true
	inst.isDropped = false

	
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
		owner:RemoveTag("insect")--태그부여 삭제
		owner:RemoveTag("houndfriend")--태그부여	삭제
		
		owner:RemoveTag("spiderwhisperer") --거미들과 친구가 되어버린다!
		owner:RemoveTag(UPGRADETYPES.SPIDER.."_upgradeuser")
	inst.isWeared = false
	inst.isDropped = false
end

local function ontakefuel(inst)--수리 
    local armor = inst.components.armor
    local afterrepair = armor.condition + 200

    armor:SetCondition(afterrepair >= CONST.ARMOR2_CONDITION and CONST.ARMOR2_CONDITION or afterrepair)
    armor.absorb_percent = CONST.ARMOR2_EFFICIENCY -- 수리 하면 방어율 복원

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


local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()      

	MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("sendi_hat_spider")
    inst.AnimState:SetBuild("sendi_hat_spider")
    inst.AnimState:PlayAnimation("idle")

	inst:AddTag("hat")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine() -- YUKARI : 이거 꼭 있는지 확인!

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_hat_spider.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("waterproofer") --방수
    inst.components.waterproofer:SetEffectiveness(0.80)
	inst.components.equippable.dapperness = -0.1
	
	-- 방수율을 뜻합니다 (0.방수율)
	
	inst:AddComponent("fueled") --연료가 있는.
    inst.components.fueled.fueltype = "BURNABLE"
    inst.components.fueled:InitializeFuelLevel(10)
    inst.components.fueled.accepting = true
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:StopConsuming()
    

    inst:AddComponent("armor")--- 내구도 값
    inst.components.armor.SetCondition = SetConditionTweak
    inst.components.armor:InitCondition(CONST.ARMOR2_CONDITION, CONST.ARMOR2_EFFICIENCY)-- * 튜닝샌디 루아에서 가져오는값이다.

	
	inst:AddComponent("insulator")--보온율
	inst.components.insulator:SetInsulation(240)
	
	inst.components.equippable.walkspeedmult = 1.2 --이동속도 : 케인
	
    inst:AddComponent("inspectable") --조사 가능하도록 설정
	inst.components.inventoryitem.keepondeath = true--죽어도 떨어뜨리지않음
	

	if TheNet:GetServerGameMode() == "quagmire" then --거미들과 친구가 되어버린다!
			inst:AddTag("fastpicker")
			inst:AddTag("quagmire_farmhand")
			inst:AddTag("quagmire_shopper")
		return inst
		
	end
	
	
    return inst
end

return  Prefab("sendi_hat_spider", fn, assets, prefabs)