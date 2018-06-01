-- a local function to generate target specific options
local function generateSubOption(t, categoryString)
    return {
        name = t:translate("SETTINGS_" .. categoryString .. "_NAME"),
        elements = {
            QhunCore.TextUiElement.new(
                t:translate("SETTINGS_" .. categoryString .. "_ENTRY"),
                {
                    padding = 20
                }
            ),
            QhunCore.CheckboxUiElement.new(
                t:translate("SETTINGS_" .. categoryString .. "_PERCENTAGE_HEALTH"),
                categoryString .. ".PERCENTAGE_HEALTH"
            ),
            QhunCore.CheckboxUiElement.new(
                t:translate("SETTINGS_" .. categoryString .. "_PERCENTAGE_POWER"),
                categoryString .. ".PERCENTAGE_POWER"
            ),
            QhunCore.CheckboxUiElement.new(
                t:translate("SETTINGS_" .. categoryString .. "_READABLE"),
                categoryString .. ".READABLE",
                {
                    padding = 20
                }
            ),
            QhunCore.TableUiElement.new(
                {
                    {
                        width = 20
                    },
                    {
                        width = 80
                    }
                },
                {
                    QhunCore.TextUiElement.new(t:translate("SETTINGS_" .. categoryString .. "_SIZE_HEALTH")),
                    QhunCore.SliderUiElement.new(
                        "",
                        categoryString .. ".SIZE_HEALTH",
                        {
                            min = 2,
                            max = 26,
                            decimals = 1
                        }
                    ),
                    QhunCore.TextUiElement.new(t:translate("SETTINGS_" .. categoryString .. "_SIZE_POWER")),
                    QhunCore.SliderUiElement.new(
                        "",
                        categoryString .. ".SIZE_POWER",
                        {
                            min = 2,
                            max = 26,
                            decimals = 1
                        }
                    ),
                    QhunCore.TextUiElement.new(t:translate("SETTINGS_" .. categoryString .. "_ALPHA")),
                    QhunCore.SliderUiElement.new(
                        "",
                        categoryString .. ".ALPHA",
                        {
                            min = 0,
                            max = 1,
                            steps = 0.01,
                            decimals = 2
                        }
                    ),
                    QhunCore.TextUiElement.new(t:translate("SETTINGS_" .. categoryString .. "_DECIMALS")),
                    QhunCore.SliderUiElement.new(
                        "",
                        categoryString .. ".DECIMALS",
                        {
                            min = 0,
                            max = 5,
                            decimals = 0
                        }
                    )
                }
            )
        }
    }
end

-- generates all interface options for QhunUnitHealth
function QhunUnitHealth.InterfaceOptions.generateOptions()
    -- alias the translation
    local t = QhunUnitHealth.Translation

    return {
        _order = {
            "MAIN_OPTIONS",
            "PLAYER_OPTIONS",
            "TARGET_OPTIONS",
            "TARGET_OF_TARGET_OPTIONS",
            "FOCUS_OPTIONS",
            "PARTY_OPTIONS"
        },
        MAIN_OPTIONS = {
            name = "QhunUnitHealth",
            elements = {
                QhunCore.TextUiElement.new(
                    t:translate("SETTINGS_MAIN_ENTRY"),
                    {
                        padding = 10
                    }
                ),
                QhunCore.TextUiElement.new(
                    t:translate("SETTINGS_MAIN_ENABLE_DISABLE_FEATURES"),
                    {
                        fontSize = 13,
                        color = {r = 1, g = 215 / 255, b = 0},
                        padding = 10
                    }
                ),
                QhunCore.CheckboxUiElement.new(t:translate("SETTINGS_MAIN_ENABLE_PLAYER"), "PLAYER_ENABLED"),
                QhunCore.CheckboxUiElement.new(t:translate("SETTINGS_MAIN_ENABLE_TARGET"), "TARGET_ENABLED"),
                QhunCore.CheckboxUiElement.new(
                    t:translate("SETTINGS_MAIN_ENABLE_TARGET_OF_TARGET"),
                    "TARGET_OF_TARGET_ENABLED"
                ),
                QhunCore.CheckboxUiElement.new(t:translate("SETTINGS_MAIN_ENABLE_FOCUS"), "FOCUS_ENABLED"),
                QhunCore.CheckboxUiElement.new(
                    t:translate("SETTINGS_MAIN_ENABLE_PARTY"),
                    "PARTY_ENABLED",
                    {
                        padding = 10
                    }
                ),
                QhunCore.TextUiElement.new(
                    t:translate("SETTINGS_MAIN_OTHER_SETTINGS"),
                    {
                        fontSize = 13,
                        color = {r = 1, g = 215 / 255, b = 0},
                        padding = 15
                    }
                ),
                QhunCore.TextUiElement.new(
                    t:translate("SETTINGS_MAIN_DIVIDER_TEXT"),
                    {
                        fontSize = 11
                    }
                ),
                QhunCore.TextboxUiElement.new(t:translate("SETTINGS_MAIN_DIVIDER"), "DIVIDER")
            }
        },
        PLAYER_OPTIONS = generateSubOption(t, "PLAYER", "PLAYER"),
        TARGET_OPTIONS = generateSubOption(t, "TARGET", "TARGET"),
        TARGET_OF_TARGET_OPTIONS = generateSubOption(t, "TARGET_OF_TARGET", "TARGET_OF_TARGET"),
        FOCUS_OPTIONS = generateSubOption(t, "FOCUS", "FOCUS"),
        PARTY_OPTIONS = generateSubOption(t, "PARTY", "PARTY")
    }
end
