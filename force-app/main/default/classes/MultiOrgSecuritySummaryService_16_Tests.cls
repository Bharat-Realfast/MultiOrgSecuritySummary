
@isTest
private class MultiOrgSecuritySummaryService_16_Tests {

    @testSetup
    static void setup() {
        // Create test data for Security_Health_Check_Org__c
        Security_Health_Check_Org__c org = new Security_Health_Check_Org__c(
            Name = 'Test Org',
            Active__c = true
        );
        insert org;

        // Create related Security_Health_Check__c records
        Security_Health_Check__c healthCheck1 = new Security_Health_Check__c(
            Security_Health_Check_Org__c = org.Id,
            Check_Date__c = Date.today().addDays(-10)
        );
        Security_Health_Check__c healthCheck2 = new Security_Health_Check__c(
            Security_Health_Check_Org__c = org.Id,
            Check_Date__c = Date.today()
        );
        insert new List<Security_Health_Check__c>{ healthCheck1, healthCheck2 };
    }

    @isTest
    static void testGetFirstSecurityHealthCheck_HappyPath() {
        // Test the happy path scenario
        Test.startTest();
        Security_Health_Check_Org__c org = [SELECT Id FROM Security_Health_Check_Org__c LIMIT 1];
        Security_Health_Check__c expectedHealthCheck = [SELECT Id FROM Security_Health_Check__c WHERE Security_Health_Check_Org__c = :org.Id ORDER BY CreatedDate ASC LIMIT 1];
        Security_Health_Check__c result = MultiOrgSecuritySummaryService.getFirstSecurityHealthCheck(org.Id);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'The result should not be null');
        System.assertEquals(expectedHealthCheck.Id, result.Id, 'The earliest health check record should be returned');
    }

    @isTest
    static void testGetFirstSecurityHealthCheck_SadPath() {
        // Test the sad path scenario: No related health checks
        Security_Health_Check_Org__c org = new Security_Health_Check_Org__c(
            Name = 'Test Org Without Health Checks',
            Active__c = true
        );
        insert org; // Insert the org with no related health checks

        Test.startTest();
        Security_Health_Check__c result = MultiOrgSecuritySummaryService.getFirstSecurityHealthCheck(org.Id);
        Test.stopTest();

        // Assertions
        System.assertEquals(null, result, 'The result should be null as there are no health checks');
    }

    @isTest
    static void testGetFirstSecurityHealthCheck_Exceptional() {
        // Test the exceptional scenario: Invalid org ID
        Test.startTest();
        Security_Health_Check__c result = MultiOrgSecuritySummaryService.getFirstSecurityHealthCheck(null);
        Test.stopTest();

        // Assertions
        System.assertEquals(null, result, 'The result should be null as the org ID is invalid');
    }
}
