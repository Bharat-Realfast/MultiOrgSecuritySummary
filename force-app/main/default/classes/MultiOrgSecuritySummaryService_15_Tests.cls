
@isTest
private class MultiOrgSecuritySummaryService_15_Tests {

    @testSetup
    static void setupTestData() {
        // Assuming no TriggerHandler class is available in the current context.
        // If it exists, uncomment the next two lines and use the correct bypass method.
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Create test data for Security_Health_Check_Org__c
        Security_Health_Check_Org__c testOrg = new Security_Health_Check_Org__c(Name = 'Test Org');
        insert testOrg;

        // Create a test Security_Health_Check__c record for the happy path
        Security_Health_Check__c testSecurityHealthCheck = new Security_Health_Check__c(
            Security_Health_Check_Org__c = testOrg.Id,
            Score__c = 90,
            Check_Date__c = Date.today()
        );
        insert testSecurityHealthCheck;
    }

    @isTest
    static void testGetLatestSecurityHealthCheckWithExistingRecord() {
        Security_Health_Check_Org__c testOrg = [SELECT Id FROM Security_Health_Check_Org__c WHERE Name = 'Test Org' LIMIT 1];
        Test.startTest();
        Security_Health_Check__c result = MultiOrgSecuritySummaryService.getLatestSecurityHealthCheck(testOrg.Id);
        Test.stopTest();

        System.assertNotEquals(null, result, 'The result should not be null for an existing record');
        System.assertEquals(Date.today(), result.Check_Date__c, 'The check date should be today');
    }

    @isTest
    static void testGetLatestSecurityHealthCheckWithNoRecord() {
        // Create a dummy Org Id that does not have a related Security_Health_Check__c record
        Security_Health_Check_Org__c dummyOrg = new Security_Health_Check_Org__c(Name = 'Dummy Org');
        insert dummyOrg;

        Test.startTest();
        Security_Health_Check__c result = MultiOrgSecuritySummaryService.getLatestSecurityHealthCheck(dummyOrg.Id);
        Test.stopTest();

        System.assertEquals(null, result, 'The result should be null for a non-existent record');
    }

    @isTest
    static void testGetLatestSecurityHealthCheckWithInvalidId() {
        Test.startTest();
        Security_Health_Check__c result = MultiOrgSecuritySummaryService.getLatestSecurityHealthCheck(null);
        Test.stopTest();

        System.assertEquals(null, result, 'The result should be null for an invalid ID');
    }
}
