/**
 * Created by user on 11/26/20.
 */

public with sharing class FilterWrapper {

    @AuraEnabled
    public String fieldName { get; set; }

    @AuraEnabled
    public String filterOperator { get; set; }

    @AuraEnabled
    public String fieldValue { get; set; }

    @AuraEnabled
    public String whereOperator { get; set; }
    @AuraEnabled
    public String type {get;set;}


    public FilterWrapper(String fieldName, FilterOperators filterOperator, String fieldValue, WHERE_OPERATORS whereOperator, String type) {
        this.fieldName = fieldName;
        this.filterOperator = filterOperator.name();
        this.fieldValue = fieldValue;
        if(whereOperator != null) this.whereOperator = whereOperator.name();
        this.type = type;
    }
    public FilterWrapper(){}

    override
    public String toString() {
        return ' '
                + formQuery()
                + ' ' + translateWhereFilters(this.whereOperator);
    }
    public String formQuery() {

        String query = fieldName;

        switch on filterOperator {
            when 'EQUAL' {
                query += ' ' + '=' + formValue();
            }
            when 'NOT_EQUAL' {
                query += ' ' + formValue();
            }
            when 'START_WITH' {
                if(!isValueString(fieldValue)) return '';
                query += ' ' + 'LIKE \'' + fieldValue + '%\'';
            }
            when 'CONTAINS' {
                if(!isValueString(fieldValue)) return '';
                query += ' ' + 'LIKE \'%' + fieldValue + '%\'';
            }
            when 'END_WITH' {
                if(!isValueString(fieldValue)) return '';
                query += ' ' + 'LIKE \'%' + fieldValue + '\'';
            }
            when 'MORE_THAN' {
                query += ' ' + '>= ' +formValue();
            }
            when 'LESS_THAN' {
                query += ' ' + '<= ' + formValue();
            }
        }
        System.debug(query);
        return query;
    }

    private String formValue(){
        if(type == 'String' || type == 'Date'){
            return '\'' + fieldValue + '\'';
        }
        return fieldValue;
    }

    private Boolean isValueString(Object value){
        return value instanceof String;
    }

    private String translateWhereFilters(String operator) {
        if(operator == null) return '';
        String result = operator.removeEnd('_OPERATOR');
        return result;
    }

}