QhunUnitHealth = {
    Test = {},
    TranslationValues = {},
    InterfaceOptions = {},
    DefaultOptions = {
        PLAYER_ENABLED = true,
        TARGET_ENABLED = true,
        TARGET_OF_TARGET_ENABLED = false,
        FOCUS_ENABLED = true,
        PARTY_ENABLED = true,
        DIVIDER = " | ",
        PLAYER = {
            SIZE_HEALTH = 7,
            SIZE_POWER = 7,
            ALPHA = .7,
            --hOffset = 500,
            PERCENTAGE_HEALTH = true,
            PERCENTAGE_POWER = false,
            READABLE = true,
            DECIMALS = 1
        },
        TARGET = {
            SIZE_HEALTH = 7,
            SIZE_POWER = 7,
            ALPHA = 1,
            --hOffset = 0,
            PERCENTAGE_HEALTH = true,
            PERCENTAGE_POWER = true,
            READABLE = true,
            DECIMALS = 1
        },
        TARGET_OF_TARGET = {
            SIZE_HEALTH = 7,
            SIZE_POWER = 7,
            ALPHA = 1,
            --hOffset = 0,
            PERCENTAGE_HEALTH = true,
            PERCENTAGE_POWER = true,
            READABLE = true,
            DECIMALS = 1
        },
        FOCUS = {
            SIZE_HEALTH = 7,
            SIZE_POWER = 7,
            ALPHA = 1,
            --hOffset = 0,
            PERCENTAGE_HEALTH = true,
            PERCENTAGE_POWER = true,
            READABLE = true,
            DECIMALS = 1
        },
        PARTY = {
            SIZE_HEALTH = 6,
            SIZE_POWER = 6,
            ALPHA = .5,
            --hOffset = 0,
            PERCENTAGE_HEALTH = true,
            PERCENTAGE_POWER = true,
            READABLE = true,
            DECIMALS = 1
        }
    }
}
