local CONST = TUNING.SENDI

local SendiMana = Class(function(self, inst)
    self.inst = inst

	if TheWorld.ismastersim then
        self.classified = inst.sendi_classified
    elseif self.classified == nil and inst.sendi_classified ~= nil then
        self:AttachClassified(inst.sendi_classified)
    end
end)

--------------------------------------------------------------------------

function SendiMana:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

SendiMana.OnRemoveEntity = SendiMana.OnRemoveFromEntity

function SendiMana:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function SendiMana:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------

function SendiMana:SetMaxSendiMana(max)
	self.classified.maxsendimana:set(max)
end

function SendiMana:SetCurrent(current)
	self.classified.currentsendimana:set(current)
end

function SendiMana:Max()
    if self.inst.components.sendimana ~= nil then
        return self.inst.components.sendimana.max
    elseif self.classified ~= nil then
        return self.classified.maxsendimana:value()
    else
        return CONST.MANA_MAX_DEFAULT
    end
end

function SendiMana:GetCurrent()
    if self.inst.components.sendimana ~= nil then
        return self.inst.components.sendimana.current
    elseif self.classified ~= nil then
        return self.classified.currentsendimana:value()
    else
        return CONST.MANA_CURRENT_DEFAULT
    end
end

function SendiMana:GetPercent()
    if self.inst.components.sendimana ~= nil then
        return self.inst.components.sendimana:GetPercent()
    end
    return self:GetPercentNetworked()
end

function SendiMana:GetPercentNetworked()
    --Use networked value whether we are server or client
    return self.classified ~= nil and self.classified.maxsendimana ~= nil and  self.classified.currentsendimana ~= nil and self.classified.currentsendimana:value() / self.classified.maxsendimana:value() or 1
end

function SendiMana:SetRateScale(ratescale)
    if self.classified ~= nil then
        self.classified.sendimanaratescale:set(ratescale)
    end
end

function SendiMana:GetRateScale()
    if self.inst.components.sendimana ~= nil then
        return self.inst.components.sendimana:GetRateScale()
    elseif self.classified ~= nil then
        return self.classified.sendimanaratescale:value()
    else
        return RATE_SCALE.NEUTRAL
    end
end

return SendiMana