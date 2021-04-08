@isTest
public with sharing class CaseController_Test {
    @isTest
    static void test_submitCase_withLead(){
        Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
        Test.startTest();
            CaseController.submitCase(newLead.Email, 'test', 'test description');
        Test.stopTest();
        List<Case> newCase = [SELECT Id FROM Case WHERE Lead__c =: newLead.Id];
        System.assertEquals(1, newCase.size());
    }
    @isTest
    static void test_submitCase_withContact(){
        // insert works
        Contact newContact = DataFactoryContact.insertContact(DataFactoryContact.createContact());
        Test.startTest();
            CaseController.submitCase(newContact.Email, 'test', 'test description');
        Test.stopTest();
        List<Case> newCase = [SELECT Id FROM Case WHERE ContactId =: newContact.Id];
        System.assertEquals(1, newCase.size());
    }
    @isTest
    static void test_submitCase_emptyLead(){
        Test.startTest();
            CaseController.submitCase('test@email.ru', 'test', 'test description');
        Test.stopTest();
        List<Case> newCase = [SELECT Id FROM Case WHERE SuppliedEmail = 'test@mail.ru'];
        System.assertEquals(1, newCase.size());
    }
}