public with sharing class QueryObject {

    public String objectName { get; private set; }
    public List<String> fields { get; private set; }
    public List<Filter> filters { get; private set; }
    public String soqlRequest { get; private set; }
    public String soqlWithoutLimits { get; private set; }
    public Integer resultSize { get; private set; }

    private QueryObject() {
        fields = new List<String>();
        filters = new List<Filter>();
    }

    public QueryObject(String objectName) {
        this();

        if (String.isBlank(objectName)) {
            throw new QueryException('Empty query object name');
        }
        this.objectName = objectName;
    }

    public QueryObject(String objectName, List<String> fields) {
        this(objectName);
        setFields(fields);
    }

    public QueryObject(String objectName, List<String> fields, List<Filter> filters) {
        this(objectName, fields);
        setFilters(filters);
    }

    public Boolean setFields(List<String> fields) {
        if (fields == null || fields.isEmpty()) {
            throw new QueryException('List of fields is empty');
        }
        this.fields.clear();

        for (String field : fields) {
            if (String.isBlank(field)) continue;
            this.fields.add(field);
        }

        return true;
    }

    public Boolean setFilters(List<Filter> filters) {
        if (filters == null) {
            filters = new List<Filter>();
        }
        this.filters.clear();

        for (Filter filter : filters) {
            Boolean isNull = filter == null;
            Boolean isValueBlank = String.isBlank(filter.value);
            Boolean isNoneOperator = filter.operator == QueryConstants.NONE;

            if (isNull || isValueBlank || isNoneOperator) continue;
            this.filters.add(filter);
        }

        return true;
    }

    public String generateSOQLString() {
        if (fields.isEmpty()) {
            throw new QueryException('Filters or Fields is empty');
        }

        soqlRequest = QueryConstants.SELECT_SOQL + ' ';
        soqlRequest += String.join(fields, ',') + ' ';
        soqlRequest += QueryConstants.FROM_SOQL + ' ' + objectName + ' ';

        List<Filter> expressions = new List<Filter>();
        Map<String, Filter> specifyElements = new Map<String, Filter>();
        separateFilters(filters, expressions, specifyElements);

        System.debug(specifyElements);

        if (!expressions.isEmpty()) {
            soqlRequest += QueryConstants.WHERE_SOQL + ' ';
        }

        for (Filter filter : expressions) {
            String type = filter.type;
            String operator = filter.operator;
            String value = filter.value;
            String field = filter.field;
            if (type == QueryConstants.STRING_TYPE) {
                if (operator == QueryConstants.CONTAINS || operator == QueryConstants.DOES_NOT_CONTAIN) {
                    value = '%' + value + '%';
                }
                value = '\'' + value + '\'';
                if (operator == QueryConstants.DOES_NOT_CONTAIN) {
                    soqlRequest += QueryConstants.NOT_SOQL + ' ( ' + field + ' ' + QueryConstants.LIKE_SOQL + ' ' + value + ' ) ';
                }
                if (operator == QueryConstants.CONTAINS) {
                    soqlRequest += field + QueryConstants.OPERATORS_SOQL.get(operator) + value + ' ';
                }
                if (operator == QueryConstants.EQUAL) {
                    soqlRequest += field + QueryConstants.OPERATORS_SOQL.get(operator) + ' ' + value + ' ';
                }
            }
            if (type == QueryConstants.DATA_TYPE) {
                soqlRequest += field + QueryConstants.OPERATORS_SOQL.get(operator) + value;
            }
            if (type == QueryConstants.DATE_TYPE) {
                //TODO - add code for date format
            }
            soqlRequest += QueryConstants.AND_SOQL + ' ';
        }

        soqlRequest = soqlRequest.removeEnd(QueryConstants.AND_SOQL + ' ');
        soqlWithoutLimits = soqlRequest;

        if (specifyElements.containsKey(QueryConstants.LIMIT_SOQL)) {
            soqlRequest += ' ' + QueryConstants.LIMIT_SOQL + ' ' + specifyElements.get(QueryConstants.LIMIT_SOQL).value;
        }
        if (specifyElements.containsKey(QueryConstants.OFFSET_SOQL)) {
            soqlRequest += ' ' + QueryConstants.OFFSET_SOQL + ' ' + specifyElements.get(QueryConstants.OFFSET_SOQL).value;
        }

        System.debug(soqlRequest);
        return soqlRequest;
    }

    public List<SObject> getRecords(String soql) {
        try {
            return Database.query(soql);
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, e.getMessage());
            return new List<SObject>();
        }
    }

    private void separateFilters(List<Filter> filters, List<Filter> expressions, Map<String, Filter> specifyElements) {
        for (Filter filter : filters) {
            if (QueryConstants.ALL_OPERATORS_SOQL.contains(filter.operator)) {
                expressions.add(filter);
            } else {
                specifyElements.put(filter.operator, filter);
            }
        }
    }

    private Integer soqlResultSize(String soql) {
        try {
            return Database.query(soql).size();
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, e.getMessage());
            return 0;
        }
    }

}