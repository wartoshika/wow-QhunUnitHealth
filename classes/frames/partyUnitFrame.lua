QhunUnitHealth.PartyUnitFrame = {}
QhunUnitHealth.PartyUnitFrame.__index = QhunUnitHealth.PartyUnitFrame

function QhunUnitHealth.PartyUnitFrame.new(uiInstance, partyUnitNumber)
    -- call super class
    local instance =
        QhunUnitHealth.AbstractUnitFrame.new(
        uiInstance,
        "target",
        {
            "PARTY_MEMBERS_CHANGED",
            "PARTY_MEMBER_DISABLE",
            "PARTY_MEMBER_ENABLE",
            "PLAYER_ENTERING_WORLD"
        },
        _G["PartyMemberFrame" .. partyUnitNumber .. "HealthBar"],
        _G["PartyMemberFrame" .. partyUnitNumber .. "ManaBar"]
    )

    -- bind current values
    setmetatable(instance, QhunUnitHealth.PartyUnitFrame)

    -- create the visible frame
    instance._healthFrame = instance:createFrame("HEALTH")
    instance._powerFrame = instance:createFrame("POWER")

    -- add properties
    instance._partyUnitNumber = partyUnitNumber

    return instance
end

-- set inheritance
setmetatable(QhunUnitHealth.PartyUnitFrame, {__index = QhunUnitHealth.AbstractUnitFrame})

--[[
    PUBLIC FUNCTIONS
]]
-- update the player resource frame
function QhunUnitHealth.PartyUnitFrame:update(unitId)
    self:genericUpdate("party" .. self._partyUnitNumber)
end

-- get the current storage options for the PartyUnitFrame
function QhunUnitHealth.PartyUnitFrame:getOptions()
    return QhunUnitHealth.Storage:get("PARTY")
end

-- is the party frame enabled
function QhunUnitHealth.PartyUnitFrame:isEnabled()
    return QhunUnitHealth.Storage:get("PARTY_ENABLED")
end