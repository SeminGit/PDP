// TODO - [SELECT Fields FROM Object WHERE ... (AND, OR) (OFFSET, LIMIT, ORDER BY )

public with sharing class QueryCreator {

    public static String addSelect(String query) {
        return query += 'SELECT';
    }

    public static String addFromObject(String query, String objectName) {
        return query += ' FROM ' + objectName;
    }

    public static String addFieldsToSelect(String query, List<String> fieldNames) {
        for (String fieldName : fieldNames) {
            query += ' ' + fieldName + ',';
        }
        return query.removeEnd(',') + ' ';
    }

    public static String addWhereClause(String query) {
        return query += ' WHERE';
    }

    public static String addFilters(String query, List<FilterWrapper> filters) {
        for (FilterWrapper filter : filters) {
            query += filter.toString();
        }
        return query;
    }
    public static String addLimit(String query, Integer limits) {
        return query += ' ' + 'LIMIT ' + limits;
    }
    public static String addOffset(String query, Double offset) {
        return query += ' ' + 'OFFSET ' + offset;
    }

    /*public static String createQuery(String objectName, List<String> fieldNames) {
        String query = '';
        query = addSelect(query);
        query = addFieldsToSelect(query, fieldNames);
        query = addFromObject(query, objectName);
        return query;
    }*/

    public static String createQuery(QueryObject queryObject) {
        if (queryObject.objectName == null
                || queryObject.objectName == ''
                || queryObject.fieldNames == null
                || queryObject.fieldNames.size() == 0) {
            return null;
        }
        String query = '';
        query = addSelect(query);
        query = addFieldsToSelect(query, queryObject.fieldNames);
        query = addFromObject(query, queryObject.objectName);
        if (queryObject.filters != null && queryObject.filters.size() > 0) {
            query = addWhereClause(query);
            query = addFilters(query, queryObject.filters);
        }
        if(queryObject.limits != null){
            query = addLimit(query, queryObject.limits);
        }
        if(queryObject.offset != null){
            query = addOffset(query, queryObject.offset);
        }
        System.debug(query);
        return query;
    }

}