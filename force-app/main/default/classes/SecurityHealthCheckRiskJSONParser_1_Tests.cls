
@isTest
private class SecHCRiskJSONParserTests {

    // Utility method to create a JSONParser instance from a JSON string
    private static JSONParser createParser(String jsonString) {
        return JSON.createParser(jsonString);
    }

    @isTest
    static void testHappyPathWithTypeAndUrl() {
        String jsonString = '{"type": "SecurityHealthCheckRisks", "url": "/example/url"}';
        JSONParser parser = createParser(jsonString);

        SecurityHealthCheckRiskJSONParser.Attributes attributes = new SecurityHealthCheckRiskJSONParser.Attributes(parser);

        System.assertEquals('SecurityHealthCheckRisks', attributes.type_Z, 'The type should be correctly parsed');
        System.assertEquals('/example/url', attributes.url, 'The URL should be correctly parsed');
    }

    @isTest
    static void testHappyPathWithTypeOnly() {
        String jsonString = '{"type": "SecurityHealthCheckRisks"}';
        JSONParser parser = createParser(jsonString);

        SecurityHealthCheckRiskJSONParser.Attributes attributes = new SecurityHealthCheckRiskJSONParser.Attributes(parser);

        System.assertEquals('SecurityHealthCheckRisks', attributes.type_Z, 'The type should be correctly parsed');
        System.assertEquals(null, attributes.url, 'The URL should be null');
    }

    @isTest
    static void testHappyPathWithUrlOnly() {
        String jsonString = '{"url": "/example/url"}';
        JSONParser parser = createParser(jsonString);

        SecurityHealthCheckRiskJSONParser.Attributes attributes = new SecurityHealthCheckRiskJSONParser.Attributes(parser);

        System.assertEquals(null, attributes.type_Z, 'The type should be null');
        System.assertEquals('/example/url', attributes.url, 'The URL should be correctly parsed');
    }

    @isTest
    static void testSadPathWithNeitherTypeNorUrl() {
        String jsonString = '{}';
        JSONParser parser = createParser(jsonString);

        SecurityHealthCheckRiskJSONParser.Attributes attributes = new SecurityHealthCheckRiskJSONParser.Attributes(parser);

        System.assertEquals(null, attributes.type_Z, 'The type should be null');
        System.assertEquals(null, attributes.url, 'The URL should be null');
    }

    @isTest
    static void testSadPathWithNullValues() {
        String jsonString = '{"type": null, "url": null}';
        JSONParser parser = createParser(jsonString);

        SecurityHealthCheckRiskJSONParser.Attributes attributes = new SecurityHealthCheckRiskJSONParser.Attributes(parser);

        System.assertEquals(null, attributes.type_Z, 'The type should be null');
        System.assertEquals(null, attributes.url, 'The URL should be null');
    }

    @isTest
    static void testExceptionalScenarioWithNullParser() {
        JSONParser parser = null;
        Boolean didThrowException = false;

        try {
            SecurityHealthCheckRiskJSONParser.Attributes attributes = new SecurityHealthCheckRiskJSONParser.Attributes(parser);
        } catch (NullPointerException e) {
            didThrowException = true;
        }

        System.assert(didThrowException, 'Passing a null JSONParser should throw a NullPointerException.');
    }
}
