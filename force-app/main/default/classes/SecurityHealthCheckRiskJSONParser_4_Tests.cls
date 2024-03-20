
@isTest
private class SHCRiskJSONParserTests {

    @isTest
    static void testConsumeObjectHappyPath() {
        String jsonString = '{"object": {"ignoredKey": "ignoredValue"}}';
        System.JSONParser parser = System.JSON.createParser(jsonString);
        parser.nextToken(); // Start Object
        parser.nextToken(); // Field Name "object"
        parser.nextToken(); // Start Object that we want to consume
        SecurityHealthCheckRiskJSONParser.consumeObject(parser);
        
        System.assertNotEquals(System.JSONToken.START_OBJECT, parser.getCurrentToken(), 'The current token should not be START_OBJECT after consumeObject.');
        System.assertEquals(System.JSONToken.END_OBJECT, parser.getCurrentToken(), 'The current token should be END_OBJECT after consumeObject.');
    }
    
    @isTest
    static void testConsumeObjectSadPath() {
        String jsonString = '{"key": "value"}';
        System.JSONParser parser = System.JSON.createParser(jsonString);
        parser.nextToken(); // Start Object
        parser.nextToken(); // Field Name "key"
        SecurityHealthCheckRiskJSONParser.consumeObject(parser);
        
        System.assertEquals(System.JSONToken.VALUE_STRING, parser.getCurrentToken(), 'The current token should still be VALUE_STRING after consumeObject.');
        System.assertEquals('value', parser.getText(), 'The text value should still be "value" after consumeObject.');
    }
    
    @isTest
    static void testConsumeObjectExceptionalScenario() {
        String jsonString = '{}';
        System.JSONParser parser = System.JSON.createParser(jsonString);
        while (parser.nextToken() != null) {
            // Intentionally empty to move parser to the end
        }
        Test.startTest();
        SecurityHealthCheckRiskJSONParser.consumeObject(parser);
        Test.stopTest();
        
        System.assertEquals(null, parser.getCurrentToken(), 'The current token should be null at the end of the document.');
    }
}
