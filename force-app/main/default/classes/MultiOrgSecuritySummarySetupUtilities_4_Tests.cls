
@isTest
private class MOSSSU4Test {

    // This method will set up the test data for all test methods
    @testSetup
    static void setupTestData() {
        Security_Health_Check__c securityHealthCheck = new Security_Health_Check__c();
        // Initialize fields as required and insert the record
        insert securityHealthCheck;
    }

    // Test the happy path scenario
    @isTest
    static void testHappyPathDelete() {
        // Query to confirm setup data exists
        List<Security_Health_Check__c> preDeleteChecks = [SELECT Id FROM Security_Health_Check__c];
        System.assertEquals(1, preDeleteChecks.size(), 'There should be 1 Security Health Check record before deletion.');

        // Run the target method
        Test.startTest();
        MultiOrgSecuritySummarySetupUtilities.deleteFalsePositiveHealthCheck();
        Test.stopTest();

        // Check that the record has been deleted
        List<Security_Health_Check__c> postDeleteChecks = [SELECT Id FROM Security_Health_Check__c];
        System.assertEquals(0, postDeleteChecks.size(), 'No Security Health Check records should exist after deletion.');
    }

    // Test the sad path scenario
    @isTest
    static void testSadPathDelete() {
        // Clean up all records to simulate there being none to delete
        delete [SELECT Id FROM Security_Health_Check__c];

        // Run the target method
        Test.startTest();
        MultiOrgSecuritySummarySetupUtilities.deleteFalsePositiveHealthCheck();
        Test.stopTest();

        // Check that the absence of records does not cause any errors
        List<Security_Health_Check__c> remainingChecks = [SELECT Id FROM Security_Health_Check__c];
        System.assertEquals(0, remainingChecks.size(), 'Method should run without errors even if there are no records to delete.');
    }
}
