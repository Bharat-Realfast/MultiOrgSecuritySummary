
@isTest
private class SHCRiskJSONP_2_Tests {

  @isTest
  static void testValidJSONParsing() {
    String validJson = '{ "size": 1, "totalSize": 1, "done": true, "queryLocator": null, "entityTypeName": "SecurityHealthCheckRisks", "records": [{ "attributes": { "type": "SecurityHealthCheckRisks", "url": "/services/data/v47.0/tooling/sobjects/SecurityHealthCheckRisks/SessionSettings.enableSmsIdentity" }, "DurableId": "SessionSettings.enableSmsIdentity", "OrgValue": "Disabled", "OrgValueRaw": "false", "RiskType": "HIGH_RISK", "SecurityHealthCheckId": null, "Setting": "Let users verify their identity by text (SMS)", "SettingGroup": "SessionSettings", "SettingRiskCategory": "HIGH_RISK", "StandardValue": "Enabled", "StandardValueRaw": "true" }] }';
    System.JSONParser parser = System.JSON.createParser(validJson);
    SecurityHealthCheckRiskJSONParser parsedObject = new SecurityHealthCheckRiskJSONParser(parser);

    System.assertEquals(1, parsedObject.size, 'The size should be equal to 1.');
    System.assertEquals('SecurityHealthCheckRisks', parsedObject.entityTypeName, 'The entityTypeName should match.');
  }
  
  @isTest
  static void testInvalidJSONParsing() {
    String invalidJson = '{ "size": "one", "totalSize": "one", "done": "trueish", "queryLocator": "not-null", "entityTypeName": "SecurityHealthCheckRisks", "records": "not-a-list" }';
    System.JSONParser parser = System.JSON.createParser(invalidJson);

    try {
      SecurityHealthCheckRiskJSONParser parsedObject = new SecurityHealthCheckRiskJSONParser(parser);
      System.assert(false, 'An exception should have been thrown due to invalid JSON.');
    } catch (Exception e) {
      System.assert(true, 'An exception was correctly thrown due to invalid JSON.');
    }
  }

  @isTest
  static void testMalformedJSONParsing() {
    String malformedJson = '{ "size": 1, "totalSize": 1, "done": true, "queryLocator": null, "entityTypeName": "SecurityHealthCheckRisks" "records": [';
    System.JSONParser parser = System.JSON.createParser(malformedJson);

    try {
      SecurityHealthCheckRiskJSONParser parsedObject = new SecurityHealthCheckRiskJSONParser(parser);
      System.assert(false, 'An exception should have been thrown due to malformed JSON.');
    } catch (Exception e) {
      System.assert(true, 'An exception was correctly thrown due to malformed JSON.');
    }
  }
}
