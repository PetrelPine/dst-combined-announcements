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

-- load configuration from modinfo.lua
hound_anc_flag = GetModConfigData("hound_announcer")
worm_anc_flag = GetModConfigData("worm_announcer")

fab_anc_flag = GetModConfigData("fabrication_announcer")
attack_anc_flag = GetModConfigData("attack_announcer")
cooldown_time = GetModConfigData("cooldown_time")

hammer_anc_flag = GetModConfigData("hammering_announcer")
light_anc_flag = GetModConfigData("lighting_announcer")

appear_anc_flag = GetModConfigData("appear_announcer")
disappear_anc_flag = GetModConfigData("disappear_announcer")
death_anc_flag = GetModConfigData("death_announcer")
-- load configuration from modinfo.lua end


-- buildings need to perform fabrication check
local PREFABS_CHECK = {
    arrowsign_post = true,
    beebox = true,
    beehive = true,
    berrybush = true,
    berrybush2 = true,
    berrybush_juicy = true,
    birdcage = true,
    cartographydesk = true,
    catcoonden = true,
    cave_banana_tree = true,
    coldfirepit = true,
    cookpot = true,
    dragonflychest = true,
    dragonflyfurnace = true,
    saladfurnace = true,
    endtable = true,
    slow_farmplot = true,
    fast_farmplot = true,
    fence = true,
    fence_gate = true,
    firepit = true,
    firesuppressor = true,
    grass = true,
    homesign = true,
    hound_mound = true,
    icebox = true,
    lightningrod = true,
    livingtree = true,
    meatrack = true,
    mermhouse = true,
    minisign = true,
    monkeybarrel = true,
    moondial = true,
    mushroom_farm = true,
    mushroom_light = true,
    mushroom_light2 = true,
    nightlight = true,
    perdshrine = true,
    pighouse = true,
    pigtorch = true,
    pottedfern = true,
    rabbithouse = true,
    rainometer = true,
    resurrectionstatue = true,
    ruinsrelic_plate = true,
    ruinsrelic_bowl = true,
    ruinsrelic_chair = true,
    ruinsrelic_chipbowl = true,
    ruinsrelic_vase = true,
    ruinsrelic_table = true,
    saltlick = true,
    scarecrow = true,
    researchlab = true,
    researchlab2 = true,
    researchlab3 = true,
    researchlab4 = true,
    sapling = true,
    sculptingtable = true,
    sentryward = true,
    succulent_potted = true,
    telebase = true,
    tent = true,
    siestahut = true,
    townportal = true,
    treasurechest = true,
    wall_hay = true,
    wall_wood = true,
    wall_stone = true,
    wall_ruins = true,
    wall_moonrock = true,
    wardrobe = true,
    winterometer = true,
    winter_tree = true,
    winter_twiggytree = true,
    winter_deciduoustree = true,
    winter_treestand = true,
    seafaring_prototyper = true,
    saltbox = true,
    sisturn = true,
    lightning_rod = true,
    madscience_lab = true,
    dragonfly_chest = true,
    mermhouse_crafted = true,
    tacklestation = true,
    mermwatchtower = true,
    trophyscale_fish = true,
    townportal = true,
    mermthrone_construction = true,
    trophyscale_oversizedveggies = true,
    wintersfeastoven = true,
    table_winters_feast = true,
    wargshrine = true,
    pigshrine = true,
    yotb_beefaloshrine = true,
    beefalo_groomer = true,
    yotb_stage = true,
    yotb_post = true,
    yotb_sewingmachine = true,
    turfcraftingstation = true
}

-- waiting time between two messages (whether it is in cooldown status)
cooldown_status = false
-- function to restore the cooldown status to false
function cooldown_end() cooldown_status = false end

-- validate and announce fabrication
-- 不需要显示建造提示的物品名称
local build_not_display = {}

local function OnBuild_becomevalid(inst, prod)

    if PREFABS_CHECK[prod.prefab] then

        prod:AddTag("valid_ca_prod")

        if cooldown_status == false then

            if fab_anc_flag then
                -- 特定的物品不显示提示
                if not table.contains(build_not_display, prod:GetDisplayName()) then
                    GLOBAL.TheNet:Announce("A " .. prod:GetDisplayName() .. " has been made by " .. inst:GetDisplayName())
                end
            end

            -- 在日志中输出
            print("A " .. prod:GetDisplayName() .. " has been made by " .. inst:GetDisplayName())

            if GLOBAL.TheNet:GetIsServer() then
                GLOBAL.TheWorld:DoPeriodicTask(cooldown_time, cooldown_end)
            end

        end

        cooldown_status = true

    end

    if inst.components.builder.bn_Old_onBuild_Fn then
        inst.components.builder.bn_Old_onBuild_Fn(inst, prod)
    end

end

AddPlayerPostInit(function(inst)

    if inst.components.builder then

        if inst.components.builder.onBuild then
            inst.components.builder.bn_Old_onBuild_Fn = inst.components.builder.onBuild
        end

        inst.components.builder.onBuild = OnBuild_becomevalid

    end

end)
-- validate and announce fabrication end


-- hammering announcement
local _ACTION_HAMMER = GLOBAL.ACTIONS.HAMMER.fn

  -- 不需要显示敲除提示的物品名称
local hammer_not_display = {

}

GLOBAL.ACTIONS.HAMMER.fn = function(act)

    if act.doer and act.target and act.target.components.workable.workleft == 1 then

        if hammer_anc_flag then
            -- 特定的物品不显示提示
            if not table.contains(hammer_not_display, act.target.name) then
                GLOBAL.TheNet:Announce(act.doer.name .. " has hammered the " .. act.target.name)
            end
        end

        -- 在日志中输出
        if act.doer.userid then
            print(act.doer.name .. " (" .. act.doer.userid .. ")" .. " has hammered the " .. act.target.name)
        end

    end

    return _ACTION_HAMMER(act)

end
-- hammering announcement end


-- lighting announcement
local _ACTION_LIGHT = GLOBAL.ACTIONS.LIGHT.fn

GLOBAL.ACTIONS.LIGHT.fn = function(act)

    if act.doer and act.target then

        if light_anc_flag then
            GLOBAL.TheNet:Announce(act.doer.name .. " has lit the " .. act.target.name)
        end

        if act.doer.userid then
            print(act.doer.name .. " (" .. act.doer.userid .. ")" .. " has lit the " .. act.target.name)
        end

    end

    return _ACTION_LIGHT(act)

end
-- lighting announcement end


-- important under attack announcement
FOLLOWERNAMES = {

    "chester",  -- 切斯特
    "hutch",  -- 哈奇
    "glommer",  -- 格罗姆

    "wall_hay",  -- 草墙
    "wall_wood",  -- 木墙
    "wall_stone",  -- 石墙
    "wall_ruins",  -- 铥矿墙
    "wall_moonrock",  -- 月石墙

}

function followers(inst)

    function followerattacked(inst, data)

        if cooldown_status == false then

            if attack_anc_flag then
                GLOBAL.TheNet:Announce(inst:GetDisplayName() .. " is attacked by " .. data.attacker:GetDisplayName())
            end

            print(inst:GetDisplayName() .. " is attacked by " .. data.attacker:GetDisplayName())

            if GLOBAL.TheNet:GetIsServer() then
                GLOBAL.TheWorld:DoPeriodicTask(cooldown_time, cooldown_end)
            end

        end

        cooldown_status = true

    end

    inst:ListenForEvent("attacked", followerattacked)

end

for k, v in pairs(FOLLOWERNAMES) do AddPrefabPostInit(v, followers) end
-- important under attack announcement end


-- mob announcement
MOBNAMES_TOTAL = {  -- 所有提示的怪物

    -- 四季boss
    "bearger",  -- 熊大
    "deerclops",  -- 巨鹿
    "moose",  -- 麋鹿鹅
    "dragonfly",  -- 龙蝇

    -- boss级别
    "minotaur",  -- 远古守卫者
    "klaus",  -- 克劳斯
    "antlion",  -- 蚁狮
    "beequeen",  -- 蜂后
    "toadstool",  -- 苦难蟾蜍
    "toadstool_dark",  -- 暗黑苦难蟾蜍
    "stalker",  -- 暗影编织者(洞穴)
    "stalker_forest",  -- 暗影编织者(地面)
    "stalker_atrium",  -- 暗影编织者(远古)
    "malbatross",  -- 邪天翁
    "crabking",  -- 帝王蟹

    -- 小型boss级别
    "lordfruitfly",  -- 果蝇王
    "mermking",  -- 鱼人王
    "warg",  -- 狗王
    "spat",  -- 钢羊
    "spiderqueen",  -- 蜘蛛女王

    -- 树人
    "leif",  -- 树人守卫(常青树)
    "leif_sparse",  -- 树人守卫(桦树)

    -- 齿轮机器
    "knight",  -- 发条骑士
    "bishop",  -- 发条主教
    "rook",  -- 发条战车
    "knight_nightmare",  -- 破损的发条骑士
    "bishop_nightmare",  -- 破损的发条主教
    "rook_nightmare",  -- 破损的发条战车
    "shadow_knight",  -- 暗影发条骑士
    "shadow_bishop",  -- 暗影发条主教
    "shadow_rook",  -- 暗影发条战车

    -- 影怪
    "crawlinghorror",  -- 爬行影怪(标准)
    "crawlingnightmare",  -- 爬行影怪(暴动阶段生成)
    "terrorbeak",  -- 尖嘴影怪(标准)
    "nightmarebeak",  -- 尖嘴影怪(暴动阶段生成)
    "oceanhorror",  -- 利爪影怪(海上)

    -- 主动攻击生物
    "walrus",  -- 海象
    "little_walrus",  -- 小海象
    "tallbird",  -- 高脚鸟
    "merm",  -- 鱼人
    "pigguard",  -- 猪人守卫
    "mermguard",  -- 鱼人守卫

    -- 被动攻击生物
    "beefalo",  -- 弗洛牛
    "babybeefalo",  -- 小弗洛牛
    "koalefant_summer",  -- 夏天大象
    "koalefant_winter",  -- 冬天大象
    "lightninggoat",  -- 电羊
    "pigman",  -- 猪人
    "manrabbit",  -- 兔人

    -- 洞穴生物
    "slurper",  -- 舔食者
    "slurtle",  -- 洞穴蜗牛1
    "snurtle",  -- 洞穴蜗牛2
    "tentacle_pillar",  -- 洞穴大触手
    "worm",  -- 洞穴蠕虫

    -- 混合
    "lureplant",  -- 食人花
    "krampus",  -- 坎普斯
    "mossling",  -- 夏季boss的小鸭子
    "tentacle",  -- 触手

    -- 随从
    "chester",  -- 切斯特
    "hutch",  -- 哈奇
    "glommer",  -- 格罗姆

}

MOBNAMES_APPEAR = {  -- 出现提示的怪物

    "bearger",  -- 熊大
    "deerclops",  -- 巨鹿
    "moose",  -- 麋鹿鹅
    "dragonfly",  -- 龙蝇

    "minotaur",  -- 远古守卫者
    "klaus",  -- 克劳斯
    "antlion",  -- 蚁狮
    "beequeen",  -- 蜂后
    "toadstool",  -- 苦难蟾蜍
    "toadstool_dark",  -- 暗黑苦难蟾蜍
    "stalker",  -- 暗影编织者(洞穴)
    "stalker_forest",  -- 暗影编织者(地面)
    "stalker_atrium",  -- 暗影编织者(远古)
    "malbatross",  -- 邪天翁
    "crabking",  -- 帝王蟹
    "lordfruitfly",  -- 果蝇王
    "mermking",  -- 鱼人王
    "mermguard",  -- 鱼人守卫
    "leif",  -- 树人守卫(常青树)
    "leif_sparse",  -- 树人守卫(桦树)
    "shadow_knight",  -- 暗影发条骑士
    "shadow_bishop",  -- 暗影发条主教
    "shadow_rook",  -- 暗影发条战车

    "spiderqueen",  -- 蜘蛛女王
    "warg",  -- 狗王
    "spat",  -- 钢羊

    "walrus",  -- 海象
    "little_walrus",  -- 小海象
    "koalefant_summer",  -- 夏天大象
    "koalefant_winter",  -- 冬天大象
    "lightninggoat",  -- 电羊
    "krampus",  -- 坎普斯

    "chester",  -- 切斯特
    "hutch",  -- 哈奇
    "glommer",  -- 格罗姆

    "lureplant",  -- 食人花

}

MOBNAMES_DISAPPEAR = {  -- 消失提示的怪物

    "bearger",  -- 熊大
    "deerclops",  -- 巨鹿
    "moose",  -- 麋鹿鹅
    "dragonfly",  -- 龙蝇

    "minotaur",  -- 远古守卫者
    "klaus",  -- 克劳斯
    "antlion",  -- 蚁狮
    "beequeen",  -- 蜂后
    "toadstool",  -- 苦难蟾蜍
    "toadstool_dark",  -- 暗黑苦难蟾蜍
    "stalker",  -- 暗影编织者(洞穴)
    "stalker_forest",  -- 暗影编织者(地面)
    "stalker_atrium",  -- 暗影编织者(远古)
    "malbatross",  -- 邪天翁
    "crabking",  -- 帝王蟹

    "spiderqueen",  -- 蜘蛛女王
    "warg",  -- 狗王
    "spat",  -- 钢羊

    "walrus",  -- 海象
    "little_walrus",  -- 小海象
    "koalefant_summer",  -- 夏天大象
    "koalefant_winter",  -- 冬天大象
    "krampus",  -- 坎普斯

}

MOBNAMES_DEATH = {  -- 死亡提示的怪物

    "bearger",  -- 熊大
    "deerclops",  -- 巨鹿
    "moose",  -- 麋鹿鹅
    "dragonfly",  -- 龙蝇

    "minotaur",  -- 远古守卫者
    "klaus",  -- 克劳斯
    "antlion",  -- 蚁狮
    "beequeen",  -- 蜂后
    "toadstool",  -- 苦难蟾蜍
    "toadstool_dark",  -- 暗黑苦难蟾蜍
    "stalker",  -- 暗影编织者(洞穴)
    "stalker_forest",  -- 暗影编织者(地面)
    "stalker_atrium",  -- 暗影编织者(远古)
    "malbatross",  -- 邪天翁
    "crabking",  -- 帝王蟹

    "lordfruitfly",  -- 果蝇王
    "mermking",  -- 鱼人王
    "leif",  -- 树人守卫(常青树)
    "leif_sparse",  -- 树人守卫(桦树)

    "shadow_knight",  -- 暗影发条骑士
    "shadow_bishop",  -- 暗影发条主教
    "shadow_rook",  -- 暗影发条战车

    "spiderqueen",  -- 蜘蛛女王
    "warg",  -- 狗王
    "spat",  -- 钢羊

    "knight",  -- 发条骑士
    "bishop",  -- 发条主教
    "rook",  -- 发条战车
    "knight_nightmare",  -- 破损的发条骑士
    "bishop_nightmare",  -- 破损的发条主教
    "rook_nightmare",  -- 破损的发条战车

    "walrus",  -- 海象
    "little_walrus",  -- 小海象
    "beefalo",  -- 弗洛牛
    "babybeefalo",  -- 小弗洛牛
    "koalefant_summer",  -- 夏天大象
    "koalefant_winter",  -- 冬天大象
    "lightninggoat",  -- 电羊
    "krampus",  -- 坎普斯

    "merm",  -- 鱼人
    "mermguard",  -- 鱼人守卫
    "mossling",  -- 夏季boss的小鸭子
    "pigman",  -- 猪人
    "pigguard",  -- 猪人守卫
    "manrabbit",  -- 兔人
    "tallbird",  -- 高脚鸟
    "slurper",  -- 舔食者
    "slurtle",  -- 洞穴蜗牛1
    "snurtle",  -- 洞穴蜗牛2
    "tentacle",  -- 触手
    "tentacle_pillar",  -- 大触手
    "worm",  -- 洞穴蠕虫

    "crawlinghorror",  -- 爬行影怪(标准)
    "crawlingnightmare",  -- 爬行影怪(暴动阶段生成)
    "terrorbeak",  -- 尖嘴影怪(标准)
    "nightmarebeak",  -- 尖嘴影怪(暴动阶段生成)
    "oceanhorror",  -- 利爪影怪(海上)

    "chester",  -- 切斯特
    "hutch",  -- 哈奇
    "glommer",  -- 格罗姆

    "lureplant",  -- 食人花

}

-- mob被攻击
function mob_attacked(inst, data)
    inst.lastAttacker_name = data.attacker:GetDisplayName()
end

-- mob出现
function mob_appear(inst, data)

    local x, y, z = inst.Transform:GetWorldPosition()
    local coor = " (" .. (math.floor(x)) .. ", " .. (math.floor(z)) .. ")" or "UNKNOWN COORDINATE"
    local ann_msg = inst:GetDisplayName() .. " appears " .. coor

    inst:DoTaskInTime(0.75, function(inst)  -- 出现添加0.75秒延迟(第三位显示)
        GLOBAL.TheNet:Announce(ann_msg)
        print(ann_msg)
    end)

end

-- mob消失
function mob_disappear(inst, data)

    local x, y, z = inst.Transform:GetWorldPosition()
    local coor = " (" .. (math.floor(x)) .. ", " .. (math.floor(z)) .. ")" or "UNKNOWN COORDINATE"
    local ann_msg = inst:GetDisplayName() .. " disappears " .. coor
    
    inst:DoTaskInTime(0.5, function(inst)  -- 消失添加0.5秒延迟(第二位显示)
        GLOBAL.TheNet:Announce(ann_msg)
        print(ann_msg)
    end)

end

-- mob死亡
function mob_killed(inst, data)

    inst.lastAttacker_name = data.afflicter and data.afflicter:GetDisplayName() or inst.lastAttacker_name or "???"

    inst:DoTaskInTime(0.25, function(inst)  -- 死亡添加0.25秒延迟(最先显示)
        GLOBAL.TheNet:Announce(inst:GetDisplayName() .. " is killed by " .. inst.lastAttacker_name)

        local lastAttacker_name = inst.lastAttacker_name or "???"
        print(inst:GetDisplayName() .. " is killed by " .. "(" .. lastAttacker_name .. ")")
    end)

end

for k, v in pairs(MOBNAMES_TOTAL) do 

    AddPrefabPostInit(v, function(inst, data)

        if appear_anc_flag and table.contains(MOBNAMES_APPEAR, v) then
            inst:DoTaskInTime(0.5, mob_appear)  -- mob出现时执行
        end

        if disappear_anc_flag and table.contains(MOBNAMES_DISAPPEAR, v) then
            inst:ListenForEvent("onremove", mob_disappear)  -- mob消失时触发
        end
        
        if death_anc_flag and table.contains(MOBNAMES_DEATH, v) then
            inst:ListenForEvent("attacked", mob_attacked)  -- mob被攻击时触发
            inst:ListenForEvent("death", mob_killed)  -- mob死亡时触发
        end
    
    end)

end
-- mob announcement end


-- validate fabrication
local function HookThis(prefab)
    AddPrefabPostInit(prefab, function(inst)
        if not GLOBAL.TheWorld.ismastersim then return end
        inst:AddTag("valid_ca_prod")
    end)
end

for prefab, _ in pairs(PREFABS_CHECK) do HookThis(prefab) end
-- validate fabrication end


-- hound / worm attack announcement
local DAYS_IN_ADVANCE = 5
local secADay = 8 * 60

local function second2Day(val) return math.floor(val / secADay) end

-- hound attack announcement
local function HoundAttackString(timeToAttack)

    if timeToAttack == 0 then return "The hounds will attack today!"
    else return "The hounds will attack in " .. timeToAttack .. ' days' end

end

local function HoundAttack(inst)

    inst:ListenForEvent("cycleschanged", function(inst)

        if GLOBAL.TheWorld:HasTag("cave") then return end  -- 是洞穴 函数不执行

        if not GLOBAL.TheWorld.components.hounded then return end

        local _timeToAttack = GLOBAL.TheWorld.components.hounded:GetTimeToAttack()
        local timeToAttack = second2Day(_timeToAttack)

        if timeToAttack <= DAYS_IN_ADVANCE and GLOBAL.TheWorld.state.cycles ~= 0 then

            -- 服务器公屏播报
            GLOBAL.TheNet:Announce(HoundAttackString(timeToAttack))

            -- 玩家说话
            for i, v in ipairs(GLOBAL.AllPlayers) do
                v.components.talker:Say(HoundAttackString(timeToAttack), 10, true, true, false)
            end

        end

        print("Hounds attack in " .. timeToAttack .. " (" .. _timeToAttack .. ") days")

    end, GLOBAL.TheWorld)

end
-- hound attack announcement end

-- worm attack announcement
local function WormAttackString(timeToAttack)

    if timeToAttack == 0 then return "The worms will attack today!"
    else return "The worms will attack in " .. timeToAttack .. ' days' end

end

local function WormAttack(inst)

    inst:ListenForEvent("cycleschanged", function(inst)

        if not GLOBAL.TheWorld:HasTag("cave") then return end  -- 不是洞穴 函数不执行

        if not GLOBAL.TheWorld.components.hounded then return end

        local _timeToAttack = GLOBAL.TheWorld.components.hounded:GetTimeToAttack()
        local timeToAttack = second2Day(_timeToAttack)

        if timeToAttack <= DAYS_IN_ADVANCE and GLOBAL.TheWorld.state.cycles ~= 0 then

            -- 服务器公屏播报
            GLOBAL.TheNet:Announce(WormAttackString(timeToAttack))

            -- 玩家说话  -- 有bug, 好像猎犬和蠕虫只会说一个(猎犬有，蠕虫没有)
            for i, v in ipairs(GLOBAL.AllPlayers) do
                v.components.talker:Say(WormAttackString(timeToAttack), 10, true, true, false)
            end

        end

        print("Worms attack in " .. timeToAttack .. " (" .. _timeToAttack .. ") days")

    end, GLOBAL.TheWorld)

end
-- worm attack announcement end

-- add hound / worm attack trigger
if hound_anc_flag then AddPrefabPostInit("world", HoundAttack) end
if worm_anc_flag then AddPrefabPostInit("cave", WormAttack) end
-- add hound / worm attack trigger end
