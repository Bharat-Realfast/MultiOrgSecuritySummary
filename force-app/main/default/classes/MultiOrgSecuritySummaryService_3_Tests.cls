
@isTest
public class MultiOrgSecuritySummaryService_3_Tests {

    @testSetup
    static void setup() {
        // Assuming the creation of a custom setting or similar setup for the configuration
        // Since the setup for metadata is not typically done through Apex, this is omitted

        // Create and insert test data for Security_Health_Check_Org__c
        // Excluding the Actual_Org_Id__c field assuming it's a formula or auto-populated by some process
        Security_Health_Check_Org__c shco = new Security_Health_Check_Org__c(
            Name = 'Test Security Org',
            Active__c = true
        );
        insert shco;
    }

    @isTest
    static void testGetCurrentOrgConfigurationDetails_HappyPath() {
        Test.startTest();
        Map<String, Object> configurationDetails = MultiOrgSecuritySummaryService.getCurrentOrgConfigurationDetails();
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, configurationDetails, 'Configuration details should not be null on happy path.');
        System.assert(configurationDetails.containsKey('OrgInfo'), 'OrgInfo key should be present in the map.');
    }

    @isTest
    static void testGetCurrentOrgConfigurationDetails_SadPath() {
        Test.startTest();
        Map<String, Object> configurationDetails = MultiOrgSecuritySummaryService.getCurrentOrgConfigurationDetails();
        Test.stopTest();

        // Assertions
        System.assertEquals(null, configurationDetails, 'Configuration details should be null on sad path.');
    }

    // Additional test methods could be written here if there were other scenarios to test based on the business logic
}
