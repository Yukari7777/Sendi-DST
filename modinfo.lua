name = "[DST]Sendi"
author = "doftksxk@naver.com"
version = "1.3.4" 
description = "[DST] Sendi :)~~~\n\nWhen [R] key is pressed\n[IGNIA RUN] is activated.\n\n\n\n\n[DST]센디 :)~~\n\n[R]키 입력시 [이그니아 런] 이 발동합니다.\n\n\n\n\nVersion : "..version.." "
forumthread = ""
api_version = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
	"character",
}

local Keys = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "PERIOD", "SLASH", "SEMICOLON", "TILDE", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "INSERT", "DELETE", "HOME", "END", "PAGEUP", "PAGEDOWN", "MINUS", "EQUALS", "BACKSPACE", "CAPSLOCK", "SCROLLOCK", "BACKSLASH"}

local RapierKey = {}
for i = 1, #Keys do RapierKey[i] = { description = ""..Keys[i].."", data = "KEY_"..Keys[i] } end


configuration_options = {
	{
		name = "language",
		label = "Language",
		hover = "Set Language",
		options = {
			{ description = "Auto", data = "AUTO" },
			{ description = "Korean", data = "" },
			{ description = "English", data = "_en" },
		},
		default = "AUTO",
	},
 
	{
		name = "skill_1",
		label = "Ignia Run Key",
		hover = "Set Skill Ignia Run's Keybind",
		options = RapierKey,
		default = "KEY_V",
	},
}