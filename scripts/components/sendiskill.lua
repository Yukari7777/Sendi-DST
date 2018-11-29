local SendiSkill = Class(function(self, inst)
    self.inst = inst
	
end)

function SendiSkill:Rapier(inst)
	inst.components.talker:Say("rapier!")
end

return SendiSkill