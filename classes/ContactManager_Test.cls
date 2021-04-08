@isTest
public with sharing class ContactManager_Test {
    @isTest
    static void test_getContactByEmail_returnNull(){
        Contact newContact =DataFactoryContact.createContact();
        Test.startTest();
           Contact returnedContact = ContactManager.getContactByEmail(newContact.Email);
        Test.stopTest();
        System.assertEquals(null, returnedContact);
    }
    @isTest
    static void test_getContactByEmail_returnContact(){
        Contact newContact = DataFactoryContact.insertContact(DataFactoryContact.createContact());
        Test.startTest();
           Contact returnedContact = ContactManager.getContactByEmail(newContact.Email);
        Test.stopTest();
        System.assertEquals(newContact.Id, returnedContact.Id);
    }
    @isTest
    static void test_getContactByEmailOrPhone(){
        Contact newContact = DataFactoryContact.insertContact(DataFactoryContact.createContact());
        Test.startTest();
           Contact returnedContact = ContactManager.getContactByEmailOrPhone(newContact.Email, newContact.Phone);
        Test.stopTest();
        System.assertEquals(newContact.Id, returnedContact.Id);
    }
}