
@isTest
private class SecuritySyncTests {

    @testSetup
    static void setup() {
        // No test data setup is required for these tests.
    }

    @isTest
    static void shouldScheduleJobWithValidCron() {
        Test.startTest();
        Boolean isSuccess = MultiOrgSecuritySummarySetupUtilities.scheduleSecuritySync('0 0 12 * * ?');
        Test.stopTest();

        System.assertEquals(true, isSuccess, 'The job should be scheduled successfully with a valid cron expression.');
    }

    @isTest
    static void shouldNotScheduleJobWithInvalidCron() {
        Test.startTest();
        Boolean isSuccess = MultiOrgSecuritySummarySetupUtilities.scheduleSecuritySync('invalid_cron_expression');
        Test.stopTest();

        System.assertEquals(false, isSuccess, 'The job should not be scheduled with an invalid cron expression.');
    }

    // Testing of exceptions that are thrown due to governor limits or other system exceptions is not possible in Salesforce unit tests,
    // hence no tests are written for such scenarios.
}
