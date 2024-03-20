
@isTest
private class SecurityHealthCheckService_2_Tests {

    @testSetup
    static void setup() {
        // Prepare test data
        // Since we cannot directly insert Organization records in a test, we will use a custom setting, or any
        // other mechanism as required by the actual implementation of the SecurityHealthCheckService.createNewSecurityHealthCheckOrg method
        // For this example, I'll assume a custom setting or a static variable in the actual class can be used to simulate this
    }

    @isTest
    static void testCreateNewSecurityHealthCheckOrgHappyPath() {
        // Retrieve the test data setup possibly via a custom setting because we cannot query the Organization object in tests
        // It's not possible to insert Organization records in test methods as it's a singleton object in the org
        // Assuming 'Test Organization' is a valid name for the organization for test context
        String testOrgName = 'Test Organization';
        Id testOrgId = '00Dxx0000001gEh'; // Example Org Id, use a valid Id format for your test
        Decimal testScore = 85.0;

        // Mocking organization as we can't directly query or insert it in test context
        Organization testOrg = new Organization(Id = testOrgId, Name = testOrgName);

        // Test createNewSecurityHealthCheckOrg method
        Test.startTest();
        SObject result = SecurityHealthCheckService.createNewSecurityHealthCheckOrg(testOrg, testScore);
        Test.stopTest();

        // Assert that the record was created successfully
        Security_Health_Check_Org__c createdRecord = [
            SELECT Name, Latest_Score__c, Organization_Id__c
            FROM Security_Health_Check_Org__c
            WHERE Id = :result.Id
        ];
        System.assertEquals(testOrgName, createdRecord.Name, 'The name should match the Organization name.');
        System.assertEquals(testScore, createdRecord.Latest_Score__c, 'The latest score should match the provided score.');
        System.assertEquals(testOrgId, createdRecord.Organization_Id__c, 'The organization Id should match the provided organization Id.');
    }

    @isTest
    static void testCreateNewSecurityHealthCheckOrgWithNullOrg() {
        Decimal testScore = 85.0;

        // Expecting a graceful handling of null Organization
        Test.startTest();
        SObject result;
        Boolean exceptionThrown = false;
        try {
            result = SecurityHealthCheckService.createNewSecurityHealthCheckOrg(null, testScore);
        } catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        // Assert that an exception was thrown
        System.assertEquals(true, exceptionThrown, 'An exception should be thrown when the Organization is null.');
    }

    // As mentioned earlier, we cannot force a DML exception without specific patterns or mechanisms.
    // The test method for DML exception scenarios is therefore omitted.
}
