@IsTest
public without sharing class RestWebService_Test {

    @TestSetup
    static void setup() {
        Account newAcc = new Account();
        newAcc.Name = 'test';
        newAcc.Website = 'google.com';
        newAcc.NumberOfEmployees = 2;

        insert newAcc;
}

@IsTest
static void getMethod_Test() {
    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();

    RestContext.request.httpMethod = HttpUtils.getRequestMethod(HTTP_REQUEST_METHOD.T_GET);
    RestContext.request.addParameter(RestWebService.WEBSITENAME_PARAM, 'google');
    RestContext.request.addParameter(RestWebService.AMOUNT_PARAM, '3');
    RestContext.request.addHeader(
            HttpCalloutConstants.CONTENT_TYPE_PARAM_NAME,
            HttpCalloutConstants.HEADERS.get(HttpCalloutConstants.CONTENT_TYPE_PARAM_NAME)
    );
    RestContext.request.requestURI = '/services/apexrest/accountWebService';

    Test.startTest();
        Map<String, Decimal> result = RestWebService.get();
    Test.stopTest();

    Account accToCompare = [SELECT Name, NumberOfEmployees FROM Account LIMIT 1];

    System.assert(result.keySet().contains(accToCompare.Name));
    System.assertEquals(accToCompare.NumberOfEmployees, result.get(accToCompare.Name));

}

}