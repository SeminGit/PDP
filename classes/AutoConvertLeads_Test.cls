@isTest
public with sharing class AutoConvertLeads_Test {
    @isTest
    static void test_ConvertToContact_1(){
        Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
        Opportunity opportunity = DataFactoryOpportunity.createOpportunity();
        opportunity.Lead__c = newLead.Id;
        DataFactoryOpportunity.insertOpportunity(opportunity);

        List<Id> leadsToConvert = new List<Id>();
        leadsToConvert.add(newLead.Id);
        Test.startTest();
            AutoConvertLeads.ConvertToContact(leadsToConvert);
        Test.stopTest();
        List<Contact> contacts = [SELECT Name FROM Contact WHERE FirstName =: newLead.FirstName LIMIT 1];
        List<Lead> leadsAfterDeleting = [SELECT Id FROM Lead WHERE Id =: newLead.Id];
        List<Opportunity> opps = [SELECT Lead__c,Contact__c FROM Opportunity WHERE Contact__c =: contacts[0].Id];
        System.assertEquals(1, contacts.size());
        System.assertEquals(0,leadsAfterDeleting.size());
        System.assertEquals(1, opps.size());
    }
}