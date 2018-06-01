QhunUnitHealth.TargetOfTargetUnitFrame = {}
QhunUnitHealth.TargetOfTargetUnitFrame.__index = QhunUnitHealth.TargetOfTargetUnitFrame

function QhunUnitHealth.TargetOfTargetUnitFrame.new(uiInstance)
    -- call super class
    local instance =
        QhunUnitHealth.AbstractUnitFrame.new(
        uiInstance,
        "targettarget",
        {
            "UNIT_TARGET"
        },
        TargetFrameToTHealthBar,
        TargetFrameToTManaBar
    )

    -- bind current values
    setmetatable(instance, QhunUnitHealth.TargetOfTargetUnitFrame)

    -- create the visible frame
    instance._healthFrame = instance:createFrame("HEALTH")
    instance._powerFrame = instance:createFrame("POWER")

    return instance
end

-- set inheritance
setmetatable(QhunUnitHealth.TargetOfTargetUnitFrame, {__index = QhunUnitHealth.AbstractUnitFrame})

--[[
    PUBLIC FUNCTIONS
]]
-- update the player resource frame
function QhunUnitHealth.TargetOfTargetUnitFrame:update(...)
    self:genericUpdate("targettarget")
end

-- get the current storage options for the TargetOfTargetUnitFrame
function QhunUnitHealth.TargetOfTargetUnitFrame:getOptions()
    return QhunUnitHealth.Storage:get("TARGET_OF_TARGET")
end

-- is the tot frame enabled
function QhunUnitHealth.TargetOfTargetUnitFrame:isEnabled()
    return QhunUnitHealth.Storage:get("TARGET_OF_TARGET_ENABLED")
end