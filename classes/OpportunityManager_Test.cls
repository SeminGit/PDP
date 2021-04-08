@isTest
public with sharing class OpportunityManager_Test{
	@TestSetup
	static void makeData(){
        Outlet__c outlet = new Outlet__c(City__c = 'Hrodna',Email__c = 'test@mail.ru',Location__Latitude__s = 53.670429, Location__Longitude__s = 23.823311, PhoneNumber__c = '1231231232', CloseTime__c = Datetime.now().time(), OpenTime__c = Datetime.now().time(), Street__c = 'Sovet');
        insert outlet;  
    }

	@isTest
	static void test_createOpportunity_1(){
        Test.startTest();
            Opportunity opp = OpportunityManager.createOpportunity('firstName', 'lastName', 'email@mail.ru', '1231312');
        Test.stopTest();
        insert opp;
        List<Opportunity> opps = [SELECT Id FROM Opportunity];
        List<Lead> newLead = [SELECT Id,FirstName FROM Lead WHERE Email = 'email@mail.ru'];
        System.assertEquals(opp.Id, opps[0].Id);
        System.assertEquals(1, newLead.size());
    }
    @isTest
    static void test_createOpportunity_withContact(){
       Contact newContact = DataFactoryContact.insertContact(DataFactoryContact.createContact());
        Test.startTest();
        Opportunity opp2 = OpportunityManager.createOpportunity(newContact.FirstName, newContact.LastName, newContact.Email, newContact.Phone);
            Opportunity opp = OpportunityManager.createOpportunity(newContact);
        Test.stopTest();
        insert opp;
        insert opp2;
        List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE Contact__c =:newContact.Id];
        System.assertEquals(2,opps.size());
    }
    @isTest
    static void test_createOpportunity_withLead(){
        Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
        Test.startTest();
        Opportunity opp2 = OpportunityManager.createOpportunity(newLead.FirstName, newLead.LastName, newLead.Email, newLead.Phone);
        Opportunity opp = OpportunityManager.createOpportunity(newLead);
        Test.stopTest();
        insert opp;
        insert opp2;
        List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE Lead__c =:newLead.Id];
        System.assertEquals(2, opps.size());
    }
    @isTest
    static void test_getDeliveryTypesValues_1(){
        Map<String, String> deliveryTypesValues = new Map<String, String>();
		Schema.DescribeFieldResult fieldResult = Opportunity.DeliveryType__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for (Schema.PicklistEntry f : ple){
			deliveryTypesValues.put(f.label, f.value);
		}
        Test.startTest();
            Map<String,String> deliveryTypesMap = OpportunityManager.getDeliveryTypesValues();
        Test.stopTest();
        System.assertEquals(deliveryTypesValues, deliveryTypesMap);
	}
}