
@isTest
private class SecurityHealthCheckService_1_Tests {

  @isTest
  static void testGenerateHealthCheckData_Success() {
    Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
    
    Test.startTest();
    SecurityHealthCheckService.generateHealthCheckData();
    Test.stopTest();
    
    // Assertions to ensure that the Security Health Check records are created
    List<Security_Health_Check__c> checks = [SELECT Id FROM Security_Health_Check__c];
    System.assertEquals(1, checks.size(), 'A Security Health Check record should have been created');
  }
  
  @isTest
  static void testGenerateHealthCheckData_CalloutFail() {
    Test.setMock(HttpCalloutMock.class, new MockHttpCalloutFailure());
    Boolean exceptionThrown = false;
    
    Test.startTest();
    try {
      SecurityHealthCheckService.generateHealthCheckData();
    } catch (SecurityHealthCheckService.SecurityHealthCheckServiceException e) {
      exceptionThrown = true;
      System.assertEquals('Bad Request', e.getMessage(), 'The exception message should match the simulated callout response');
    }
    Test.stopTest();
    
    System.assert(exceptionThrown, 'An exception should have been thrown due to callout failure');
  }
  
  // Mock class for successful callouts
  private class MockHttpResponseGenerator implements HttpCalloutMock {
    public HttpResponse respond(HTTPRequest req) {
      HttpResponse res = new HttpResponse();
      res.setStatusCode(200);
      res.setBody('{}'); // Provide a valid JSON body as per the expected response
      return res;
    }
  }
  
  // Mock class for failed callouts
  private class MockHttpCalloutFailure implements HttpCalloutMock {
    public HttpResponse respond(HTTPRequest req) {
      HttpResponse res = new HttpResponse();
      res.setStatusCode(400);
      res.setBody('Bad Request');
      return res;
    }
  }
}
