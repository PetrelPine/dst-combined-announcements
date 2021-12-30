-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=631648169]
-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=1894295075]
-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=1887331613]
-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=2337978350]

name = "Combined Announcements"
version = "1.4"
description = "None"
author = "PetrelPine"

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true
client_only_mod = false
server_only_mod = true
all_clients_require_mod = false

---[[
configuration_options = {

	{
		name = "HOUNDANNOUNCER",
		label = "Hound Attack",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should hound attacks be announced in the server?",
	},

	{
		name = "WORMANNOUNCER",
		label = "Worm Attack",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should worm attacks be announced in the server?",
	},

	{
		name = "FABRICATIONANNOUNCER",
		label = "Make Important",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should fabrications be announced in the server?",
	},

	{
		name = "ATTACKANNOUNCER",
		label = "Attack Followers",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should the attack of followers be announced?",
	},

	{
		name = "COOLDOWNTIME",
		label = "Cooldown Duration",
		options = {
						{description = "None (Spammy)", data = 0},
						{description = "3 seconds", data = 3},
						{description = "5 seconds", data = 5},
						{description = "8 seconds", data = 8},
						{description = "15 seconds", data = 15},
					},
		default = 5,
		hover = "EXPERIMENTAL: How long should we wait to allow another announcement? (Not for deaths)",	
	},

	{
		name = "HAMMERINGANNOUNCER",
		label = "Hammering Important",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should hammering be announced in the server?",
	},

	{
		name = "LIGHTINGANNOUNCER",
		label = "Lighting Important",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should lighting be announced in the server?",
	},
	
	{
		name = "APPEARANNOUNCER",
		label = "Important Appearance",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should the appearance of Important Mobs be announced?",  --  This overrides cooldowns.
	},

	{
		name = "DISAPPEARANNOUNCER",
		label = "Important Disappearance",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should the disappearance of Important Mobs be announced?",  --  This overrides cooldowns.
	},

	{
		name = "DEATHANNOUNCER",
		label = "Important Death",
		options = {
						{description = "Announce", data = true},
						{description = "Silent", data = false},
					},
		default = true,
		hover = "Should the death of Important Mobs be announced?",  --  This overrides cooldowns.
	},

}
--]]
