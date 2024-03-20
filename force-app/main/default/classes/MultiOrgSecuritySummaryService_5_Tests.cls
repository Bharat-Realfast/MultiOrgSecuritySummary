
@isTest
private class MultiOrgSecuritySummaryService_5_Tests {

    @testSetup
    static void setup() {
        // Create test data for the tests. Users and Skills records would be required.

        // Create a new User for testing purpose
        User testUser = new User(
            Username = 'testuser@example.com',
            Email = 'testuser@example.com',
            FirstName = 'Test',
            LastName = 'User',
            Alias = 'tuser',
            ProfileId = [SELECT Id FROM Profile WHERE Name='Standard User'].Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;

        // Create a new Security Skill record
        Security_Skill__c securitySkill = new Security_Skill__c(
            Name = 'Test Security Skill',
            Skill_Level__c = 'Beginner',
            Description__c = 'Test Skill Description',
            Type__c = 'Technical',
            Image_Path__c = '/img/test.jpg'
        );
        insert securitySkill;

        // Create a new Admin Security Skill record and associate it with the user and skill created above
        Admin_Security_Skill__c adminSecuritySkill = new Admin_Security_Skill__c(
            User__c = testUser.Id,
            Security_Skill__c = securitySkill.Id
        );
        insert adminSecuritySkill;
    }

    @isTest
    static void testGetAdminSkillsToManageWithSkills() {
        // Set up test data specific for this test
        // Run as a specific user to avoid MIXED_DML_OPERATION error
        User testUser = [SELECT Id FROM User WHERE Username = 'testuser@example.com' LIMIT 1];
        System.runAs(testUser) {
            // Execute the method
            List<Map<String, Object>> skillsToManage = MultiOrgSecuritySummaryService.getAdminSkillsToManage(testUser.Id, 'https://test.salesforce.com');
            
            // Assert that the list of skills is correct and contains one skill
            System.assertEquals(1, skillsToManage.size(), 'There should be one skill in the list');

            // Assert that the completed flag is correctly set
            Map<String, Object> skillData = skillsToManage[0];
            System.assertEquals(true, skillData.get('Completed'), 'The skill should be marked as completed');
        }
    }

    @isTest
    static void testGetAdminSkillsToManageNoSkills() {
        // Set up test data specific for this test
        // Create a new user who does not have any security skills
        User anotherUser = new User(
            Username = 'anotheruser@example.com',
            Email = 'anotheruser@example.com',
            FirstName = 'Another',
            LastName = 'User',
            Alias = 'auser',
            ProfileId = [SELECT Id FROM Profile WHERE Name='Standard User'].Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert anotherUser;

        // Execute the method
        List<Map<String, Object>> skillsToManage = MultiOrgSecuritySummaryService.getAdminSkillsToManage(anotherUser.Id, 'https://test.salesforce.com');

        // Assert that the list contains all skills, which should be one in this test setup
        System.assertEquals(1, skillsToManage.size(), 'There should be one skill in the list');

        // Assert that the completed flag is correctly set to false
        Map<String, Object> skillData = skillsToManage[0];
        System.assertEquals(false, skillData.get('Completed'), 'The skill should be marked as not completed');
    }

    @isTest
    static void testGetAdminSkillsToManageInvalidUser() {
        // Use an invalid user ID (assuming '005000000000000AAA' does not represent a valid user in the org)
        Id invalidUserId = '005000000000000AAA';
        Test.startTest();
        List<Map<String, Object>> skillsToManage = MultiOrgSecuritySummaryService.getAdminSkillsToManage(invalidUserId, 'https://test.salesforce.com');
        Test.stopTest();
        
        // Assert that no skills are returned for an invalid user
        System.assertEquals(0, skillsToManage.size(), 'No skills should be returned for an invalid user');
    }
}
