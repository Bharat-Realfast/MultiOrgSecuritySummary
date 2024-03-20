
@isTest
private class MultiOrgSecuritySummaryService_14_Tests {

    // Utility method to create test data
    @testSetup
    static void setupTestData() {
        // Create a sample organization record that will be used as a reference in other records
        Security_Health_Check_Org__c org = new Security_Health_Check_Org__c(Name = 'TestOrg', Active__c = true);
        insert org;

        // Create a sample task related to the organization
        Security_Health_Check_Task__c task = new Security_Health_Check_Task__c(
            Title__c = 'Test Task',
            Status__c = 'Created',
            Related_To_Org__c = org.Id
        );
        insert task;
    }

    @isTest
    static void testGetSecurityHealthCheckTasksWithTasks() {
        // Prepare test data
        Security_Health_Check_Org__c org = [SELECT Id FROM Security_Health_Check_Org__c WHERE Name = 'TestOrg' LIMIT 1];

        // Add trigger bypass logic here if necessary

        Test.startTest();
        // Call the method with the org Id that has related tasks
        List<Security_Health_Check_Task__c> tasks = MultiOrgSecuritySummaryService.getSecurityHealthCheckTasks(org.Id);
        Test.stopTest();

        // Perform assertions
        System.assertEquals(1, tasks.size(), 'There should be one task related to the org.');
        System.assertEquals('Test Task', tasks[0].Title__c, 'The task title should match.');
    }

    @isTest
    static void testGetSecurityHealthCheckTasksWithoutTasks() {
        // Create an organization with no related tasks
        Security_Health_Check_Org__c org = new Security_Health_Check_Org__c(Name = 'TestOrgWithoutTasks', Active__c = true);
        insert org;

        // Add trigger bypass logic here if necessary

        Test.startTest();
        // Call the method with the org Id that has no related tasks
        List<Security_Health_Check_Task__c> tasks = MultiOrgSecuritySummaryService.getSecurityHealthCheckTasks(org.Id);
        Test.stopTest();

        // Perform assertions
        System.assertEquals(0, tasks.size(), 'There should be no tasks related to this org.');
    }

    @isTest
    static void testGetSecurityHealthCheckTasksWithInvalidOrgId() {
        // Add trigger bypass logic here if necessary

        Test.startTest();
        // Call the method with an invalid org Id
        List<Security_Health_Check_Task__c> tasks = MultiOrgSecuritySummaryService.getSecurityHealthCheckTasks(null);
        Test.stopTest();

        // Perform assertions
        System.assertEquals(0, tasks.size(), 'There should be no tasks related to a null org Id.');
    }
}
