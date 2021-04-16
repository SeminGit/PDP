@RestResource(UrlMapping = '/accountWebService/*')
global without sharing class RestWebService {

    public static String WEBSITENAME_PARAM = 'websiteName';
    public static String AMOUNT_PARAM = 'amount';

    @HttpGet
    global static Map<String, Decimal> get() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Map<String, String> params = request.params;

        String websiteName = RestUtils.getUrlParamByName(params, WEBSITENAME_PARAM);
        String amount = RestUtils.getUrlParamByName(params, AMOUNT_PARAM);

        try {
            return RestWebServiceHandler.handleGetRequest(websiteName, amount);
        } catch (Exception e) {
            RestUtils.filBadResponse(response, e);
        }

        return null;
    }

    @HttpPut
    global static String put() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        RestUtils.AccountWrapper body =
                (RestUtils.AccountWrapper) RestUtils.deserializeRequestBody(request.requestBody, RestUtils.AccountWrapper.class);

        try {
            return RestWebServiceHandler.createAccountFromRequestBody(body);
        } catch (Exception e) {
            RestUtils.filBadResponse(response, e);
        }

        return null;
    }
}