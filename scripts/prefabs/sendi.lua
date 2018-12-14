local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}


local prefabs = {
--외부에있는것을 불러옴


}


local start_inv = {
-- 맞춤시작 인벤토리 시작 
	"sendipack"
}

local function onbecamehuman(inst)
-- 인물이 인간에게서 부활 할때
   inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sendi_speed_mod", 1.2)
   -- 유령이 아닌경우 속도 설정.
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sendi_speed_mod")
   -- 귀신이 될때 속도 수정자 제거
end

local function onload(inst)
-- 캐릭터를 로드 하거나, 스폰 하는 경우 
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

--MH 모드옵션 불러오기
--local modoption = GetModConfigData("modoption")
--MH 모드옵션 불러오기



------------------------------/아래/-미쉘의  허기불꽃 시스템-/아래/--------------------------------
local function sendi_light(inst, data) --YUKARI : 주석의 의미에 맞게 코드를 좀더 명확하게 재작성
	if not inst:HasTag("playerghost") then 	--MH 모드 옵션 불러와서 세팅(할 예정)
		local Light = inst.Light or inst.entity:AddLight()  -- YUKARI : inst에 이미 Light가 있으면 불필요하게 추가하지 않게 하기위해서 이렇게 작성
															 -- AddLight는 한번만 사용해도 됩니다.
		if (TheWorld.state.isnight or TheWorld:HasTag("cave")) and not TheWorld.state.isfullmoon then
			if inst.components.hunger.current > 80 then
				inst.Light:SetRadius(1.1)
				inst.Light:SetFalloff(1.2)
				inst.Light:SetIntensity(.5)
				inst.Light:SetColour(255, 255, 20/255, 25, 255)
				inst.Light:Enable(true) -- YUKARI : Light를 끄거나 키는데에 사용.
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 3)
			else
				Light:Enable(false)
				
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
			end
			-- inst.components.health:StartRegen(0.2, 1) 
			-- YUKARI : 기본 체력재생량 수치에 따르면, 기본 체력 재생주기는 0.6초 인데 센디를 플레이하면서 한번이라도 밤이 되면 체력 재생주기가 영구적으로 1초로 변하고 
			--          이 상태에선 낮과 밤에 상관없이 체력재생이 되는 오류가 있었습니다. 이제 밤에는 올바르게 체력 재생이 되지 않습니다.
			--          문제가 있다면 코드를 이전으로 되돌려주세요.
			inst.components.health.regen.amount = 0
		else
			Light:Enable(false)
			inst.components.health.regen.amount = 0.2
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
		end
	end
end
----------------------------/ 위 /미쉘의  허기불꽃 시스템 / 위 /---------------------------------

local function SendiOnSetOwner(inst)
	if TheWorld.ismastersim then
        inst.sendi_classified.Network:SetClassifiedTarget(inst)
    end
end

local function AttachClassified(inst, classified)
	inst.sendi_classified = classified
    inst.ondetachsendiclassified = function() inst:DetachSendiClassified() end
    inst:ListenForEvent("onremove", inst.ondetachsendiclassified, classified)
end

local function DetachClassified(inst)
	inst.sendi_classified = nil
    inst.ondetachsendiclassified = nil
end

local function OverrideOnRemoveEntity(inst)
	inst.OnRemoveSendi = inst.OnRemoveEntity
	function inst.OnRemoveEntity(inst)
		if inst.jointask ~= nil then
			inst.jointask:Cancel()
		end

		if inst.sendi_classified ~= nil then
			if TheWorld.ismastersim then
				inst.sendi_classified:Remove()
				inst.sendi_classified = nil
			else
				inst:RemoveEventCallback("onremove", inst.ondetachsendiclassified, inst.sendi_classified)
				inst:DetachSendiClassified()
			end
		end
		return inst:OnRemoveSendi()
	end
end

local function KeyCheckCommon(inst)
	return inst == ThePlayer and TheFrontEnd:GetActiveScreen() ~= nil and TheFrontEnd:GetActiveScreen().name == "HUD"
end

local function RegisterKeyEvent(inst)
	-- If do Buffered Action when MovementPrediction is off, the client's inst.sg and locomotor will be removed.
	-- And SG utils will handle both cases, I think?
	local modname = KnownModIndex:GetModActualName("[DST]Sendi")

	local RapierKey = GetModConfigData("skill_1", modname) or "KEY_V"
	TheInput:AddKeyDownHandler(_G[RapierKey], function()
		if KeyCheckCommon(inst) then
			SendModRPCToServer(MOD_RPC["sendi"]["rapier"]) 
		end
	end) 
end

local common_postinit = function(inst) 
	--센디의 커스텀레시피를 추가합니다. 
	inst.MiniMapEntity:SetIcon( "sendi.tex" )
	-- 위커바컴의 책을 제조합니다.
	inst:AddTag("bookbuilder")
	inst:AddTag("reader")
	--MH
	inst:AddTag("sendicraft")
	--MH
	-- 사용가능 레시피를 추가 합니다.
	inst:DoTaskInTime(0, RegisterKeyEvent)

	inst:ListenForEvent("setowner", SendiOnSetOwner)

	OverrideOnRemoveEntity(inst)
	inst.AttachSendiClassified = AttachClassified
	inst.DetachSendiClassified = DetachClassified
end

local master_postinit = function(inst)
	inst.sendi_classified = SpawnPrefab("sendi_classified")
	inst:AddChild(inst.sendi_classified)
	
	inst.soundsname = "willow"
	-- 이 캐릭터의 사운드 윌로우로 설정함.

	inst:AddComponent("reader")
	inst:AddComponent("sendiskill")

	--------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------
	inst:WatchWorldState("phase", sendi_light)
	inst:ListenForEvent("hungerdelta", sendi_light)
	--------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------

	-- Stats   
	inst.components.health:SetMaxHealth(90) -- 피
	inst.components.hunger:SetMax(120) -- 배고팡
	inst.components.sanity:SetMax(180) -- 정신
	-- 최대피, 허기, 체력을 표시합니다.


	inst.components.health.fire_damage_scale = 0.1
	--불꽃 데미지를 지정합니다
	
	inst.components.combat.damagemultiplier = 0.6
	-- Damage multiplier (optional) 데미지를 나타냅니다.

	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.0) --YUKARI : 2.5배로 설정하시고선 아랫줄에서 다시 1.0배로 줄이셨습니다.
	--허기 주기를 나타냅니다.
	
	inst.components.combat.min_attack_period = 0.01
	--0.?초마다 때리는걸 의미합니다.
	
	inst.components.health:StartRegen(0.3, 0.6) --체력을 회복합니다

	inst.OnLoad = onload
	inst.OnNewSpawn = onload
   
end

return MakePlayerCharacter("sendi", prefabs, assets, common_postinit, master_postinit, start_inv)