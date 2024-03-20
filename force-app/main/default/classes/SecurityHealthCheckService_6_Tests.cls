
@isTest
private class SecurityHealthCheckService_6_Tests {
    
    @isTest
    static void testGetSecurityHealthCheckConfig_HappyPath() {
        // Assuming there is at least one Security_Health_Check_Config__mdt record
        // in the org since custom metadata records are visible in tests

        Test.startTest();
        // Call the method to test
        Security_Health_Check_Config__mdt config = SecurityHealthCheckService.getSecurityHealthCheckConfig();
        Test.stopTest();
        
        // Assert that a record is retrieved
        System.assertNotEquals(null, config, 'A config record should be retrieved');
    }

    // No Sad path test is necessary since we can't alter custom metadata records in test context
    // All configurations would be visible unless we specifically test for orgs without configuration,
    // which is not possible in a unit test
}
