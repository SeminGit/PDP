public inherited sharing class CS_ContactManager {

    public static String getUserIdByCredentials(String email, String password) {
        if (String.isBlank(email) || String.isBlank(password)) {
            throw new CS_ContactManagerException(Constants.NULL_OR_BLANK_PARAM);
        }

        List<Contact> selectedContacts = Database.query(
                Utility.getQueryString(SObjectType.Contact.name, new Set<String>{
                        'Id'
                })
                        + ' ' + Constants.Q_WHERE + ' ' + 'Email = ' + Utility.wrapToQuotes(email) + ' '
                        + Constants.Q_AND + ' ' + 'Password__c = ' + Utility.wrapToQuotes(password)
        );

        if (selectedContacts.isEmpty()) return null;

        return selectedContacts[0].Id;
    }

    public static String insertContactByRegisterInfo(CS_RegisterInfoWrapper registerInfo) {
        if (registerInfo == null) {
            throw new CS_ContactManagerException(Constants.NULL_OR_BLANK_PARAM);
        }

        Contact contactToInsert = createContactByRegisterInfo(registerInfo);

        insert contactToInsert;

        return contactToInsert.Id;
    }

    public static Contact createContactByRegisterInfo(CS_RegisterInfoWrapper registerInfo) {
        if (registerInfo == null) {
            throw new CS_ContactManagerException(Constants.NULL_OR_BLANK_PARAM);
        }

        return new Contact(
                FirstName = String.isBlank(registerInfo.firstName) ? '' : registerInfo.firstName,
                LastName = String.isBlank(registerInfo.lastName) ? '' : registerInfo.lastName,
                Password__c = String.isBlank(registerInfo.password) ? '' : registerInfo.password,
                Email = String.isBlank(registerInfo.email) ? '' : registerInfo.email
        );
    }

    public static Contact getContactByEmail(String contactEmail, Set<String> fieldsToSelect) {
        if (String.isBlank(contactEmail)) {
            throw new CS_ContactManagerException(Constants.NULL_OR_BLANK_PARAM);
        }

        return (Contact) CS_SObjectManager.getSObjectWithCondition(
                SObjectType.Contact.name,
                fieldsToSelect,
                'Email = ' + Utility.wrapToQuotes(contactEmail)
        );
    }

    private class CS_ContactManagerException extends Exception {
    }
}