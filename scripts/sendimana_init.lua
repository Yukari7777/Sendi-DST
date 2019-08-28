local require = GLOBAL.require
local KnownModIndex = GLOBAL.KnownModIndex
local Text = require "widgets/text"
local Image = require "widgets/image"
local NUMBERFONT = GLOBAL.NUMBERFONT

AddReplicableComponent("sendimana")

local function GetModName(modname) -- modinfo's modname and internal modname is different.
	for _, knownmodname in ipairs(KnownModIndex:GetModsToLoad()) do
		if KnownModIndex:GetModInfo(knownmodname).name == modname  then
			return knownmodname
		end
	end
end

local function GetModOptionValue(knownmodname, known_option_name)
	local modinfo = KnownModIndex:GetModInfo(knownmodname)
	for _,option in pairs(modinfo.configuration_options) do
		if option.name == known_option_name then
			return option.saved
		end
	end
end

local function StatusDisplaysInit(self)
	if self.owner:HasTag("sendi") then
		local ManaBadge = require "widgets/sendimanabadge"

		self.combinedmod = GetModName("Combined Status")

		self.csmana = self:AddChild(ManaBadge(self.owner))
		if self.combinedmod ~= nil then
			self.brain:SetPosition(0, 35, 0)
			self.stomach:SetPosition(-62, 35, 0)
			self.heart:SetPosition(62, 35, 0)

			self.csmana:SetScale(.9,.9,.9)
			self.csmana:SetPosition(-62, -50, 0)
			self.csmana.combinedmod = true
			self.csmana.showmaxonnumbers = GetModOptionValue(self.combinedmod, "SHOWMAXONNUMBERS")

			self.csmana.bg = self.csmana:AddChild(Image("images/status_bgs.xml", "status_bgs.tex"))
			self.csmana.bg:SetScale(.4,.43,0)
			self.csmana.bg:SetPosition(-.5, -40, 0)
		
			self.csmana.num:SetFont(NUMBERFONT)
			self.csmana.num:SetSize(28)
			self.csmana.num:SetPosition(3.5, -40.5, 0)
			self.csmana.num:SetScale(1,.78,1)

			self.csmana.num:MoveToFront()
			self.csmana.num:Show()

			self.csmana.maxnum = self.csmana:AddChild(Text(NUMBERFONT, self.csmana.showmaxonnumbers and 25 or 33))
			self.csmana.maxnum:SetPosition(6, 0, 0)
			self.csmana.maxnum:MoveToFront()
			self.csmana.maxnum:Hide()
		else
			self.csmana:SetPosition(-40, -50,0)
			self.brain:SetPosition(40, -50, 0)
			self.stomach:SetPosition(-40,17,0)
		end
		
		self.inst:ListenForEvent("sendimanadelta", function(inst, data) self.csmana:SetPercent(data.newpercent, self.owner.replica.sendimana:Max()) end, self.owner)

		local _SetGhostMode = self.SetGhostMode
		function self:SetGhostMode(ghostmode)
			if not self.isghostmode == not ghostmode then --force boolean
				return
			end

			_SetGhostMode(self, ghostmode)
			if ghostmode then
				self.csmana:Hide()
			else
				self.csmana:Show()
			end
		end
	end
end

--AddClassPostConstruct("widgets/statusdisplays", StatusDisplaysInit)
