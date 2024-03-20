
@isTest
public class SecurityHealthCheckJSONParser_4_Tests {

    private static String createNestedJSONString() {
        // We will add an additional field after the nested structure
        // to confirm that the parser has moved past the nested object.
        return '{' +
            '"nested": {' + // This is the object we want to consume
                '"array": [1, 2, 3],' +
                '"nestedObject": {"key": "value"}' +
            '},' +
            '"afterNested": "shouldBeHere"' + // Marker to show parser has moved past the nested object
        '}';
    }
    
    @isTest
    static void testConsumeObjectHappyPath() {
        String jsonString = createNestedJSONString();
        System.JSONParser parser = System.JSON.createParser(jsonString);

        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME && parser.getText() == 'nested') {
                // Found the nested object, so consume it
                parser.nextToken(); // Move to the start of the nested object
                Test.startTest();
                SecurityHealthCheckJSONParser.consumeObject(parser); // This should consume the entire nested object
                Test.stopTest();
                break; // Exit the loop once we've found and consumed the nested object
            }
        }

        // After consumeObject, the parser should be at the end of the nested object.
        // The next call to nextToken should move us to the next field name.
        System.JSONToken nextToken = parser.nextToken();

        // Assert
        System.assertEquals(System.JSONToken.FIELD_NAME, nextToken,
            'The next token after consuming the nested object should be the FIELD_NAME of the next field.');
        System.assertEquals('afterNested', parser.getText(),
            'The parser should be at the "afterNested" field after consuming the nested object.');
    }

    @isTest
    static void testConsumeObjectWithNullParser() {
        // Act
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            SecurityHealthCheckJSONParser.consumeObject(null);
        } catch (NullPointerException e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        // Assert
        System.assert(exceptionThrown, 
            'Passing a null parser should throw a NullPointerException.');
    }
}
