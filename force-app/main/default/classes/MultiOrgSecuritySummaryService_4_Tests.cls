
@isTest
private class MultiOrgSecuritySummaryService_4_Tests {

    // Utility method to create test data
    @testSetup
    static void setup() {
        // Create a user for testing purposes
        User testUser = new User(
            LastName = 'TestUser',
            Email = 'testuser@example.com',
            Username = 'testuser' + DateTime.now().getTime() + '@example.com',
            Alias = 'testu',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;

        // We assume that at least the User__c field is writable and we will create
        // a generic Admin_Security_Skill__c record linked to the testUser without setting other fields.
        Admin_Security_Skill__c securitySkill = new Admin_Security_Skill__c(User__c = testUser.Id);
        insert securitySkill;
    }

    // Test method for happy path scenario
    @isTest
    static void testGetSecurityAdminDetailsHappyPath() {
        // Arrange
        User testUser = [SELECT Id FROM User WHERE Email = 'testuser@example.com'];
        // Act
        Test.startTest();
        Map<String, Object> adminDetails = MultiOrgSecuritySummaryService.getSecurityAdminDetails(testUser.Id);
        Test.stopTest();
        // Assert
        System.assertNotEquals(null, adminDetails, 'Admin details should not be null');
        System.assertEquals(testUser.Id, ((User)adminDetails.get('UserInfo')).Id, 'Should return the correct user info');
    }

    // Test method for sad path scenario
    @isTest
    static void testGetSecurityAdminDetailsUserDoesNotExist() {
        // Arrange
        Id fakeUserId = '00500000000XXXXAAA';
        // Act
        Test.startTest();
        Map<String, Object> adminDetails = MultiOrgSecuritySummaryService.getSecurityAdminDetails(fakeUserId);
        Test.stopTest();
        // Assert
        System.assertEquals(null, adminDetails.get('UserInfo'), 'Admin details should be null for a non-existent user');
    }

    // Test method for exceptional scenario
    @isTest
    static void testGetSecurityAdminDetailsInvalidId() {
        // Arrange
        Id invalidUserId = 'aabbccddeeff112233';
        Exception actualException = null;
        // Act
        Test.startTest();
        try {
            MultiOrgSecuritySummaryService.getSecurityAdminDetails(invalidUserId);
        } catch (Exception e) {
            actualException = e;
        }
        Test.stopTest();
        // Assert
        System.assertNotEquals(null, actualException, 'An exception should have been thrown for an invalid Id');
    }
}
