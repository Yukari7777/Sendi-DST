local SendiSkill = Class(function(self, inst)
    self.inst = inst
	
end)

function SendiSkill:OnStartRapier()
	local classified = self.inst.sendi_classified
	print(classified, classified.pointx:value(), classified.pointy:value(), classified.pointz:value())
end

return SendiSkill