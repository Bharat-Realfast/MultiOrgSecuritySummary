
@isTest
public class SecurityHealthCheckJSONParser_3_Tests {
    
    // Sample valid JSON for happy path testing
    private static String validJSON = '{"size":1,"totalSize":1,"done":true,"queryLocator":null,"entityTypeName":"SecurityHealthCheck","records":[{"attributes":{"type":"SecurityHealthCheck","url":"/services/data/v47.0/tooling/sobjects/SecurityHealthCheck/0"},"CustomBaselineId":"0","DurableId":"0","Score":"61"}]}';

    @isTest
    static void testValidJSON() {
        Test.startTest();
        SecurityHealthCheckJSONParser result = SecurityHealthCheckJSONParser.parse(validJSON);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'The parsed result should not be null.');
        System.assertEquals(1, result.size, 'The size should be 1.');
    }

    @isTest
    static void testInvalidJSON() {
        String invalidJSON = '{"size":1,"totalSize";1,"done":true,"queryLocator":null,"entityTypeName":"SecurityHealthCheck","records":[{"attributes":{"type":"SecurityHealthCheck","url":"/services/data/v47.0/tooling/sobjects/SecurityHealthCheck/0"},"CustomBaselineId":"0","DurableId":"0","Score":"61"}]}';
        Exception parsingException;
        
        try {
            SecurityHealthCheckJSONParser.parse(invalidJSON);
        } catch (Exception e) {
            parsingException = e;
        }
        
        System.assertNotEquals(null, parsingException, 'An exception should be thrown for invalid JSON.');
    }

    @isTest
    static void testMissingFieldsJSON() {
        String missingFieldsJSON = '{}';
        Test.startTest();
        SecurityHealthCheckJSONParser result = SecurityHealthCheckJSONParser.parse(missingFieldsJSON);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'The parsed result should not be null even if fields are missing.');
        System.assertEquals(null, result.size, 'The size should be null if missing in JSON.');
    }

    @isTest
    static void testNullJSON() {
        Exception parsingException;
        
        try {
            SecurityHealthCheckJSONParser.parse(null);
        } catch (Exception e) {
            parsingException = e;
        }
        
        System.assertNotEquals(null, parsingException, 'An exception should be thrown for null JSON.');
    }
}
