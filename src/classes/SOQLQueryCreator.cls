public with sharing class SOQLQueryCreator{
	public static String createSOQLQueryString(List<String> fieldNames, String sojbectName, Map<String, String> filters, Map<String, String> operators){
		String query = 'SELECT' + ' ';
		System.debug(fieldNames);
		// form fileds that we want to get
		for (Integer i = 0; i < fieldNames.size(); i++){
			// last field should not have comma after
			if (i == fieldNames.size() - 1){
				query += fieldNames[i];
				break;
			}
			query += fieldNames[i] + ',';
		}
		// Add FROM block
		query += ' FROM ' + sojbectName + ' ';
		// check for filters if exist => continue
		if (filters != null && operators != null){
			//flag on first filter === it should add WHERE block
			Boolean firstRequest = true;
			for (String key : filters.keySet()){
				String value = filters.get(key);
				if (firstRequest && value != null && value != ''){
					query += 'WHERE ' + key + ' ' + getRequestString(value, operators.get(key));
					firstRequest = false;
				} else if (value != null && value != ''){
					query += ' AND ' + key + ' ' + getRequestString(value, operators.get(key));
				}
			}
		}
		return query;
	}
	private static String getRequestString(String value, String operator){
		if (operator.containsIgnoreCase('like')){
			return 'LIKE \'%' + value + '%\'';
		} else if (Constants.ARIFMETIC_OPERATORS_CONST.contains(operator)){
			return operator + value;
		} else if (operator.containsIgnoreCase('IN')){
			return 'IN' + ' ' + value + ' ';
		}
		return '';
	}
	public static String addSubQueryFilter(String query, String fieldName, String operator, String subQuery){
		if (query.contains('WHERE')){
			return query += 'AND' + ' ' + fieldName + ' ' + operator + ' ' + '(' + subQuery + ')';
		}
		return query += 'WHERE' + ' ' + fieldName + ' ' + operator + ' ' + '(' + subQuery + ')';
	}
	public static String addLimitSectionToQuery(String query, Integer numberOfElements){
		return query += ' ' + 'LIMIT' + ' ' + String.valueOf(numberOfElements);
	}
	public static String addOffsetSectionToQuery(String query, Integer shift){
		return query += ' ' + 'OFFSET' + ' ' + String.valueOf(shift);
	}
	public static String addOrderBySectionToQuery(String query, String fieldToOrderBy){
		return query += ' ' + 'ORDER BY' + ' ' + fieldToOrderBy;
	}
}