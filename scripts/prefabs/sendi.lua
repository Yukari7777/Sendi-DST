local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}


local prefabs = {
--센디의 제작ㄹ목록을 추가합니다
	"sendipack",
	"sendisedmask",

}


local start_inv = {
-- 맞춤시작 인벤토리 시작 
	"sendipack"
}

local function onbecamehuman(inst)
-- 인물이 인간에게서 부활 할때
   inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sendi_speed_mod", 1.4)
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
local function sendi_light(inst, data)
--M지역 함수 설정 :  허기불꽃


if not inst:HasTag("playerghost") then
--MH 플레이어가 유령이 아니라면 * 아래 적용시 위에 주석 
		--if not inst:HasTag("playerghost") and modoption == "3" then
		--MH 플레이어가 유령이아니라면, MH 모드옵션 불러오기 * 위에 사용시 아래 주석
		
		
local Light = inst.entity:AddLight()
-- MH 지역변수 설정 - Ligh=inst.entity:AddLight()
	if (TheWorld.state.isnight or TheWorld:HasTag("cave")) and not TheWorld.state.isfullmoon then
	--M(월드가 밤 또는 동굴) 이고, 보름달이 아니라면
		if inst.components.hunger:GetPercent() <= .47 then
		--M포만도가 80% 이하라면
			Light:Enable(false)
			--M빛 해제
			 inst.components.health:StartRegen(0.2, 1)
			--체력리젠
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1)
			--M포만도 감소속도를 윌슨의 1배로 설정(기본값)
		elseif inst.components.hunger:GetPercent() > .47 then
		--M혹은 포만도가 80% 초과라면
			inst.entity:AddLight()
			--M엔티티에게 빛 추가
			inst.Light:SetRadius(0.4)
			--M범위 반경 설정
			inst.Light:SetFalloff(1)
			--M빛의 감퇴량 설정
			inst.Light:SetIntensity(0.5)
			--M빛의 강도 설정
			inst.Light:SetColour(255, 255, 20/255, 25, 255)
			--M빛의 색 설정
			inst.Light:Enable(true)
			--Minst.Light:Enable값을 true로 설정?
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 2)
			--M포만도 감소량 증폭
		end
		else
		Light:Enable(false)
		--MLight:Enable를 false로 설정?
		inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1)
		--M포만도 감소량 기본값
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


local function RegisterKeyEvent(inst)
	TheInput:AddKeyDownHandler(_G["KEY_R"], function() 
		if inst == ThePlayer and not inst:HasTag("inskill") and not inst.HUD:IsConsoleScreenOpen() then
			-- If do Buffered Action when MovementPrediction is off, the client's inst.sg and locomotor will be removed.
			-- And SG utils will handle both cases, I think?
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
    inst.sendi_classified.entity:SetParent(inst.entity)
	inst.soundsname = "willow"
	-- 이 캐릭터의 사운드 윌로우로 설정함.

	inst:AddComponent("reader")
	inst:AddComponent("sendiskill")
	--------MH 혼돈의카오스 패시브 시작 
	  --local function MishellTrig1(inst, data)
	--if not inst:HasTag("playerghost") then
	 -- if inst.components.health:GetPercent() >= .5 then
	 --    inst.components.health:DoDelta(-10)
	 -- else
	 --    inst.components.health:DoDelta(10)
	 -- end
	-- end
	--end
	----------------MH 혼돈의카오스 패시브 종료 
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
	--inst.talker_path_override = "dontstarve_DLC001/characters/"
	--------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------
	inst:WatchWorldState("phase", sendi_light)
	inst:ListenForEvent("hungerdelta", sendi_light)
			-- 트리거
			--MH 혼돈 마침
			---inst:ListenForEvent("hungerdelta", MishellTrig1)
			--HJ 혼돈 마침
	--------------------------- 허기 불꽃 시스템의 마침점 ------------------------------------

	-- Stats   
	inst.components.health:SetMaxHealth(90) -- 피
	inst.components.hunger:SetMax(120) -- 배고팡
	inst.components.sanity:SetMax(180) -- 정신
	-- 최대피, 허기, 체력을 표시합니다.


	inst.components.health.fire_damage_scale = 0.5
	inst.components.combat.damagemultiplier = 0.85
	-- Damage multiplier (optional) 데미지를 나타냅니다.
	inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.5)
	--허기 주기를 나타냅니다.
	inst.components.combat.min_attack_period = 0.01
	--0.?초마다 때리는걸 의미합니다.
	inst.components.health:StartRegen(0.3, 0.6) --체력을 회복합니다

	-- 배고파지는 속도
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

	inst.OnLoad = onload
	inst.OnNewSpawn = onload
   
end

return MakePlayerCharacter("sendi", prefabs, assets, common_postinit, master_postinit, start_inv)

