
@isTest
private class MultiOrgSecuritySummarySetupUtilities_7_Tests {

    @isTest
    static void testSuccessfulJobDeletion() {
        // Setup - Schedule a job to be deleted
        String cronExpression = '0 0 0 * * ?'; // Every day at midnight
        Test.startTest();
        String jobId = System.schedule('Test Job Deletion', cronExpression, new SecurityHealthCheckApexScheduler());
        Test.stopTest();

        // Actual Test
        Test.startTest();
        Boolean isJobDeleted = MultiOrgSecuritySummarySetupUtilities.deleteScheduledJob();
        Test.stopTest();

        // Assertions - Check if the operation was successful.
        System.assertEquals(true, isJobDeleted, 'The scheduled job should have been deleted successfully.');
    }
    
    @isTest
    static void testNoJobToDelete() {
        // Actual Test
        Test.startTest();
        Boolean isJobDeleted = MultiOrgSecuritySummarySetupUtilities.deleteScheduledJob();
        Test.stopTest();

        // Assertions - The method should return false as there is no job to delete.
        System.assertEquals(false, isJobDeleted, 'The method should return false as there was no job to delete.');
    }
}
