QhunUnitHealth.AbstractUnitFrame = {}
QhunUnitHealth.AbstractUnitFrame.__index = QhunUnitHealth.AbstractUnitFrame

-- constructor
--[[
    {
        uiInstance: {QhunUnitHealth.Ui}
        unitId: string,
        updateEvents: {
            [eventName: string]: nil
        },
        healthBarObject: WowFrameObject,
        manaBarObject: WowFrameObject
    }
]]
function QhunUnitHealth.AbstractUnitFrame.new(uiInstance, unitId, updateEvents, healthBarObject, manaBarObject)
    -- private properties
    local instance = {
        _unitId = unitId,
        _healthBarObject = healthBarObject,
        _manaBarObject = manaBarObject,
        _alternatePowerObject = nil,
        _updateEvents = {
            -- generic update events that all frames should have
            "UNIT_ENTERED_VEHICLE",
            "UNIT_EXITED_VEHICLE",
            "UNIT_HEALTH",
            "UNIT_POWER",
            "UNIT_MAXHEALTH",
            "UNIT_MAXPOWER"
        },
        _uiInstance = uiInstance
    }

    -- add other update events
    for _, v in pairs(updateEvents) do
        table.insert(instance._updateEvents, v)
    end

    setmetatable(instance, QhunUnitHealth.AbstractUnitFrame)

    return instance
end

--[[
    PRIVATE FUNCTIONS
]]
-- create the visible frame
--[[
    {
        what: string = HEALTH, POWER, ALTERNATEPOWER
    }
    returns WowFrameObject
]]
function QhunUnitHealth.AbstractUnitFrame:createFrame(what)
    -- get the current options for the target
    local options = self:getOptions()

    -- switch case prepare
    local whatSwitch = {
        HEALTH = {
            object = self._healthBarObject,
            size = options.SIZE_HEALTH,
            ALPHA = options.ALPHA,
            percentage = options.PERCENTAGE_HEALTH,
            readable = options.READABLE,
            decimals = options.DECIMALS
        },
        POWER = {
            object = self._manaBarObject,
            size = options.SIZE_POWER,
            ALPHA = options.ALPHA,
            percentage = options.PERCENTAGE_POWER,
            readable = options.READABLE,
            decimals = options.DECIMALS
        },
        ALTERNATEPOWER = {
            object = self._alternatePowerObject,
            size = options.SIZE_POWER,
            ALPHA = options.ALPHA,
            percentage = options.PERCENTAGE_POWER,
            readable = options.READABLE,
            decimals = options.DECIMALS
        }
    }

    -- get the object
    local frameSettings = whatSwitch[what]

    -- check default case
    if type(frameSettings) ~= "table" then
        QhunCore.ErrorMessage.new("QhunUnitHealth.AbstractUnitFrame:createFrame() Parameter 'what' is invalid!")
        return
    end

    -- create frame and set parent
    local frameObject = CreateFrame("FRAME", nil, frameSettings.object)
    frameObject:SetAllPoints(frameSettings.object)
    frameObject.resource = frameObject:CreateFontString("$parentTitle", "ARTWORK")
    frameObject.resource:SetAllPoints(frameObject)
    frameObject.resource:SetFont("Fonts\\FRIZQT__.TTF", frameSettings.size)

    -- apply ALPHA
    frameObject:SetAlpha(frameSettings.ALPHA)

    -- initial visible state
    if not self:isEnabled() then
        frameObject:Hide()
    end

    return frameObject
end

--[[
    ABSTRACT FUNCTIONS
]]
function QhunUnitHealth.AbstractUnitFrame:getOptions()
    QhunCore.ErrorMessage.new("QhunUnitHealth.AbstractUnitFrame:getOptions() should be implemented in the child class!")
    return {}
end

--[[
    PUBLIC FUNCTIONS
]]
function QhunUnitHealth.AbstractUnitFrame:checkForUpdate(eventName, ...)
    -- check if the eventName is allowed to trigger a child class update
    if qhunTableHasValue(self._updateEvents, eventName) and type(self.update) == "function" then
        self:update(...)
    end
end

-- a generic update function for health and power
function QhunUnitHealth.AbstractUnitFrame:genericUpdate(unitId)
    -- get current and max values
    local currentHealth = UnitHealth(unitId)
    local currentMaxHealth = UnitHealthMax(unitId)
    local currentPower = UnitPower(unitId)
    local currentMaxPower = UnitPowerMax(unitId)
    local currentAlternatePower = UnitPower(unitId, 0)
    local currentAlternatePowerMax = UnitPowerMax(unitId, 0)

    -- get current options
    local options = self:getOptions()

    -- set empty resource string if the unit has no resource left
    local resourceTextHealth = ""
    local resourceTextPower = ""
    local resourceTextAlternatePower = ""
    if currentHealth > 0 then
        resourceTextHealth =
            self._uiInstance:generateResourceText(
            currentHealth,
            currentMaxHealth,
            options.DECIMALS,
            options.PERCENTAGE_HEALTH,
            options.READABLE
        )
    end
    if currentPower > 0 then
        resourceTextPower =
            self._uiInstance:generateResourceText(
            currentPower,
            currentMaxPower,
            options.DECIMALS,
            options.PERCENTAGE_POWER,
            options.READABLE
        )
    end

    -- check for alternate power bar
    if self._alternatePowerFrame ~= nil and currentAlternatePower > 0 then
        resourceTextAlternatePower =
            self._uiInstance:generateResourceText(
            currentAlternatePower,
            currentAlternatePowerMax,
            options.DECIMALS,
            options.PERCENTAGE_POWER,
            options.READABLE
        )
    end

    -- update the frame resource text
    self._healthFrame.resource:SetText(resourceTextHealth)

    -- and the power resource text
    self._powerFrame.resource:SetText(resourceTextPower)

    if self._alternatePowerFrame ~= nil then
        self._alternatePowerFrame.resource:SetText(resourceTextAlternatePower)
    end
end
local i = 0
-- updates all settings relevant frame properties
function QhunUnitHealth.AbstractUnitFrame:updateFrameSettings()
    -- get current settings
    local settings = self:getOptions()

    -- check if the unit frame is enabled or disabled
    if self._healthFrame and self:isEnabled() then
        self._healthFrame:Show()
    elseif self._healthFrame then
        self._healthFrame:Hide()
    end
    if self._powerFrame and self:isEnabled() then
        self._powerFrame:Show()
    elseif self._powerFrame then
        self._powerFrame:Hide()
    end
    if self._alternatePowerFrame and self:isEnabled() then
        self._alternatePowerFrame:Show()
    elseif self._alternatePowerFrame then
        self._alternatePowerFrame:Hide()
    end

    -- set all options
    -- health
    self._healthFrame.resource:SetFont("Fonts\\FRIZQT__.TTF", settings.SIZE_HEALTH)
    self._healthFrame:SetAlpha(settings.ALPHA)

    -- power
    self._powerFrame.resource:SetFont("Fonts\\FRIZQT__.TTF", settings.SIZE_POWER)
    self._powerFrame:SetAlpha(settings.ALPHA)

    -- alternate power
    if type(self._alternatePowerFrame) ~= "nil" then
        self._alternatePowerFrame.resource:SetFont("Fonts\\FRIZQT__.TTF", settings.SIZE_POWER)
        self._alternatePowerFrame:SetAlpha(settings.ALPHA)
    end

    -- call a number format update
    self:genericUpdate(self._unitId)
end
