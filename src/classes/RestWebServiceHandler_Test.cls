@IsTest
public without sharing class RestWebServiceHandler_Test {

    private static String BANK_RESPONSE_JSON = '[{"Cur_ID":170,"Date":"2021-04-08T00:00:00","Cur_Abbreviation":"AUD","Cur_Scale":1,"Cur_Name":"Австралийский доллар","Cur_OfficialRate":2.0335}]';

    @IsTest
    static void bankSendRequest_Test_Positive() {
        HttpMockUtility mock = new HttpMockUtility();

        mock.status = 'Success';
        mock.code = 200;
        mock.responseHeaders = new Map<String, String>{
                'Content-type' => 'Application/json'
        };
        mock.body = BANK_RESPONSE_JSON;

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
            Map<String, Decimal> rates = NbRBService.getRates();
        Test.stopTest();

        String key = new List<String>(rates.keySet())[0];

        System.assertEquals(key, 'AUD');
        System.assertEquals(rates.get(key), 2.0335);
    }

    @IsTest
    static void bankSendRequest_Test_PositiveViaStatick() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();

        mock.setStatus(HttpCalloutConstants.RESPONSE_STATUS_SUCCESS);
        mock.setStatusCode(HttpCalloutConstants.RESPONSE_STATUS_CODE_SUCCESS);
        mock.setStaticResource('Bank_Response_Body');
        HttpMockUtility.setHeadersFromMap(mock, HttpCalloutConstants.HEADERS);

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
            Map<String, Decimal> rates = NbRBService.getRates();
        Test.stopTest();

        String key = new List<String>(rates.keySet())[0];

        System.assertEquals(key, 'AUD');
        System.assertEquals(rates.get(key), 2.0335);
    }

}