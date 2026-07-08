-- TestMode.lua for Timber's Raid Summoner
-- Development-only file for testing and screenshots.
-- Remove this file before distributing the addon to other users.
--
-- Usage:
--   /trs testmode <raidCount> <queueCount>   (e.g. /trs testmode 25 4)
--   /trs testmode off

local TRS = _G["TimbersRaidSummoner"]
if not TRS then return end

-- Pool of 40 unique fake characters spanning all Classic Era classes.
local FAKE_POOL = {
    { name = "Timberwind",  class = "Priest",   classToken = "PRIEST",   level = 60 },
    { name = "Arathorn",    class = "Warrior",  classToken = "WARRIOR",  level = 60 },
    { name = "Sylvanna",    class = "Druid",    classToken = "DRUID",    level = 60 },
    { name = "Grimbold",    class = "Rogue",    classToken = "ROGUE",    level = 60 },
    { name = "Faelindra",   class = "Mage",     classToken = "MAGE",     level = 60 },
    { name = "Brockr",      class = "Warrior",  classToken = "WARRIOR",  level = 60 },
    { name = "Thessally",    class = "Priest",   classToken = "PRIEST",   level = 60 },
    { name = "Vaelthas",    class = "Warlock",  classToken = "WARLOCK",  level = 60 },
    { name = "Mornara",     class = "Paladin",  classToken = "PALADIN",  level = 60 },
    { name = "Skullgrunt",  class = "Shaman",   classToken = "SHAMAN",   level = 60 },
    { name = "Liriel",      class = "Hunter",   classToken = "HUNTER",   level = 60 },
    { name = "Dargath",     class = "Warrior",  classToken = "WARRIOR",  level = 60 },
    { name = "Aelundra",    class = "Druid",    classToken = "DRUID",    level = 60 },
    { name = "Thorvis",     class = "Paladin",  classToken = "PALADIN",  level = 60 },
    { name = "Zaeloth",     class = "Mage",     classToken = "MAGE",     level = 60 },
    { name = "Grunhild",    class = "Shaman",   classToken = "SHAMAN",   level = 60 },
    { name = "Selandris",   class = "Priest",   classToken = "PRIEST",   level = 60 },
    { name = "Ragnuk",      class = "Warrior",  classToken = "WARRIOR",  level = 60 },
    { name = "Felanris",     class = "Rogue",    classToken = "ROGUE",    level = 60 },
    { name = "Darkweave",   class = "Warlock",  classToken = "WARLOCK",  level = 60 },
    { name = "Ironfist",    class = "Hunter",   classToken = "HUNTER",   level = 60 },
    { name = "Bladewind",   class = "Warrior",  classToken = "WARRIOR",  level = 60 },
    { name = "Moonwhisper", class = "Druid",    classToken = "DRUID",    level = 60 },
    { name = "Coldsnap",    class = "Mage",     classToken = "MAGE",     level = 60 },
    { name = "Rageclaw",    class = "Druid",    classToken = "DRUID",    level = 60 },
    { name = "Caladrel",  class = "Priest",   classToken = "PRIEST",   level = 60 },
    { name = "Balgurr",   class = "Warrior",  classToken = "WARRIOR",  level = 60 },
    { name = "Voidcaller",  class = "Warlock",  classToken = "WARLOCK",  level = 60 },
    { name = "Thalindra",  class = "Hunter",   classToken = "HUNTER",   level = 60 },
    { name = "Kraegos", class = "Shaman",   classToken = "SHAMAN",   level = 60 },
    { name = "Iceweaver",   class = "Mage",     classToken = "MAGE",     level = 60 },
    { name = "Bladesinger", class = "Rogue",    classToken = "ROGUE",    level = 60 },
    { name = "Solvara", class = "Paladin",  classToken = "PALADIN",  level = 60 },
    { name = "Thornback",   class = "Druid",    classToken = "DRUID",    level = 60 },
    { name = "Mordecais", class = "Warlock",  classToken = "WARLOCK",  level = 60 },
    { name = "Stoneguard",  class = "Warrior",  classToken = "WARRIOR",  level = 60 },
    { name = "Zephera",  class = "Shaman",   classToken = "SHAMAN",   level = 60 },
    { name = "Nightstrike", class = "Rogue",    classToken = "ROGUE",    level = 60 },
    { name = "Aurannis", class = "Paladin",  classToken = "PALADIN",  level = 60 },
    { name = "Emberhunter", class = "Hunter",   classToken = "HUNTER",   level = 60 },
}

TRS.TestMode = {
    active      = false,
    raidCount   = 0,
    queueCount  = 0,
    fakeInRange = {},  -- pre-assigned per Enable() call
}

-- Called by the slash command handler. Returns true if the input was consumed.
function TRS.TestMode:HandleSlash(input)
    local lower = input:lower()
    if not lower:match("^testmode") then
        return false
    end

    if lower:match("^testmode%s+off") then
        self:Disable()
        return true
    end

    local n, m = lower:match("^testmode%s+(%d+)%s+(%d+)")
    if n and m then
        self:Enable(tonumber(n), tonumber(m))
        return true
    end

    print("|cFF00FF00TRS Test Mode:|r Usage: /trs testmode <raidCount> <queueCount>  |  /trs testmode off")
    return true
end

function TRS.TestMode:Enable(raidCount, queueCount)
    self.active     = true
    self.raidCount  = math.min(raidCount,  40)
    self.queueCount = math.min(queueCount, #FAKE_POOL)
    -- Randomly assign in-range status for each fake (~80% in range).
    self.fakeInRange = {}
    for _, fake in ipairs(FAKE_POOL) do
        self.fakeInRange[fake.name] = (math.random() < 0.8)
    end

    print(string.format("|cFF00FF00TRS Test Mode:|r Enabled -- %d raid members, %d summon queue entries",
        self.raidCount, self.queueCount))
    TRS:UpdateRaidList()
    TRS:UpdateSummonQueue()
end

function TRS.TestMode:Disable()
    self.active     = false
    self.raidCount  = 0
    self.queueCount = 0
    print("|cFF00FF00TRS Test Mode:|r Disabled")
    TRS:UpdateRaidList()
    TRS:UpdateSummonQueue()
end

-- Called by UpdateRaidList with the real groups table already populated.
-- Fills empty slots with fake members and applies leader/assistant icons.
function TRS.TestMode:AugmentGroups(groups)
    local playerName = UnitName("player")

    -- If the player is not in any group slot (e.g. solo/ungrouped), add them first.
    local playerFound = false
    for g = 1, 8 do
        for s = 1, #groups[g] do
            if groups[g][s].name == playerName then
                playerFound = true
                break
            end
        end
        if playerFound then break end
    end
    if not playerFound then
        local localClass, classToken = UnitClass("player")
        table.insert(groups[1], 1, {
            name        = playerName,
            unitId      = "player",
            level       = UnitLevel("player"),
            class       = localClass,
            classToken  = classToken,
            isOnline    = true,
            isLeader    = true,
            isAssistant = false,
            inRange     = true,
        })
    end

    -- Count real members; force player to show as leader.
    local totalReal = 0
    local realNames = {}
    for g = 1, 8 do
        for s = 1, #groups[g] do
            local m = groups[g][s]
            if m.name == playerName then
                m.isLeader    = true
                m.isAssistant = false
            end
            realNames[m.name] = true
            totalReal = totalReal + 1
        end
    end

    -- Build list of fake members whose names do not collide with real members.
    local available = {}
    for _, fake in ipairs(FAKE_POOL) do
        if not realNames[fake.name] then
            table.insert(available, fake)
        end
    end

    -- Fill empty slots with fake members until we reach raidCount.
    local fakeNeeded  = math.max(0, self.raidCount - totalReal)
    local fakeIndex   = 1
    local fakesPlaced = 0

    for g = 1, 8 do
        for slot = 1, 5 do
            if fakesPlaced >= fakeNeeded then break end
            if not groups[g][slot] then
                if fakeIndex <= #available then
                    groups[g][slot] = {
                        name        = available[fakeIndex].name,
                        unitId      = nil,
                        level       = available[fakeIndex].level,
                        class       = available[fakeIndex].class,
                        classToken  = available[fakeIndex].classToken,
                        isOnline    = true,
                        isLeader    = false,
                        isAssistant = false,
                        isFake      = true,
                        inRange     = TRS.TestMode.fakeInRange[available[fakeIndex].name],
                    }
                    fakeIndex   = fakeIndex + 1
                    fakesPlaced = fakesPlaced + 1
                end
            end
        end
        if fakesPlaced >= fakeNeeded then break end
    end

    -- If total displayed > 5, mark ceil(10%) of non-leader members as assistants.
    local totalDisplayed = totalReal + fakesPlaced
    if totalDisplayed > 5 then
        local numAssistants = math.ceil(totalDisplayed * 0.1)
        local count = 0
        for g = 1, 8 do
            for s = 1, 5 do
                if count >= numAssistants then break end
                local m = groups[g][s]
                if m and not m.isLeader and m.name ~= playerName then
                    m.isAssistant = true
                    count = count + 1
                end
            end
            if count >= numAssistants then break end
        end
    end
end

-- Returns the queue list to display: real entries first, then fakes padded to queueCount.
function TRS.TestMode:GetDisplayQueue()
    local queue     = {}
    local usedNames = {}

    -- Real queue entries always come first.
    local db = TimbersRaidSummonerDB
    if db and db.summonQueue then
        for _, entry in ipairs(db.summonQueue) do
            table.insert(queue, entry)
            usedNames[entry.name] = true
        end
    end

    -- Pad with out-of-range fake entries (consistent with their raid panel status).
    local baseTime = time()
    for _, fake in ipairs(FAKE_POOL) do
        if #queue >= self.queueCount then break end
        if not usedNames[fake.name] and self.fakeInRange[fake.name] == false then
            table.insert(queue, {
                name       = fake.name,
                timestamp  = baseTime - math.random(30, 300),
                classToken = fake.classToken,
                class      = fake.class,
                level      = fake.level,
                isFake     = true,
                inRange    = false,
            })
            usedNames[fake.name] = true
        end
    end

    return queue
end
