@isTest
public with sharing class LoginStepComponent_Test {
    @isTest
    static void test_checkCustomer_Lead(){
        Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
        Test.startTest();
            LoginAnswerWrapper wrapper = LoginStepController.checkCustomer(newLead.Email, newLead.Phone);
        Test.stopTest();
        System.assertEquals(newLead.Id,wrapper.Id);
    }
    @isTest
    static void test_checkCustomer_Contact(){
        Contact newContact = DataFactoryContact.insertContact(DataFactoryContact.createContact());
        Test.startTest();
            LoginAnswerWrapper wrapper = LoginStepController.checkCustomer(newContact.Email, newContact.Phone);
        Test.stopTest();
        System.assertEquals(newContact.Id,wrapper.Id);
    }
    @isTest
    static void test_checkCustomer(){
        Lead newLead = DataFactoryLead.createLead();
        Test.startTest();
            LoginAnswerWrapper wrapper = LoginStepController.checkCustomer(newLead.Email, newLead.Phone);
        Test.stopTest();
        System.assertEquals(null,wrapper);
    }
}