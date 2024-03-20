
@isTest
public class SecurityHealthCheckJSONParser_1_Tests {
    
    @isTest
    static void testAttributesParsing_HappyPath() {
        String validJson = '{"type":"SecurityHealthCheck","url":"/services/data/v47.0/tooling/sobjects/SecurityHealthCheck/0"}';
        System.JSONParser parser = System.JSON.createParser(validJson);

        SecurityHealthCheckJSONParser.Attributes attributes = new SecurityHealthCheckJSONParser.Attributes(parser);

        System.assertEquals('SecurityHealthCheck', attributes.type_Z);
        System.assertEquals('/services/data/v47.0/tooling/sobjects/SecurityHealthCheck/0', attributes.url);
    }
    
    @isTest
    static void testAttributesParsing_NullValues() {
        String nullValueJson = '{"type":null,"url":null}';
        System.JSONParser parser = System.JSON.createParser(nullValueJson);

        SecurityHealthCheckJSONParser.Attributes attributes = new SecurityHealthCheckJSONParser.Attributes(parser);
        
        System.assert(attributes.type_Z == null, 'Type should be null when the JSON value is null.');
        System.assert(attributes.url == null, 'URL should be null when the JSON value is null.');
    }

    @isTest
    static void testAttributesParsing_MissingFields() {
        String missingFieldsJson = '{}';
        System.JSONParser parser = System.JSON.createParser(missingFieldsJson);

        SecurityHealthCheckJSONParser.Attributes attributes = new SecurityHealthCheckJSONParser.Attributes(parser);
        
        System.assert(attributes.type_Z == null, 'Type should be null when the field is missing in JSON.');
        System.assert(attributes.url == null, 'URL should be null when the field is missing in JSON.');
    }
    
    @isTest
    static void testAttributesParsing_Exception() {
        String invalidJson = 'INVALID_JSON';
        Boolean didThrowException = false;
        
        try {
            System.JSONParser parser = System.JSON.createParser(invalidJson);
            SecurityHealthCheckJSONParser.Attributes attributes = new SecurityHealthCheckJSONParser.Attributes(parser);
        } catch (System.JSONException e) {
            didThrowException = true;
        }
        
        System.assert(didThrowException, 'Parsing invalid JSON should result in a JSONException.');
    }
}
