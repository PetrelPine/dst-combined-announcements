-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=631648169]
-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=1894295075]
-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=1887331613]
-- Mod Reference: [https://steamcommunity.com/sharedfiles/filedetails/?id=2337978350]
--[[
-- Mod Name: Combined Announcements
-- Author: PetrelPine
-- Github Link: https://github.com/PetrelPine/dst-combined-announcements
-- Steam Link: https://steamcommunity.com/sharedfiles/filedetails/?id=2691240099
]]

name = "Combined Announcements"
version = "1.5"
description = "A mod that "
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
        name = "hound_announcer",
        label = "Hound Attack",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should hound attacks be announced in the server?",
    },

    {
        name = "worm_announcer",
        label = "Worm Attack",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should worm attacks be announced in the server?",
    },

    {
        name = "fabrication_announcer",
        label = "Make Important",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should fabrications be announced in the server?",
    },

    {
        name = "attack_announcer",
        label = "Attack Important",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should attacks on the important be announced?",
    },

    {
        name = "cooldown_time",
        label = "Cooldown Duration",
        options = {
            {description = "None (Spammy)", data = 0},
            {description = "3 seconds", data = 3},
            {description = "5 seconds", data = 5},
            {description = "8 seconds", data = 8},
            {description = "15 seconds", data = 15},
        },
        default = 5,
        hover = "(Not Working) How long should we wait to allow another announcement? (only for make important and attack important)",    
    },

    {
        name = "hammering_announcer",
        label = "Hammering Important",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should hammering be announced in the server?",
    },

    {
        name = "lighting_announcer",
        label = "Lighting Important",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should lighting be announced in the server?",
    },
    
    {
        name = "appear_announcer",
        label = "Important Appearance",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should the appearance of important mobs be announced?",
    },

    {
        name = "disappear_announcer",
        label = "Important Disappearance",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should the disappearance of important mobs be announced?",
    },

    {
        name = "death_announcer",
        label = "Important Death",
        options = {
            {description = "Announce", data = true},
            {description = "Silent", data = false},
        },
        default = true,
        hover = "Should the death of important mobs be announced?",
    },

}
--]]
