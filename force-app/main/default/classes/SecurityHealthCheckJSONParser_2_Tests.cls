
@isTest
private class SecurityHealthCheckJSONParser_2_Tests {

    // Test for valid JSON input.
    @isTest
    static void testValidJSONRecords() {
        String jsonInput = '{'+
          '"attributes" : {'+
            '"type" : "SecurityHealthCheck",'+
            '"url" : "/services/data/v47.0/tooling/sobjects/SecurityHealthCheck/0"'+
          '},'+
          '"CustomBaselineId" : "0",'+
          '"DurableId" : "0",'+
          '"Score" : "61"'+
        '}';
        
        System.JSONParser parser = System.JSON.createParser(jsonInput);
        SecurityHealthCheckJSONParser.Records records = new SecurityHealthCheckJSONParser.Records(parser);
        
        // Assertions
        System.assertEquals('SecurityHealthCheck', records.attributes.type_Z);
        System.assertEquals('61', records.Score);
    }

    // Test for JSON with additional fields that are not defined in the class.
    @isTest
    static void testJSONWithAdditionalFields() {
        String jsonInput = '{'+
          '"attributes" : {'+
            '"type" : "SecurityHealthCheck",'+
            '"url" : "/services/data/v47.0/tooling/sobjects/SecurityHealthCheck/0"'+
          '},'+
          '"CustomBaselineId" : "0",'+
          '"DurableId" : "0",'+
          '"Score" : "61",'+
          '"extraField" : "shouldBeIgnored"'+
        '}';
        
        System.JSONParser parser = System.JSON.createParser(jsonInput);
        SecurityHealthCheckJSONParser.Records records = new SecurityHealthCheckJSONParser.Records(parser);
        
        // Assertions
        System.assertEquals('0', records.CustomBaselineId);
        System.assertEquals('SecurityHealthCheck', records.attributes.type_Z);
    }
    
    // Test for JSON input where some fields have null values.
    @isTest
    static void testJSONWithNullValues() {
        String jsonInput = '{'+
          '"attributes" : null,'+
          '"CustomBaselineId" : null,'+
          '"DurableId" : "0",'+
          '"Score" : "61"'+
        '}';
        
        System.JSONParser parser = System.JSON.createParser(jsonInput);
        SecurityHealthCheckJSONParser.Records records = new SecurityHealthCheckJSONParser.Records(parser);
        
        // Assertions
        System.assertEquals(null, records.attributes);
        System.assertEquals('0', records.DurableId);
    }
    
    // Test for invalid JSON input that should throw a JSONException.
    @isTest
    static void testInvalidJSON() {
        String jsonInput = '{ invalid json';
        Boolean exceptionThrown = false;
        
        try {
            System.JSONParser parser = System.JSON.createParser(jsonInput);
            new SecurityHealthCheckJSONParser.Records(parser);
        } catch (System.JSONException e) {
            exceptionThrown = true;
        }
        
        // Assertion to confirm that a System.JSONException was thrown.
        System.assert(exceptionThrown);
    }

    // Test for passing a null JSONParser object to the Records constructor.
    @isTest
    static void testNullJSONParser() {
        System.JSONParser parser = null;
        Boolean exceptionThrown = false;
        
        try {
            new SecurityHealthCheckJSONParser.Records(parser);
        } catch (NullPointerException e) {
            exceptionThrown = true;
        }
        
        // Assertion to confirm that a NullPointerException was thrown.
        System.assert(exceptionThrown);
    }
}
