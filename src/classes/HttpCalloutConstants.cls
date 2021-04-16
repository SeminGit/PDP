public with sharing class HttpCalloutConstants {

    public static String RESPONSE_STATUS_SUCCESS = 'Success';
    public static Integer RESPONSE_STATUS_CODE_SUCCESS = 200;
    public static Integer RESPONSE_STATUS_CODE_ERROR = 400;
    public static String CONTENT_TYPE_PARAM_NAME = 'Content-Type';
    public static Map<String, String> HEADERS = new Map<String, String>{
            'Content-Type' => 'application/json',
            'Content-Encoding' => 'gzip'
    };
}