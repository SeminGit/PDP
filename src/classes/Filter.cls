public with sharing class Filter {

    @AuraEnabled
    public String type {get; private set;}
    @AuraEnabled
    public String field {get; private set;}
    @AuraEnabled
    public String value {get; private set;}
    @AuraEnabled
    public String operator {get; private set;}

    public Filter(String type, String field, String operator, String value) {
      //  if (String.isBlank(type) || String.isBlank(field)) throw new QueryException('Field type or field name is Empty.');
        if (String.isBlank(operator)) operator = QueryConstants.NONE;

        this.type = type;
        this.field = field;
        this.operator = operator;
        this.value = value;
    }

    public Filter(String type, String field) {
        if (String.isBlank(type) || String.isBlank(field)) throw new QueryException('Field type or field name is Empty.');

        this.type = type;
        this.field = field;
        this.operator = QueryConstants.NONE;
        this.field = '';
    }

    public List<String> availableOperators {
        get {
            return QueryConstants.AVAILABLE_OPERATORS.get(type);
        }
    }

}