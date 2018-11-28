local assets =
{
    Asset("ANIM", "anim/sendipack.zip"),
    Asset("ANIM", "anim/swap_sendipack.zip"),

    Asset("ATLAS", "images/inventoryimages/sendipack.xml"),
    Asset("IMAGE", "images/inventoryimages/sendipack.tex")

}

local prefabs = 
{
"sendi",
}


local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "swap_sendipack", "sendipack")
    owner.AnimState:OverrideSymbol("swap_body", "swap_sendipack", "swap_body")
    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner.AnimState:ClearOverrideSymbol("sendipack")
    if inst.components.container ~= nil then
    inst.components.container:Close(owner)
    end
end

local function onopen(inst)
   inst.SoundEmitter:PlaySound("dontstarve/wendy/backpack_open", "open")
end

local function onclose(inst)
   inst.SoundEmitter:PlaySound("dontstarve/wendy/backpack_close", "open")
end

local function fn(Sim)
   local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
   
   MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("swap_sendipack")
    inst.AnimState:PlayAnimation("anim")

    inst.MiniMapEntity:SetIcon("backpack.png")
    inst:AddTag("backpack")



    inst.foleysound = "dontstarve/movement/foley/backpack"

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("sendispecific")

    inst:AddComponent("inspectable")

    --inst:AddComponent("insulator")
	--inst.components.insulator:SetInsulation(TUNING.INSULATION_TINY)
	--보온기능을 추가합니다. 
	
	inst:AddTag("fridge")
	-- 냉장고 기능을 추가합니다.
	
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("backpack")
	-- 센디의 가방 크기 : backpack[일반 가방], krampus_sack[크람푸스 가방]

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.imagename = "sendipack"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sendipack.xml"

    inst:AddComponent("inspectable")
    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    
    --inst:AddComponent("equippable")
    --inst.components.equippable.keepondeath = true
	--inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	-- 가방을 떨어뜨리게 하지 않습니다.
	
	    inst:AddComponent("equippable")
		inst.components.equippable.keepondeath = false
		inst.components.equippable.equipslot = EQUIPSLOTS.BODY
		-- 가방을 떨어뜨리게 합니다.
   
if EQUIPSLOTS.PACK then
      inst.components.equippable.equipslot = EQUIPSLOTS.PACK
   elseif EQUIPSLOTS.BACK then
      inst.components.equippable.equipslot = EQUIPSLOTS.BACK
   else
      inst.components.equippable.equipslot = EQUIPSLOTS.BODY
   end
   
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = 1.0

    
   if not inst.components.sendispecific then
    inst:AddComponent("sendispecific")
end

   inst.components.sendispecific:SetOwner("sendi")
   inst.components.sendispecific:SetStorable(true)
   inst.components.sendispecific:SetComment("이건 센디가 가지고 다니는 가방이야! 너무 예뻐!", "이건, 하얀 가방인가? 귀여운데?") 

   
   MakeHauntableLaunchAndDropFirstItem(inst)
    
    return inst
end

return Prefab( "common/inventory/sendipack", fn, assets) 