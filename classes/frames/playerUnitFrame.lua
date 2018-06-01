QhunUnitHealth.PlayerUnitFrame = {}
QhunUnitHealth.PlayerUnitFrame.__index = QhunUnitHealth.PlayerUnitFrame

function QhunUnitHealth.PlayerUnitFrame.new(uiInstance)
    -- call super class
    local instance =
        QhunUnitHealth.AbstractUnitFrame.new(
        uiInstance,
        "player",
        {
            "PLAYER_ENTERING_WORLD"
        },
        PlayerFrameHealthBar,
        PlayerFrameManaBar
    )

    -- bind current values
    setmetatable(instance, QhunUnitHealth.PlayerUnitFrame)

    -- add properties
    instance._alternatePowerObject = PlayerFrameAlternateManaBar

    -- create the visible frame
    instance._healthFrame = instance:createFrame("HEALTH")
    instance._powerFrame = instance:createFrame("POWER")
    instance._alternatePowerFrame = instance:createFrame("ALTERNATEPOWER")

    return instance
end

-- set inheritance
setmetatable(QhunUnitHealth.PlayerUnitFrame, {__index = QhunUnitHealth.AbstractUnitFrame})

--[[
    PUBLIC FUNCTIONS
]]
-- update the player resource frame
function QhunUnitHealth.PlayerUnitFrame:update(...)
    self:genericUpdate("player")
end

-- get the current storage options for the playerUnitFrame
function QhunUnitHealth.PlayerUnitFrame:getOptions()
    return QhunUnitHealth.Storage:get("PLAYER")
end

-- is the player frame enabled
function QhunUnitHealth.PlayerUnitFrame:isEnabled()
    return QhunUnitHealth.Storage:get("PLAYER_ENABLED")
end