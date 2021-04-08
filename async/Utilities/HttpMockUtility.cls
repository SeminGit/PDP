public without sharing class HttpMockUtility implements HttpCalloutMock {

    public Integer code;
    public String status;
    public String body;
    public Map<String, String> responseHeaders;

    public static void setHeadersFromMap(StaticResourceCalloutMock mock, Map<String, String> headersToSet) {
        for (String header : headersToSet.keySet()) {
            mock.setHeader(header, headersToSet.get(header));
        }
    }

    public static void setHeadersFromMap(HttpResponse mock, Map<String, String> headersToSet) {
        for (String header : headersToSet.keySet()) {
            mock.setHeader(header, headersToSet.get(header));
        }
    }

    public HttpMockUtility() {

    }

    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();

        setHeadersFromMap(response, this.responseHeaders);

        response.setStatusCode(this.code);
        response.setStatus(this.status);
        response.setBody(body);

        return response;
    }

}