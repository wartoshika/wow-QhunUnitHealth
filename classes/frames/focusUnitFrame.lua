QhunUnitHealth.FocusUnitFrame = {}
QhunUnitHealth.FocusUnitFrame.__index = QhunUnitHealth.FocusUnitFrame

function QhunUnitHealth.FocusUnitFrame.new(uiInstance)
    -- call super class
    local instance =
        QhunUnitHealth.AbstractUnitFrame.new(
        uiInstance,
        "focus",
        {
            "PLAYER_FOCUS_CHANGED"
        },
        FocusFrameHealthBar,
        FocusFrameManaBar
    )

    -- bind current values
    setmetatable(instance, QhunUnitHealth.FocusUnitFrame)

    -- create the visible frame
    instance._healthFrame = instance:createFrame("HEALTH")
    instance._powerFrame = instance:createFrame("POWER")

    return instance
end

-- set inheritance
setmetatable(QhunUnitHealth.FocusUnitFrame, {__index = QhunUnitHealth.AbstractUnitFrame})

--[[
    PUBLIC FUNCTIONS
]]
-- update the player resource frame
function QhunUnitHealth.FocusUnitFrame:update(...)
    self:genericUpdate("focus")
end

-- get the current storage options for the FocusUnitFrame
function QhunUnitHealth.FocusUnitFrame:getOptions()
    return QhunUnitHealth.Storage:get("FOCUS")
end

-- is the focus frame enabled
function QhunUnitHealth.FocusUnitFrame:isEnabled()
    return QhunUnitHealth.Storage:get("FOCUS_ENABLED")
end