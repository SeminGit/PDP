public with sharing class HttpUtils {
    public enum HTTP_REQUEST_METHOD {
        GET,
        POST,
        PUT,
        PATCH
    }

    public static HttpRequest createGetRequest(String endpoint, Integer timeout) {
        if (String.isBlank(endpoint) || timeout == null || timeout <= 0) {
            Utilities.throwCustomException(Constants.NULL_OR_EMPTY_PARAM);
        }

        HttpRequest requestToCreate = new HttpRequest();

        requestToCreate.setEndpoint(endpoint);
        requestToCreate.setMethod(HttpUtils.HTTP_REQUEST_METHOD.GET.name());
        requestToCreate.setTimeout(timeout);

        return  requestToCreate;
    }

    public static HttpResponse sendRequest(HttpRequest request) {
        return new Http().send(request);
    }
}