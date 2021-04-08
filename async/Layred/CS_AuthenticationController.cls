public with sharing class CS_AuthenticationController {

    @AuraEnabled
    public static String authenticateUser(CredentialsWrapper credentials) {
        if (credentials == null || String.isBlank(credentials.email) || String.isBlank(credentials.password)) {
            throw new CS_AuthenticationControllerException(Constants.NULL_OR_BLANK_PARAM);
        }

        return CS_ContactService.findUserByCredentials(credentials.email, credentials.password);
    }

    @AuraEnabled
    public static String registerUser(CS_RegisterInfoWrapper registerInfo) {
        if (registerInfo == null) {
            throw new CS_AuthenticationControllerException(Constants.NULL_OR_BLANK_PARAM);
        }

        try {
            return CS_ContactService.registerUser(registerInfo);
        } catch (Exception e) {
            return null;
        }
    }

    @AuraEnabled
    public static Boolean isUserExisting(String userEmail) {
        if (String.isBlank(userEmail)) {
            throw new CS_AuthenticationControllerException(Constants.NULL_OR_BLANK_PARAM);
        }

        try{
            return CS_ContactService.isUserExisting(userEmail);
        } catch (Exception e) {
            return null;
        }
    }

    public class CredentialsWrapper {
        @AuraEnabled public String email;
        @AuraEnabled public String password;
    }

    private class CS_AuthenticationControllerException extends Exception {}
}