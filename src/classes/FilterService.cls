public class FilterService {
    @AuraEnabled
    public static List<String> getAvailableOperators(String type) {
        if (String.isBlank(type)) {
            throw new QueryException('Empty type');
        }

        return QueryConstants.AVAILABLE_OPERATORS.get(type);
    }
}