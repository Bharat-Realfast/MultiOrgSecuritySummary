
@isTest
public with sharing class MultiOrgSecuritySummaryService_2_Tests {
    @testSetup
    static void setup() {
        // Create a test Security Health Check Org
        Security_Health_Check_Org__c testOrg = new Security_Health_Check_Org__c(
            Name = 'Test Org'
            // Set other required fields as necessary
        );
        insert testOrg;

        // Create related Security Health Check Tasks with various statuses
        Security_Health_Check_Task__c task1 = new Security_Health_Check_Task__c(
            Status__c = 'Created',
            Related_To_Org__c = testOrg.Id
        );
        Security_Health_Check_Task__c task2 = new Security_Health_Check_Task__c(
            Status__c = 'In Progress',
            Related_To_Org__c = testOrg.Id
        );
        Security_Health_Check_Task__c task3 = new Security_Health_Check_Task__c(
            Status__c = 'Completed',
            Related_To_Org__c = testOrg.Id
        );
        insert new List<Security_Health_Check_Task__c>{task1, task2, task3};
    }

    // Happy Path: Valid Id
    @isTest
    static void testGetTotalOpenSecurityTasksWithValidId() {
        // Arrange
        Security_Health_Check_Org__c testOrg = [SELECT Id FROM Security_Health_Check_Org__c LIMIT 1];
        Integer expectedCount = 2; // As per our setup, only 2 tasks are 'Created' or 'In Progress'

        // Act
        Test.startTest();
        Integer actualCount = MultiOrgSecuritySummaryService.getTotalOpenSecurityTasks(testOrg.Id);
        Test.stopTest();

        // Assert
        System.assertEquals(expectedCount, actualCount, 'The count of open tasks should be correct.');
    }

    // Happy Path: Null Id
    @isTest
    static void testGetTotalOpenSecurityTasksWithNullId() {
        // Arrange
        Integer expectedCount = 2; // As per our setup, only 2 tasks are 'Created' or 'In Progress'

        // Act
        Test.startTest();
        Integer actualCount = MultiOrgSecuritySummaryService.getTotalOpenSecurityTasks(null);
        Test.stopTest();

        // Assert
        System.assertEquals(expectedCount, actualCount, 'The count of all open tasks should be correct.');
    }

    // Sad Path: Invalid Id
    @isTest
    static void testGetTotalOpenSecurityTasksWithInvalidId() {
        // Arrange
        Id invalidId = 'a01xxxxxxxxxxxxxxx'; // Assuming this is an invalid Id format
        Integer expectedCount = 0;

        // Act
        Test.startTest();
        Integer actualCount = MultiOrgSecuritySummaryService.getTotalOpenSecurityTasks(invalidId);
        Test.stopTest();

        // Assert
        System.assertEquals(expectedCount, actualCount, 'The count should be zero for an invalid Id.');
    }
}
