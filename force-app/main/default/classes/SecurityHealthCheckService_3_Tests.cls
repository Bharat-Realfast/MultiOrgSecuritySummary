
@isTest
private class SecurityHealthCheckService_3_Tests {

    @TestSetup
    static void setup() {
        // Create a Security_Health_Check_Org__c record for testing
        Security_Health_Check_Org__c securityHealthCheckOrg = new Security_Health_Check_Org__c(
            Name = 'Test Org',
            // Assuming Actual_Org_Id__c is handled by the system or through automation and is not set directly here
            Latest_Score__c = 80.0
        );
        insert securityHealthCheckOrg;
    }

    private static List<Organization> getTestOrganizations() {
        return [SELECT Id FROM Organization LIMIT 1];
    }

    @isTest
    static void testUpdateHealthCheckOrgWithValidData() {
        // Arrange
        Decimal latestScore = 85.0;
        List<Organization> orgs = getTestOrganizations();
        
        // Act
        Test.startTest();
        SecurityHealthCheckService.updateSecurityHealthCheckOrg(orgs, latestScore);
        Test.stopTest();
        
        // Assert
        Security_Health_Check_Org__c updatedRecord = [SELECT Latest_Score__c, Last_Sync__c FROM Security_Health_Check_Org__c LIMIT 1];
        System.assertEquals(latestScore, updatedRecord.Latest_Score__c, 'The latest score should be updated');
        System.assertNotEquals(null, updatedRecord.Last_Sync__c, 'The last sync date should be updated');
    }
    
    @isTest
    static void testUpdateHealthCheckOrgWithEmptyOrgList() {
        // Arrange
        Decimal latestScore = 90.0;
        List<Organization> orgs = new List<Organization>(); // Empty organization list
        
        // Act
        Test.startTest();
        SecurityHealthCheckService.updateSecurityHealthCheckOrg(orgs, latestScore);
        Test.stopTest();
        
        // Assert
        Integer recordCount = [SELECT COUNT() FROM Security_Health_Check_Org__c];
        System.assertEquals(1, recordCount, 'No new records should be created');
    }
    
    @isTest
    static void testUpdateHealthCheckOrgWhenNoRelatedOrgExists() {
        // Arrange
        Decimal latestScore = 75.0;
        // Generate a unique ID that simulates a non-existent Organization ID
        String uniqueOrgId = UserInfo.getOrganizationId().left(15) + 'XYZ';
        Organization dummyOrg = new Organization(Id = uniqueOrgId);
        List<Organization> orgs = new List<Organization>{dummyOrg};

        // Assume that no Security_Health_Check_Org__c record exists for the dummyOrg
        delete [SELECT Id FROM Security_Health_Check_Org__c WHERE Actual_Org_Id__c = :uniqueOrgId];
        
        // Act
        Test.startTest();
        SecurityHealthCheckService.updateSecurityHealthCheckOrg(orgs, latestScore);
        Test.stopTest();
        
        // Assert
        List<Security_Health_Check_Org__c> shouldBeEmpty = [SELECT Id FROM Security_Health_Check_Org__c WHERE Actual_Org_Id__c = :uniqueOrgId];
        System.assertEquals(0, shouldBeEmpty.size(), 'No Security_Health_Check_Org__c records should be found for the dummy Org ID');
    }
}
