public class Constants{
	public static final Set<String> ARIFMETIC_OPERATORS_CONST = new Set<String>{'<', '>', '<=', '>=', '='};
	public static final List<String> ALL_PRODUCT2_FIELDS_CONST = new List<String>{'Id', 'Name', 'BataryCapacity__c', 'Category__c', 'ChargingTime__c', 'Color__c', 'MaxSpeed__c', 'MaxWeight__c', 'TravelDistance__c', '(SELECT UnitPrice FROM PricebookEntries)', '(SELECT Id FROM Attachments limit 1)'};
	public static final List<String> ALL_OUTLET_FIELDS_CONST = new List<String>{'Id', 'Name', 'Location__Latitude__s', 'Location__Longitude__s', 'OpenTime__c,PhoneNumber__c', 'CloseTime__c,Email__c,City__c', 'Street__c'};
	public static final List<String> ALL_Lead_FIELDS_CONST = new List<String>{'Id', 'Name', 'FirstName', 'LastName', 'Email', 'Phone'};
	public static final List<String> COUNT_PRODUCTS_FIELD = new List<String>{'count()'};
	public static final String CURRENT_PRICEBOOK_ID_CONST = '01s2v00000L5rveAAB';
	public static final String MAIN_WAREHOUSE_ID_CONST = 'a0F2v00001U8CA1EAN';
	public static final String THANKS_EMAIL_TEMPLATE_NAME = 'Thankss with Survey';
    public static final String NULL_OR_EMPTY_PARAM = 'NULL or EMPTY params!';
	public static final String NO_FIELD_ON_OBJECT_PATTERN = 'Did not find any field called "{0}" was found on object "{1}"';
	public static final String NO_OBJECT_FOUND = 'Did not find object with type "{0}"';
}