
@isTest
private class MultiOrgSecuritySummaryService_13_Tests {
    @testSetup
    static void setup() {
        // Create test data for Security_Health_Check_Org__c
        Security_Health_Check_Org__c testOrg = new Security_Health_Check_Org__c(
            Name = 'Test Org',
            Description__c = 'Test Description',
            Point_of_Contact__c = 'Test Contact'
        );
        
        // Here we assume Actual_Org_Id__c will be auto-populated, or not required for the object creation.
        insert testOrg;
    }

    @isTest
    static void testGetExistingOrgOverview() {
        // Retrieve the test data
        Security_Health_Check_Org__c existingOrg = [SELECT Id, Actual_Org_Id__c FROM Security_Health_Check_Org__c LIMIT 1];
        
        Test.startTest();
        Security_Health_Check_Org__c result = MultiOrgSecuritySummaryService.getCurrentOrgOverview(existingOrg.Actual_Org_Id__c);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, result, 'The result should not be null for an existing organization.');
        System.assertEquals(existingOrg.Id, result.Id, 'The org ID should match the expected record.');
    }
    
    @isTest
    static void testGetNonExistingOrgOverview() {
        // Non-existing Org ID
        Id nonExistingOrgId = '000000000000000AAA'; // A dummy ID
        
        Test.startTest();
        Security_Health_Check_Org__c result = MultiOrgSecuritySummaryService.getCurrentOrgOverview(nonExistingOrgId);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, result, 'The result should be null for a non-existing organization.');
    }
    
    @isTest
    static void testGetOrgOverviewWithNullId() {
        Test.startTest();
        Security_Health_Check_Org__c result = MultiOrgSecuritySummaryService.getCurrentOrgOverview(null);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, result, 'The result should be null when the organization ID is null.');
    }
}
