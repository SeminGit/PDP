public inherited sharing class AccountManager {

    public static Map<String, Decimal> getAccountsWithEmployeesAmount(String websiteName, Integer numberOfAccounts) {
        if(String.isBlank(websiteName) || numberOfAccounts == null || numberOfAccounts <= 0 || numberOfAccounts > 2000) {
            throw new AccountManagerException(Constants.NULL_OR_EMPTY_PARAM);
        }

        String webSiteSearch = '%' + websiteName + '%';
        Map<String, Decimal> nameToNumberOfEmployees = new Map<String, Decimal>();

        for (Account acc : [SELECT Name,NumberOfEmployees FROM Account WHERE Website LIKE :webSiteSearch LIMIT :numberOfAccounts]) {
            nameToNumberOfEmployees.put(acc.Name, acc.NumberOfEmployees);
        }

        return nameToNumberOfEmployees;
    }

    public static String createAccountFromWrapper(RestUtils.AccountWrapper wrapper) {
        if (wrapper == null) {
            throw new AccountManagerException(Constants.NULL_OR_EMPTY_PARAM);
        }

        Account accountToInsert = new Account();
        Map<String, String> fieldsToValues = wrapper.fieldsToValues;

        for (String key : fieldsToValues.keySet()) {
            accountToInsert.put(key, fieldsToValues.get(key));
        }

        insert accountToInsert;
        return accountToInsert.Id;
    }

    private class AccountManagerException extends Exception {}
}