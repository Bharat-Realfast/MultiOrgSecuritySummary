
@isTest
private class MultiOrgSecuritySummaryService_9_Tests {

    @testSetup
    static void setup() {
        // Create a Security_Health_Check__c record
        Security_Health_Check__c shc = new Security_Health_Check__c(/* populate required fields */);
        insert shc;
        
        // Create related Security_Health_Check_Risk__c records
        Security_Health_Check_Risk__c risk1 = new Security_Health_Check_Risk__c(
            Security_Health_Check__c = shc.Id,
            SettingRiskCategory__c = 'Category1',
            DurableId__c = 'Durable1'
        );
        Security_Health_Check_Risk__c risk2 = new Security_Health_Check_Risk__c(
            Security_Health_Check__c = shc.Id,
            SettingRiskCategory__c = 'Category1',
            DurableId__c = 'Durable2'
        );
        insert new List<Security_Health_Check_Risk__c>{risk1, risk2};
    }
    
    @isTest
    static void testGetSummaryCategoriesWithRecords() {
        Test.startTest();
        Map<String, List<String>> summaryCategories = MultiOrgSecuritySummaryService.getSummaryCategories();
        Test.stopTest();
        
        // Assertions
        System.assertEquals(1, summaryCategories.size(), 'Should have 1 category');
        System.assertTrue(summaryCategories.containsKey('Category1'), 'Category1 should be present');
        System.assertEquals(2, summaryCategories.get('Category1').size(), 'Category1 should have 2 durable IDs');
    }
    
    @isTest
    static void testGetSummaryCategoriesWithNoRecords() {
        // Delete all Security_Health_Check__c records to simulate a scenario with no records
        delete [SELECT Id FROM Security_Health_Check__c];

        Test.startTest();
        Map<String, List<String>> summaryCategories = MultiOrgSecuritySummaryService.getSummaryCategories();
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, summaryCategories, 'The summaryCategories map should not be null.');
        System.assertEquals(0, summaryCategories.size(), 'The summaryCategories map should be empty.');
    }
}
