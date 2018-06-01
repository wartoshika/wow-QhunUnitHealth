-- check if the unit test addon is available
if IsAddOnLoaded("QhunUnitTest") then

    -- create a test suite
    local suite = QhunUnitTest.Suite.new("QhunUnitHealth")

    -- register all known unit tests
    suite:registerClass("Ui", QhunUnitHealth.Test.Ui.new())

    -- register for slash
    suite:registerForSlashCommand()
end
