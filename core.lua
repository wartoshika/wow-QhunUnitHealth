local addonName = "QhunUnitHealth"

QhunCore.Addon.new(addonName):registerAddonLoad(
    function(addon)
        -- register addon languages
        QhunUnitHealth.Translation = QhunCore.Translation.new()

        -- register all known languages
        QhunUnitHealth.Translation:registerLanguage("de", QhunUnitHealth.TranslationValues.de)
        QhunUnitHealth.Translation:registerLanguage("en", QhunUnitHealth.TranslationValues.en, true)

        -- load all variables from the storage
        QhunUnitHealth.Storage = QhunCore.Storage.new(addonName, "global", false)
        QhunUnitHealth.Storage:setDefaultValues(QhunUnitHealth.DefaultOptions)

        -- print load success message
        QhunUnitHealth.Translation:printTranslate(
            "ADDON_LOAD_SUCCESS",
            {
                version = GetAddOnMetadata(addonName, "Version"),
                name = GetAddOnMetadata(addonName, "Title")
            }
        )

        -- create ui
        QhunUnitHealth.Ui = QhunUnitHealth.Ui.new()
        QhunUnitHealth.Ui:createFrames()
        QhunUnitHealth.Ui:registerEvents()

        -- create interface options
        addon:registerInterfaceSettings(QhunUnitHealth.Storage, QhunUnitHealth.InterfaceOptions.generateOptions())
    end
):registerAddonUnload(
    function(addon)
        print("QhunUnitHealth unload")
    end
)
