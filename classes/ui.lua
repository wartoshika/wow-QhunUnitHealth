QhunUnitHealth.Ui = {}
QhunUnitHealth.Ui.__index = QhunUnitHealth.Ui

-- constructor
function QhunUnitHealth.Ui.new()
    -- private properties
    local instance = {
        _eventFrame = CreateFrame("FRAME"),
        _uiFrameStack = {},
        _eventNames = {
            "UNIT_HEALTH",
            "UNIT_POWER",
            "UNIT_DISPLAYPOWER",
            "PLAYER_TARGET_CHANGED",
            "UNIT_MAXHEALTH",
            "UNIT_MAXPOWER",
            "PARTY_MEMBERS_CHANGED",
            "PLAYER_ENTERING_WORLD",
            "PLAYER_FOCUS_CHANGED",
            "UNIT_ENTERED_VEHICLE",
            "UNIT_EXITED_VEHICLE"
        }
    }

    setmetatable(instance, QhunUnitHealth.Ui)
    return instance
end

--[[
    PUBLIC FUNCTIONS
]]
-- create all known unit frames
function QhunUnitHealth.Ui:createFrames()
    -- debug print
    qhunDebug("QhunUnitHealth.Ui:createFrames()")

    self._uiFrameStack = {
        player = QhunUnitHealth.PlayerUnitFrame.new(self),
        target = QhunUnitHealth.TargetUnitFrame.new(self),
        focus = QhunUnitHealth.FocusUnitFrame.new(self),
        targettarget = QhunUnitHealth.TargetOfTargetUnitFrame.new(self),
        party1 = QhunUnitHealth.PartyUnitFrame.new(self, 1),
        party2 = QhunUnitHealth.PartyUnitFrame.new(self, 2),
        party3 = QhunUnitHealth.PartyUnitFrame.new(self, 3),
        party4 = QhunUnitHealth.PartyUnitFrame.new(self, 4)
    }
end

-- register all events that are nessesary to update ui informations
function QhunUnitHealth.Ui:registerEvents()
    -- debug print
    qhunDebug("QhunUnitHealth.Ui:registerEvents()")

    -- iterate over all events
    for _, eventName in pairs(self._eventNames) do
        self._eventFrame:RegisterEvent(eventName)
    end

    -- add a generic on event handler
    self._eventFrame:SetScript(
        "OnEvent",
        function(...)
            self:onEvent(...)
        end
    )

    -- add a listener for storage changes (addon interface option changes)
    -- and apply all options immediately
    QhunCore.EventEmitter.getCoreInstance():on(
        "STORAGE_UNCOMMITTED_CHANGED",
        function()
            -- apply the changes to all frames
            for _, frame in pairs(self._uiFrameStack) do
                frame:updateFrameSettings()
            end
        end
    )
end

-- the generic event handler function
function QhunUnitHealth.Ui:onEvent(_, eventName, arg1, ...)
    -- check if the event target exists in the frame stack
    if type(arg1) == "string" and type(self._uiFrameStack[arg1]) == "nil" then
        return
    end

    -- update the frame if a spefific target was found
    if type(self._uiFrameStack[arg1]) ~= "nil" then
        self._uiFrameStack[arg1]:checkForUpdate(eventName, arg1, ...)
    else
        -- check all
        for _, frame in pairs(self._uiFrameStack) do
            frame:checkForUpdate(eventName, arg1, ...)
        end
    end
end

-- generates a resource text string
--[[
    {
        resourceValue: number,
        resourceMaxValue: number,
        decimals: number,
        percentage: boolean,
        readable: boolean
    }
]]
function QhunUnitHealth.Ui:generateResourceText(resourceValue, resourceMaxValue, decimals, percentage, readable)
    local resourceString = ""
    local ending = ""
    local divider = QhunUnitHealth.Storage:get("DIVIDER")

    -- check if the resourceValue should be human readable
    if readable then
        -- apply readable formatting
        local readableResource = ""

        -- million
        if resourceValue > 999999 then
            -- thousand
            ending = QhunUnitHealth.Translation:translate("UNIT_FRAME_MILLION_ENDING")
            readableResource = qhunRound(resourceValue / 1000000, decimals)
        elseif resourceValue > 999 then
            ending = QhunUnitHealth.Translation:translate("UNIT_FRAME_THOUSAND_ENDING")
            readableResource = qhunRound(resourceValue / 1000, decimals)
        else
            -- no formatting
            readableResource = resourceValue
        end

        resourceString = readableResource .. ending
    else
        -- just take the value
        resourceString = resourceValue
    end

    -- check if the percentage should be added
    if percentage then
        resourceString = resourceString .. divider .. qhunRound(resourceValue * 100 / resourceMaxValue) .. "%"
    end

    return resourceString
end
