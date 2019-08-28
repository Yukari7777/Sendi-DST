local assets = {
	Asset("ANIM", "anim/sendi_amulet.zip"),
	Asset("ANIM", "anim/torso_sendi_amulet.zip"),
	Asset("ATLAS", "images/inventoryimages/sendi_amulet.xml"),
}

local prefabs = {}

local function IsValidOwner(inst, owner)
    return owner:HasTag("sendi")
end

local function onequip(inst, owner)

	if not inst.share_item and owner and not owner:HasTag("sendi") and owner.components.inventory then
        owner.components.inventory:Unequip(EQUIPSLOTS.NECK or EQUIPSLOT.BODY, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end
	
	owner.AnimState:OverrideSymbol("swap_body", "torso_sendi_amulet", "purpleamulet")
	--owner:ListenForEvent("attacked", MeteorChance, owner)
	if inst.components.fueled then
		if inst.components.fueled:GetPercent() <= 0 then
			inst.broken = true
			inst.components.equippable.walkspeedmult = 1.0
			inst.components.equippable.dapperness = 0
			inst.components.fueled:StopConsuming()    
		else 
			inst.components.fueled:StartConsuming()
		end
	end

    if inst.remove_task then
		inst.remove_task:Cancel()
		inst.remove_task = nil
	end
end

local function onunequip(inst, owner)
	owner.AnimState:ClearOverrideSymbol("swap_body")
	--owner:RemoveEventCallback("attacked", MeteorChance, owner)

	if inst.components.fueled then
		inst.components.fueled:StopConsuming()
	end
	
    if inst.remove_task then
		inst.remove_task:Cancel()
		inst.remove_task = nil
	end
end

local function OnAmmyDrop(inst, owner)
    if inst.remove_task then
		inst.remove_task:Cancel()
		inst.remove_task = nil
	end

	--[[
	if not IsValidOwner(inst, owner) then
		owner:DoTaskInTime(0, function()
			if owner.components.inventory then
				owner.components.inventory:DropItem(inst, nil, true)
			elseif owner.components.container then
				owner.components.container:DropItem(inst)
			else inst:Drop()
			end
		end)
	end
	--]]
end

local function OnDurability(inst, data)
	inst.broken = true
	inst.components.fueled:StopConsuming()    
	
    inst.components.equippable.walkspeedmult = 1.0
    inst.components.equippable.dapperness = 0
	
	if inst.consume then inst.consume:Cancel() inst.consume = nil end
end

local function TakeItem(inst, item, data)

	inst.components.fueled:DoDelta(TUNING.WALRUSHAT_PERISHTIME / 2)
	SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())    
	
	if inst.broken then
		inst.broken = false 
	end
end

local function OnDisappear(inst, owner)
	inst:Remove()
	local fx1 = SpawnPrefab("lucy_transform_fx")
	fx1.Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function fn()
	local inst = CreateEntity()

	local trans = inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("amulets")
    inst.AnimState:SetBuild("sendi_amulet")
    inst.AnimState:PlayAnimation("blueamulet")
	
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end
	
	--[[
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled:InitializeFuelLevel(TUNING.RAINCOAT_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)
    inst.components.fueled.accepting = true
	--]]
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "sendi"
    inst.components.fueled:InitializeFuelLevel(TUNING.WALRUSHAT_PERISHTIME)
	inst.components.fueled:SetDepletedFn(OnDurability)
	inst.components.fueled.ontakefuelfn = TakeItem
	inst.components.fueled.accepting = true
	--inst.components.fueled:StartConsuming()    
	
	inst:AddComponent("inspectable")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendi_amulet.xml"
	inst.components.inventoryitem.onpickupfn = OnAmmyDrop
	inst.components.inventoryitem.onputininventoryfn = OnAmmyDrop

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = 1.2
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED  

	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )

	inst:ListenForEvent("animover", function() inst.remove_task = inst:DoPeriodicTask(TUNING.sendi_FAN_REMOVETIME, OnDisappear) end)
	
	MakeHauntableLaunch(inst)

	return inst
end

return Prefab( "sendi_amulet", fn, assets, prefabs)
