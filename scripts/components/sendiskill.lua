local SendiSkill = Class(function(self, inst)
    self.inst = inst

	self.shouldcharge = false
	self.angle = 0
end)

local function InRapier(inst)
	local self = inst.components.sendiskill
	local docharge = self.shouldcharge
	local angle = self.angle

	print(docharge, inst, angle)
	if docharge then
		local SPEED = 1
		local RADIUS = 2
		local DAMAGE = 20

		local playerpos = inst:GetPosition()
		local ents = TheSim:FindEntities(playerpos.x + math.sin(angle), 0, playerpos.z + math.cos(angle), RADIUS, nil, { "INLIMBO" })
		for k,v in pairs(ents) do 
			if v.components.health and not v:HasTag("companion") and v ~= inst and (TheNet:GetPVPEnabled() or not v:HasTag("player")) then
				local targetpos = v:GetPosition()
				v.Transform:SetPosition(targetpos.x + (math.sin(angle) * SPEED) , 0, targetpos.z + (math.cos(angle) * SPEED))
				if not v:HasTag("damagetaken") then
					v.components.combat:GetAttacked(inst, DAMAGE)
					v:AddTag("damagetaken")
				end	
			end
		end
	end
end

function SendiSkill:OnStartRapier(inst, angle)
	if inst.SkillTask == nil then 
		self.angle = angle
		inst.SkillTask = inst:DoPeriodicTask(0, InRapier) -- 0초마다 반복 = 1프레임(0.033초)마다 반복
		inst.components.talker:Say(GetString(inst.prefab, "RAPIER"))
	end
end

function SendiSkill:OnFinishRapier(inst)
	self.shouldcharge = false
	if inst.SkillTask ~= nil then 
		inst.SkillTask:Cancel()
		inst.SkillTask = nil
	end
end

return SendiSkill