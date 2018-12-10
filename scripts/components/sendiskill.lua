local SendiSkill = Class(function(self, inst)
    self.inst = inst

	self.shouldcharge = false
end)

local function InRapier(inst, angle)
	local docharge = inst.components.sendiskill.shouldcharge
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
		
		inst.SkillTask = inst.DoPeriodicTask(inst, FRAMES, InRapier(inst, angle))
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