
@isTest
private class MultiOrgSecuritySummaryService_10_Tests {

    @testSetup 
    static void setupTestData() {
        // Populate all mandatory fields required for Security_Health_Check_Task__c
        Security_Health_Check_Task__c securityHealthCheckTask = new Security_Health_Check_Task__c(
            Title__c = 'Test Task Title'
            // Add any other required fields here
        );
        insert securityHealthCheckTask;
    }
    
    @isTest
    static void testGetTaskDetailsWithValidId() {
        // Retrieve the test data
        Security_Health_Check_Task__c expectedTask = [SELECT Id FROM Security_Health_Check_Task__c LIMIT 1];

        Test.startTest();
        Security_Health_Check_Task__c resultTask = MultiOrgSecuritySummaryService.getTaskDetails(expectedTask.Id);
        Test.stopTest();

        System.assertNotEquals(null, resultTask, 'The task should not be null');
        System.assertEquals(expectedTask.Id, resultTask.Id, 'The task Id should match the expected value');
    }

    @isTest
    static void testGetTaskDetailsWithInvalidId() {
        // Creating a dummy Id that would not be present in the test context
        Id dummyId = Id.valueOf('a04500000000000AAA');

        Test.startTest();
        Security_Health_Check_Task__c resultTask = MultiOrgSecuritySummaryService.getTaskDetails(dummyId);
        Test.stopTest();

        System.assertEquals(null, resultTask, 'The task should be null for an invalid Id');
    }

    @isTest
    static void testGetTaskDetailsWithNullId() {
        Test.startTest();
        Security_Health_Check_Task__c resultTask = MultiOrgSecuritySummaryService.getTaskDetails(null);
        Test.stopTest();

        System.assertEquals(null, resultTask, 'The task should be null when the Id is null');
    }
}
