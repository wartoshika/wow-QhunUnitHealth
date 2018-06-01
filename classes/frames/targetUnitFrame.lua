QhunUnitHealth.TargetUnitFrame = {}
QhunUnitHealth.TargetUnitFrame.__index = QhunUnitHealth.TargetUnitFrame

function QhunUnitHealth.TargetUnitFrame.new(uiInstance)
    -- call super class
    local instance =
        QhunUnitHealth.AbstractUnitFrame.new(
        uiInstance,
        "target",
        {
            "PLAYER_TARGET_CHANGED"
        },
        TargetFrameHealthBar,
        TargetFrameManaBar
    )

    -- bind current values
    setmetatable(instance, QhunUnitHealth.TargetUnitFrame)

    -- create the visible frame
    instance._healthFrame = instance:createFrame("HEALTH")
    instance._powerFrame = instance:createFrame("POWER")

    return instance
end

-- set inheritance
setmetatable(QhunUnitHealth.TargetUnitFrame, {__index = QhunUnitHealth.AbstractUnitFrame})

--[[
    PUBLIC FUNCTIONS
]]
-- update the player resource frame
function QhunUnitHealth.TargetUnitFrame:update(...)
    self:genericUpdate("target")
end

-- get the current storage options for the TargetUnitFrame
function QhunUnitHealth.TargetUnitFrame:getOptions()
    return QhunUnitHealth.Storage:get("TARGET")
end

-- is the target frame enabled
function QhunUnitHealth.TargetUnitFrame:isEnabled()
    return QhunUnitHealth.Storage:get("TARGET_ENABLED")
end