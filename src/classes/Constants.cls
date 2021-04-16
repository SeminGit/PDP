public with sharing class Constants {

    public static final String Q_SELECT = 'SELECT';
    public static final String Q_FROM = 'FROM';
    public static final String Q_WHERE = 'WHERE';
    public static final String Q_AND = 'AND';
    public static final String ERROR_MESSAGE = 'Woops!Something went wrong!Please try again!';

    public static String PRODUCT_API_NAME = 'Product2';
    public static String OPPORTUNITY_API_NAME = 'Opportunity';
    public static String OPPORTUNITY_LINE_ITEM_API_NAME = 'OpportunityLineItem';
    public static String PRICEBOOK_ENTRY_API_NAME = 'PricebookEntry';
    public static String PRICEBOOK_API_NAME = 'Pricebook2';
    public static String STANDART_PRICEBOOK_ID = '01s5g000000YBlzAAG';
    public static String NULL_OR_BLANK_PARAM = 'One of the parameters is NULL or BLANK';
    public static List<String> FIELDS_FOR_OPPORTUNITY = new List<String>{
            'Id', 'Name', 'Contact__c'
    };
    public static List<String> FIELDS_FOR_OPPORTUNITY_LINE_ITEM = new List<String>{
            'Id', 'Name', 'OpportunityId', 'UnitPrice', 'TotalPrice', 'Quantity', 'Product2Id'
    };
    public static List<String> FIELDS_FOR_PRODUCT = new List<String>{
            'Id', 'Name', 'Description', 'ProductCode'
    };
    public static List<String> FIELDS_FOR_PRICEBOOK_ENTRY = new List<String>{
            'Id', 'Name', 'Product2Id', 'UnitPrice'
    };

}