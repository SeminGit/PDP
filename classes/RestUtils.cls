public inherited sharing class RestUtils {

    public static final String supportEmail = [SELECT Email__c FROM Emails__mdt WHERE DeveloperName = 'SUPPORT'].Email__c;

    public static void filBadResponse(RestResponse response, Exception e) {
        response.statusCode = 400;
        response.responseBody = Blob.valueOf(createErrorWrapperFromException(e));
    }

    public static String getUrlParamByName(Map<String, String> params, String paramName) {
        if (params == null || params.isEmpty() || String.isBlank(paramName)) {
            throw new RestUtilsException(Constants.NULL_OR_EMPTY_PARAM);
        }

        return params.get(paramName);
    }

    public static Object deserializeRequestBody(Blob requestBody, Type classType) {
        if (requestBody == null || classType == null) {
            throw new RestUtilsException(Constants.NULL_OR_EMPTY_PARAM);
        }

        return JSON.deserialize(requestBody.toString(), classType);
    }

    public static Object deserializeResponseBody(String responseBody, Type classType) {
        if (String.isBlank(responseBody) || classType == null) {
            throw new RestUtilsException(Constants.NULL_OR_EMPTY_PARAM);
        }

        return JSON.deserialize(responseBody, classType);
    }

    private static String createErrorWrapperFromException(Exception ex) {
        ErrorResponseWrapper response = new ErrorResponseWrapper();

        response.message = ex.getMessage();
        response.stackTrace = ex.getStackTraceString();
        response.supportEmail = supportEmail;

        return JSON.serializePretty(response);
    }

    private class ErrorResponseWrapper {
        public String message;
        public String stackTrace;
        public String supportEmail;
    }

    private class RestUtilsException extends Exception {}

    public class AccountWrapper {
        public String name;
        public String webSite;
        public String phone;

        public Boolean isRequiredFilled {
            get {
                return String.isNotBlank(name) && String.isNotBlank(webSite) && String.isNotBlank(phone);
            }
        }

        public Map<String, String> fieldsToValues {
            get {
                return new Map<String, String> {
                        'Name' => name,
                        'webSite' => webSite,
                        'phone' => phone
                };
            }
        }
    }
}