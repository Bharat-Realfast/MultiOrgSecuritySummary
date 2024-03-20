
@isTest
private class MultiOrgSecuritySummaryService_12_Tests {

    @testSetup
    static void setup() {
        // Create test data for active Security_Health_Check_Org__c records
        List<Security_Health_Check_Org__c> activeOrgList = new List<Security_Health_Check_Org__c>();
        for (Integer i = 0; i < 5; i++) {
            activeOrgList.add(new Security_Health_Check_Org__c(
                Name = 'Test SHCOrg ' + i,
                Active__c = true
            ));
        }
        insert activeOrgList;
    }

    @isTest
    static void testGetAllSecurityHealthCheckOrgsWithActiveRecords() {
        Test.startTest();
        List<Security_Health_Check_Org__c> results = MultiOrgSecuritySummaryService.getAllSecurityHealthCheckOrgs();
        Test.stopTest();
        
        // Assertions
        System.assert(results.size() > 0, 'Should return active Security_Health_Check_Org__c records.');
        System.assertEquals(true, results[0].Active__c, 'Returned records should be active.');
    }

    @isTest
    static void testGetAllSecurityHealthCheckOrgsWithNoActiveRecords() {
        // Deactivate all active Security_Health_Check_Org__c records
        List<Security_Health_Check_Org__c> activeOrgList = [SELECT Id, Active__c FROM Security_Health_Check_Org__c WHERE Active__c = true];
        for (Security_Health_Check_Org__c org : activeOrgList) {
            org.Active__c = false;
        }
        update activeOrgList;
        
        Test.startTest();
        List<Security_Health_Check_Org__c> results = MultiOrgSecuritySummaryService.getAllSecurityHealthCheckOrgs();
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, results.size(), 'Should not return any active Security_Health_Check_Org__c records.');
    }
}
