local function SetDirty(netvar, val)
    --Forces a netvar to be dirty regardless of value
    netvar:set_local(val)
    netvar:set(val)
end

local function OnEntityReplicated(inst)	
	print("OnEntityReplicated")	
    inst._parent = inst.entity:GetParent()
    if inst._parent == nil then
        print("Unable to initialize classified data for player Sendi")
    else
		inst._parent:AttachSendiClassified(inst)
    end
end

local function OnRapier(parent)
	parent.components.playercontroller:DoAction(BufferedAction(parent, nil, ACTIONS.RAPIER))
end

local function RegisterNetListeners(inst)
	if TheWorld.ismastersim then
		inst._parent = inst.entity:GetParent()
		inst:ListenForEvent("onrapier", OnRapier, inst._parent)
	else
		
	end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform() --So we can follow parent's sleep state
    inst.entity:AddNetwork()
    inst.entity:Hide()
    inst:AddTag("CLASSIFIED")

	inst.rapier = net_bool(inst.GUID, "onrapier", "onrapierdirty")
	inst.rapier:set(false)

	--Delay net listeners until after initial values are deserialized
    inst:DoTaskInTime(0, RegisterNetListeners)

	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        --Client interface
        inst.OnEntityReplicated = OnEntityReplicated
        return inst
    end

	inst.persists = false

    return inst
end


return Prefab("sendi_classified", fn)