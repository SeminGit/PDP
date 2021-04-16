public without sharing class ContactManager {
    @AuraEnabled
    public static Id createContact(String firstName, String lastName, String email, String password) {
        Contact contactToInsert = new Contact(
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                Password__c = password
        );
        try {
            insert contactToInsert;
        } catch (DmlException e) {
            System.debug('DML Exception' + e.getMessage());
        }
        return contactToInsert.Id;
    }
    @AuraEnabled
    public static Contact getContactByEmailAndPassword(String email, String password) {
        List<Contact> contactsToReturn = [
                                    SELECT Id,Name
                                    FROM Contact
                                    WHERE Email = :email
                                    AND Password__c = :password
        ];
        if(contactsToReturn.size() == 0) return null;
        return contactsToReturn[0];
    }
    @AuraEnabled
    public static Contact getContactByEmail(String email) {
        List<Contact> contactToReturn = [
                SELECT Id
                FROM Contact
                WHERE Email = :email
        ];
        if (contactToReturn.size() == 0) return null;
        return contactToReturn[0];
    }

}