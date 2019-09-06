local function SetDirty(netvar, val)
    --Forces a netvar to be dirty regardless of value
    netvar:set_local(val)
    netvar:set(val)
end

local function OnEntityReplicated(inst)	
    inst._parent = inst.entity:GetParent()
    if inst._parent == nil then
        print("Unable to initialize classified data for player Sendi")
    else
		inst._parent:AttachSendiClassified(inst)
		for i, v in ipairs({ "sendimana" }) do
            if inst._parent.replica[v] ~= nil then
                inst._parent.replica[v]:AttachClassified(inst)
            end
        end
    end
end

local function KeyCheckCommon(parent)
	return parent == ThePlayer and TheFrontEnd:GetActiveScreen() ~= nil and TheFrontEnd:GetActiveScreen().name == "HUD"
end

local function RegisterKeyEvent(classified)
	local parent = classified._parent
	if parent.HUD == nil then return end -- if it's not a client, stop here.
	local modname = KnownModIndex:GetModActualName("[DST]Sendi")

	local RapierKey = GetModConfigData("skill_1", modname) or "KEY_V"
	TheInput:AddKeyDownHandler(_G[RapierKey], function()
		if KeyCheckCommon(parent) then
			if TheInput:IsKeyDown(KEY_SHIFT) then
				SendModRPCToServer(MOD_RPC["sendi"]["rapier"]) 
			else
				SendModRPCToServer(MOD_RPC["sendi"]["igniarun"]) 
			end
		end
	end) 

	local SkinKey = GetModConfigData("skin", modname) or "KEY_P"
	TheInput:AddKeyDownHandler(_G[SkinKey], function()
		if KeyCheckCommon(parent) then
			SendModRPCToServer(MOD_RPC["sendi"]["skin"]) 
		end
	end) 

	local StatusKey = GetModConfigData("statuskey", modname) or "KEY_K"
	TheInput:AddKeyDownHandler(_G[StatusKey], function()
		if KeyCheckCommon(parent) then
			SendModRPCToServer(MOD_RPC["sendi"]["status"]) 
		end
	end) 
end

local SKILLS = { "rapier", "igniarun" }
local SKILLFN = {}
for k, v in pairs(SKILLS) do
	table.insert(SKILLFN, function(parent)
		if parent.components.hunger ~= nil and not parent.components.hunger:IsStarving() then
			parent.components.playercontroller:DoAction(BufferedAction(parent, nil, ACTIONS[v:upper()]))
		else
			parent.components.talker:Say(GetString(parent.prefab, "DESCRIBE_LOW_HUNGER"))
		end
	end)
end

local function RegisterNetListeners(inst)
	if TheWorld.ismastersim then
		inst._parent = inst.entity:GetParent()

		for i = 1, #SKILLS do
			inst:ListenForEvent("on"..SKILLS[i], SKILLFN[i], inst._parent)
		end
	else
		
	end
	RegisterKeyEvent(inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform() --So we can follow parent's sleep state
    inst.entity:AddNetwork()
    inst.entity:Hide()
    inst:AddTag("CLASSIFIED")

	inst.maxsendimana = net_ushortint(inst.GUID, "maxsendimana")
	inst.currentsendimana = net_ushortint(inst.GUID, "currentsendimana")
	inst.sendimanaratescale = net_ushortint(inst.GUID, "sendimanaratescale")

	inst.rapier = net_event(inst.GUID, "onrapier")
	inst.igniarun = net_event(inst.GUID, "onigniarun")

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