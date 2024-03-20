
@isTest
private class MultiOrgSecuritySummaryService_7_Tests {
    
    // Utility method to create test data for security health check orgs without setting read-only fields
    private static List<Security_Health_Check_Org__c> createSecurityHealthCheckOrgTestData() {
        // Create a list of Security_Health_Check_Org__c records for testing
        List<Security_Health_Check_Org__c> orgList = new List<Security_Health_Check_Org__c>();
        for (Integer i = 0; i < 3; i++) {
            Security_Health_Check_Org__c org = new Security_Health_Check_Org__c(
                Name = 'TestOrg' + i,
                Active__c = true,
                Category__c = 'Test'
            );
            orgList.add(org);
        }
        insert orgList;
        return orgList;
    }
    
    @testSetup
    static void setup() {
        // Create test data using the utility method
        List<Security_Health_Check_Org__c> orgList = createSecurityHealthCheckOrgTestData();
        
        // Create test data for security health checks
        Security_Health_Check_Org__c org = orgList[0];
        List<Security_Health_Check__c> healthCheckList = new List<Security_Health_Check__c>();
        Date yesterday = Date.today().addDays(-1);
        Security_Health_Check__c healthCheck = new Security_Health_Check__c(
            Check_Date__c = yesterday,
            Security_Health_Check_Org__c = org.Id,
            Score__c = 85
        );
        healthCheckList.add(healthCheck);
        insert healthCheckList;
    }
    
    @isTest
    static void testGetSecurityCheckByDateWithChecks() {
        Date yesterday = Date.today().addDays(-1);
        // Call the method being tested
        Test.startTest();
        List<MultiOrgSecuritySummaryService.DailyOrgSummary> results =
            MultiOrgSecuritySummaryService.getSecurityCheckByDate(yesterday);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(3, results.size(), 'There should be three DailyOrgSummary records');
    }
    
    @isTest
    static void testGetSecurityCheckByDateWithoutChecks() {
        Date futureDate = Date.today().addDays(5);
        // Call the method being tested
        Test.startTest();
        List<MultiOrgSecuritySummaryService.DailyOrgSummary> results =
            MultiOrgSecuritySummaryService.getSecurityCheckByDate(futureDate);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(3, results.size(), 'There should be three DailyOrgSummary records with no data');
    }
    
    @isTest
    static void testGetSecurityCheckByDateWithNullDate() {
        // Call the method being tested with a null date
        Test.startTest();
        List<MultiOrgSecuritySummaryService.DailyOrgSummary> results =
            MultiOrgSecuritySummaryService.getSecurityCheckByDate(null);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, results.size(), 'Results should be empty when the date is null');
    }
}
