local SendiSkill = Class(function(self, inst)
    self.inst = inst

	self.shouldcharge = false
	self.angle = 0

	-- RAPIER
	self.tickaftercharge = 0
end)

local function DoRapierCharge(inst)
	local self = inst.components.sendiskill
	local charge = self.shouldcharge
	local angle = self.angle

	if charge then
		local VELOCITY = 0.3
		local RADIUS = 2
		local DAMAGE = 20

		local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)
		fx.Transform:SetPosition(inst:GetPosition():Get())

		self.tickaftercharge = self.tickaftercharge + 1
		inst.Physics:SetMotorVel(25, 0, 0)

		local playerpos = inst:GetPosition()
		local ents = TheSim:FindEntities(playerpos.x + math.sin(angle), 0, playerpos.z + math.cos(angle), RADIUS, nil, { "INLIMBO" })
		for k,v in pairs(ents) do 
			if v.components.health and not v:HasTag("companion") and v ~= inst and (TheNet:GetPVPEnabled() or not v:HasTag("player")) then
				local targetpos = v:GetPosition()
				v.Transform:SetPosition(targetpos.x + (math.sin(angle) * VELOCITY) , 0, targetpos.z + (math.cos(angle) * VELOCITY))
				if not v:HasTag("damagetaken") then
					v.components.combat:GetAttacked(inst, DAMAGE)
					v:AddTag("damagetaken")
					v:DoTaskInTime(15 * FRAMES, function()
						v:RemoveTag("damagetaken")
					end)
				end	
			end
		end
	end
end

function SendiSkill:OnStartRapier(inst, angle)
	if inst.SkillTask == nil then 
		self.angle = angle
		inst.SkillTask = inst:DoPeriodicTask(0, DoRapierCharge) -- 0초마다 반복 = 1프레임(0.033초)마다 반복
		inst.components.talker:Say(GetString(inst.prefab, "RAPIER"))
	end
end

function SendiSkill:Explode(inst)
	self.shouldcharge = true
	local x, y, z = inst.Transform:GetWorldPosition()

	local fx = SpawnPrefab("explode_small")
	fx.Transform:SetScale(1.4, 1.4, 1.4)
	fx.Transform:SetPosition(x, y, z)

	local ents = TheSim:FindEntities(x, y, z, 4, nil, { "INLIMBO" })
	for k,v in pairs(ents) do 
		if v.components.health and not v:HasTag("companion") and v ~= inst and (TheNet:GetPVPEnabled() or not v:HasTag("player")) then
			v.components.combat:GetAttacked(inst, 30)
		end
	end
end

function SendiSkill:OnFinishRapier(inst)
	self.shouldcharge = false
	self.tickaftercharge = 0
	if inst.SkillTask ~= nil then 
		inst.SkillTask:Cancel()
		inst.SkillTask = nil
	end
end

return SendiSkill