local CONST = TUNING.SENDI

local function onmax(self, max)
    self.inst.replica.sendimana:SetMaxSendiMana(max)
end

local function oncurrent(self, current)
    self.inst.replica.sendimana:SetCurrent(current)
end

local function onratescale(self, ratescale)
    self.inst.replica.sendimana:SetRateScale(ratescale)
end

local SendiMana = Class(function(self, inst)
    self.inst = inst
    self.max = CONST.MANA_MAX_DEFAULT
    self.current = CONST.MANA_CURRENT_DEFAULT

	self.rate = 0
	self.ratescale = RATE_SCALE.NEUTRAL
	
	self.inst:ListenForEvent("respawn", function(inst) self:OnRespawn() end)
	self.inst:StartUpdatingComponent(self)
	
end, nil, {
	max = onmax,
    current = oncurrent,
    ratescale = onratescale,
})

function SendiMana:SetModifier(key, value)
    if value == nil or value == 0 then
        return self:RemoveModifier(key)
    elseif self._modifiers == nil then
        self._modifiers = { [key] = value }
        self.rate = value
        return 
    end
    local m = self._modifiers[key]
    if m == value then
        return 
    end
    self._modifiers[key] = value
    self.rate = self.rate + value - (m or 0)
end

function SendiMana:RemoveModifier(key)
    if self._modifiers == nil then
        return 
    end
    local m = self._modifiers[key]
    if m == nil then
        return 
    end
    self._modifiers[key] = nil
    if next(self._modifiers) == nil then
        self._modifiers = nil
        self.rate = 0
    else
        self.rate = self.rate - m
    end
end

function SendiMana:OnRespawn()
	self.current = CONST.MANA_CURRENT_ONRESPAWN
end

function SendiMana:OnSave()
	return {sendimana = self.current}
end

function SendiMana:OnLoad(data)
    if data.sendimana then
        self.current = data.sendimana
        self:DoDelta(0)
    end
end

function SendiMana:LongUpdate(dt)
	self:DoDec(dt, true)
end

function SendiMana:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max, self.ratescale)
end

function SendiMana:SetMax(amount)
    self.max = amount
end

function SendiMana:DoDelta(delta, overtime)
    local old = self.current
	self.current = self.current + delta
    if self.current < 0 then 
        self.current = 0
    elseif self.current > self.max then
        self.current = self.max
    end
	
    self.inst:PushEvent("sendimanadelta", {oldpercent = old/self.max, newpercent = self.current/self.max, overtime = overtime})
end

function SendiMana:GetPercent()
    return self.current / self.max
end

function SendiMana:GetCurrent()
	return self.current
end

function SendiMana:SetPercent(p)
    local old = self.current
    self.current = p * self.max
    self.inst:PushEvent("sendimanadelta", {oldpercent = old/self.max, newpercent = p})
end

function SendiMana:GetRateScale()
	return self.ratescale
end

function SendiMana:RecalcRateScale()
	self.ratescale =
		(self.rate <= -2 and RATE_SCALE.DECREASE_HIGH) or
        (self.rate <= -1 and RATE_SCALE.DECREASE_MED) or
        (self.rate < 0 and RATE_SCALE.DECREASE_LOW) or
		(self.current == self.max and RATE_SCALE.NEUTRAL) or
        (self.rate >= .2 and RATE_SCALE.INCREASE_HIGH) or
        (self.rate >= .13 and RATE_SCALE.INCREASE_MED) or
        (self.rate > 0 and RATE_SCALE.INCREASE_LOW) or
        RATE_SCALE.NEUTRAL
end

function SendiMana:OnUpdate(dt)
	self:RecalcRateScale()
	self:DoDelta(self.rate * dt, true)
end

SendiMana.LongUpdate = SendiMana.OnUpdate

return SendiMana