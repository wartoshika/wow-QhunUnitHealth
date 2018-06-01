if not IsAddOnLoaded("QhunUnitTest") then
    return
end

QhunUnitHealth.Test.Ui = {}
QhunUnitHealth.Test.Ui.__index = QhunUnitHealth.Test.Ui

-- constructor
function QhunUnitHealth.Test.Ui.new()
    -- call super class
    local instance = QhunUnitTest.Base.new()

    -- bind current values
    setmetatable(instance, QhunUnitHealth.Test.Ui)

    return instance
end

-- set inheritance
setmetatable(QhunUnitHealth.Test.Ui, {__index = QhunUnitTest.Base})

--[[
    TESTS
]]

function QhunUnitHealth.Test.Ui:hasValidDefaultOptions()

    -- global default options should be available
    self:assertTrue(QhunUnitHealth.DefaultOptions.PLAYER_ENABLED)
    self:assertTrue(QhunUnitHealth.DefaultOptions.TARGET_ENABLED)
    self:assertFalse(QhunUnitHealth.DefaultOptions.TARGET_OF_TARGET_ENABLED)
    self:assertTrue(QhunUnitHealth.DefaultOptions.FOCUS_ENABLED)
    self:assertTrue(QhunUnitHealth.DefaultOptions.PARTY_ENABLED)

    self:assertEqual(QhunUnitHealth.DefaultOptions.DIVIDER, " | ")

    -- per feature default settings
    self:assertTableSimilar(QhunUnitHealth.DefaultOptions.PLAYER, {
        SIZE_HEALTH = 7,
        SIZE_POWER = 7,
        ALPHA = .7,
        PERCENTAGE_HEALTH = true,
        PERCENTAGE_POWER = false,
        READABLE = true,
        DECIMALS = 1
    })
    self:assertTableSimilar(QhunUnitHealth.DefaultOptions.TARGET, {
        SIZE_HEALTH = 7,
        SIZE_POWER = 7,
        ALPHA = 1,
        PERCENTAGE_HEALTH = true,
        PERCENTAGE_POWER = true,
        READABLE = true,
        DECIMALS = 1
    })
    self:assertTableSimilar(QhunUnitHealth.DefaultOptions.TARGET_OF_TARGET, {
        SIZE_HEALTH = 7,
        SIZE_POWER = 7,
        ALPHA = 1,
        PERCENTAGE_HEALTH = true,
        PERCENTAGE_POWER = true,
        READABLE = true,
        DECIMALS = 1
    })
    self:assertTableSimilar(QhunUnitHealth.DefaultOptions.FOCUS, {
        SIZE_HEALTH = 7,
        SIZE_POWER = 7,
        ALPHA = 1,
        PERCENTAGE_HEALTH = true,
        PERCENTAGE_POWER = true,
        READABLE = true,
        DECIMALS = 1
    })
    self:assertTableSimilar(QhunUnitHealth.DefaultOptions.PARTY, {
        SIZE_HEALTH = 6,
        SIZE_POWER = 6,
        ALPHA = .5,
        PERCENTAGE_HEALTH = true,
        PERCENTAGE_POWER = true,
        READABLE = true,
        DECIMALS = 1
    })
end