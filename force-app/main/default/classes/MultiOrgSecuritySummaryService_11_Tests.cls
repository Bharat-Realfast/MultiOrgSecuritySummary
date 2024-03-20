
@isTest
public class MultiOrgSecuritySummaryService_11_Tests {

    @testSetup
    static void setupTestData() {
        // Setup test data
        // Since we are testing Organization retrieval, we do not need to insert a test Organization as it is a singleton object in Salesforce.
    }
    
    // Happy Path
    @isTest
    static void testGetOrganization_ReturnsOrganization() {
        // Perform test
        Test.startTest();
        Organization org = MultiOrgSecuritySummaryService.getOrganization();
        Test.stopTest();
        
        // Assert
        System.assertNotEquals(null, org, 'The organization should be retrieved successfully.');
        System.assertEquals(UserInfo.getOrganizationId(), org.Id, 'The retrieved organization Id should match the current org Id.');
    }
    
    // Sad Path not necessary as it's not possible to have no Organization record in Salesforce.
    
    // Exceptional Scenario
    // Using RunAs to simulate different user permissions might be necessary if testing for security enforcement.
    // However, in this context, we can't create users with different permissions in test methods, so we will not test the security enforcement in this case.
    // Security enforcement is generally tested in higher environments with pre-existing users with different permission sets.

    // Note: We do not have to bypass any triggers for fetching Organization records.
}
