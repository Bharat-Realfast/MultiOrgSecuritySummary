
@isTest
private class SecHealthCheckRisksJSONParserTest {

    @testSetup
    static void setup() {
        // Test setup not required for JSON parsing tests
    }
    
    @isTest
    static void testParseValidJSON() {
        // Happy Path: Well-formed JSON string
        String validJson = '{ "size" : 1, "totalSize" : 1, "done" : true, "queryLocator" : null, "entityTypeName" : "SecurityHealthCheckRisks", "records" : [{ "attributes" : { "type" : "SecurityHealthCheckRisks", "url" : "someUrl" }, "DurableId" : "someId", "OrgValue" : "Disabled", "OrgValueRaw" : "false", "RiskType" : "HIGH_RISK", "SecurityHealthCheckId" : null, "Setting" : "someSetting", "SettingGroup" : "SessionSettings", "SettingRiskCategory" : "HIGH_RISK", "StandardValue" : "Enabled", "StandardValueRaw" : "true" }]}';
        SecurityHealthCheckRiskJSONParser result = SecurityHealthCheckRiskJSONParser.parse(validJson);

        System.assertNotEquals(null, result, 'The parser should not return null for valid JSON.');
        System.assertEquals(1, result.size, 'The size should be 1 for the provided JSON.');
    }
    
    @isTest
    static void testParseMalformedJSON() {
        // Sad Path: Malformed JSON string
        String invalidJson = '{ "size" : "this is not a number", "totalSize" : 1, "done" : true, "queryLocator" : null, "entityTypeName" : "SecurityHealthCheckRisks", "records" : [] }';

        Test.startTest();
        Exception ex = null;
        try {
            SecurityHealthCheckRiskJSONParser result = SecurityHealthCheckRiskJSONParser.parse(invalidJson);
        } catch (Exception e) {
            ex = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, ex, 'An exception should be thrown for malformed JSON.');
    }
    
    @isTest
    static void testParseEmptyJSON() {
        // Exceptional Scenario: Empty JSON string
        String emptyJson = '';
        Test.startTest();
        Exception ex = null;
        try {
            SecurityHealthCheckRiskJSONParser result = SecurityHealthCheckRiskJSONParser.parse(emptyJson);
        } catch (Exception e) {
            ex = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, ex, 'An exception should be thrown for an empty JSON string.');
    }
    
    @isTest
    static void testParseNullJSON() {
        // Exceptional Scenario: Null JSON string
        String nullJson = null;
        Test.startTest();
        Exception ex = null;
        try {
            SecurityHealthCheckRiskJSONParser result = SecurityHealthCheckRiskJSONParser.parse(nullJson);
        } catch (Exception e) {
            ex = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, ex, 'An exception should be thrown for a null JSON string.');
    }
}
