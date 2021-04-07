public inherited sharing class CS_ContactService {
    public static String findUserByCredentials(String email, String password) {
        if (String.isBlank(email) || String.isBlank(password)) {
            throw new CS_ContactServiceException(Constants.NULL_OR_BLANK_PARAM);
        }

        return CS_ContactManager.getUserIdByCredentials(email, password);
    }

    public static String registerUser(CS_RegisterInfoWrapper registerInfo) {
        if (registerInfo == null) {
            throw new CS_ContactServiceException(Constants.NULL_OR_BLANK_PARAM);
        }

        return CS_ContactManager.insertContactByRegisterInfo(registerInfo);
    }

    public static Boolean isUserExisting(String userEmail) {
        if (String.isBlank(userEmail)) {
            throw new CS_ContactServiceException(Constants.NULL_OR_BLANK_PARAM);
        }

        return CS_ContactManager.getContactByEmail(userEmail, null) == null ? false : true;
    }

    private class CS_ContactServiceException extends Exception {}
}