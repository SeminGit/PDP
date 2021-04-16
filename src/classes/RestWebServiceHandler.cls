public without sharing class RestWebServiceHandler {

    public static Map<String, Decimal> handleGetRequest(String websiteName, String numberOfAccounts) {
        if (String.isBlank(websiteName) || String.isBlank(numberOfAccounts)) {
            throw new RestWebServiceHandlerException(Constants.NULL_OR_EMPTY_PARAM);
        }

        return AccountManager.getAccountsWithEmployeesAmount(websiteName, Integer.valueOf(numberOfAccounts));
    }

    public static String createAccountFromRequestBody(RestUtils.AccountWrapper accountWrapper) {
        if (accountWrapper == null || !accountWrapper.isRequiredFilled) {
            throw new RestWebServiceHandlerException(Constants.NULL_OR_EMPTY_PARAM);
        }

        return AccountManager.createAccountFromWrapper(accountWrapper);
    }

    private class RestWebServiceHandlerException extends Exception {}
}