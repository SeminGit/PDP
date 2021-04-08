public with sharing class HttpUtils {
    public static String getRequestMethod(HTTP_REQUEST_METHOD method) {
        if (method == null) {
            Utilities.throwCustomException(Constants.NULL_OR_EMPTY_PARAM);
        }

        return method.name().substring(0, method.name().length() - 1);
    }

    public static HttpRequest createGetRequest(String endpoint, Integer timeout) {
        if (String.isBlank(endpoint) || timeout == null || timeout <= 0) {
            Utilities.throwCustomException(Constants.NULL_OR_EMPTY_PARAM);
        }

        HttpRequest requestToCreate = new HttpRequest();

        requestToCreate.setEndpoint(endpoint);
        requestToCreate.setMethod(getRequestMethod(HTTP_REQUEST_METHOD.T_GET));
        requestToCreate.setTimeout(timeout);

        return  requestToCreate;
    }

    public static HttpResponse sendRequest(HttpRequest request) {
        return new Http().send(request);
    }
}