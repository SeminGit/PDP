public without sharing class ContactService {

    @AuraEnabled
    public static Contact loginUser(String email, String password) {
        return ContactManager.getContactByEmailAndPassword(email, password);
    }

    @AuraEnabled
    public static Id registryUser(UserWrapper user) {
        System.debug(user);
        if (user.isEmpty()) {
            return null;
        }
        return ContactManager.createContact(user.firstName, user.lastName, user.email, user.password);
    }

    @AuraEnabled
    public static Boolean isEmailReserved(String email) {
        if (email == '') {
            throw new applicationException('Empty parameter!');
        }
        Boolean result = ContactManager.getContactByEmail(email) != null;
        return result;
    }

    @AuraEnabled
    public static List<Contact> getContacts(List<String> fields, List<Filter> filters) {
        QueryObject contactQuery = new QueryObject('Contact');
        contactQuery.setFields(fields);
        contactQuery.setFilters(filters);
        List<Contact> contactsToReturn = Database.query(contactQuery.generateSOQLString());
        if (contactsToReturn.isEmpty()) {
            return null;
        }
        return contactsToReturn;
    }

}