
@isTest
private class MultiOrgSecuritySummarySetupUtilities_2_Tests {

    @isTest
    static void testGetCurrentDateTimeNotNull() {
        // Test that the method returns a non-null DateTime value
        Datetime result = MultiOrgSecuritySummarySetupUtilities.getCurrentDateTime();
        
        System.assertNotEquals(null, result, 'The current DateTime should not be null.');
    }
    
    @isTest
    static void testGetCurrentDateTimeAccuracy() {
        // Test that the method returns the current DateTime within an acceptable margin
        Datetime timeBefore = Datetime.now();
        
        // Pause the execution for a short time to ensure there is a measurable difference
        Test.startTest();
        Datetime actualTime = MultiOrgSecuritySummarySetupUtilities.getCurrentDateTime();
        Test.stopTest();
        
        Datetime timeAfter = Datetime.now();
        
        // Assert the actual time is on or after the time recorded before the call
        System.assert(actualTime >= timeBefore, 'The actual time should be on or after the time recorded before the call.');

        // Assert the actual time is on or before the time recorded after the call
        System.assert(actualTime <= timeAfter, 'The actual time should be on or before the time recorded after the call.');
    }
}
