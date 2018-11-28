local sendispecific = Class(function(self, inst)
    self.inst = inst

    self.character = nil
    self.storable = false
    self.comment = "That does not belong to me."
end)

function sendispecific:CanPickUp(doer)
	if doer and doer.prefab ~= self.character then
		return false
	end

	return true
end

function sendispecific:SetOwner(name)
    self.character = name
end

function sendispecific:IsStorable()
	return self.storable
end

function sendispecific:SetStorable(value)
	self.storable = value
end

function sendispecific:GetComment()
	return self.comment
end

function sendispecific:SetComment(comment)
	self.comment = comment
end

return sendispecific