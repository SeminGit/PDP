@isTest
public with sharing class LeadManager_Test{
	@isTest
	static void test_getLeadByEmail_returnNull(){
		Lead newLead = DataFactoryLead.createLead();
		Test.startTest();
		    Lead returnedLead = LeadManager.getLeadByEmail(newLead.Email);
		Test.stopTest();
		System.assertEquals(null, returnedLead);
	}

	@isTest
	static void test_getLeadByEmail_returnSuccess(){
		Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
		Test.startTest();
		    Lead returnedLead = LeadManager.getLeadByEmail(newLead.Email);
		Test.stopTest();
		System.assertEquals(newLead.Id, returnedLead.Id);
	}

	@isTest
	static void test_createNewLead(){
		Test.startTest();
		    String leadId = LeadManager.createNewLead('firstName', 'lastName', 'email@sad.asd', '12312312');
        Test.stopTest();
        List<Lead> newLeads = [SELECT Id FROM Lead];
		System.assertEquals(1,newLeads.size());
	}

	@isTest
	static void test_getLeadByEmailOrPhone(){
		Lead newLead = DataFactoryLead.createLead();
		Test.startTest();
		    Lead returnedLead = LeadManager.getLeadByEmailOrPhone(newLead.Email, newLead.Phone);
		Test.stopTest();
		System.assertEquals(newLead.Id, returnedLead.Id);
    }
    @isTest
    static void test_getLeadByEmailOrPhone_ReturnNull(){
		Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
		Test.startTest();
		    Lead returnedLead = LeadManager.getLeadByEmailOrPhone(newLead.Email, newLead.Phone);
		Test.stopTest();
		System.assertEquals(newLead.Id, returnedLead.Id);
	}

	@isTest
	static void test_deleteLeadsByIds_1(){
		Lead newLead = new Lead(LastName = 'testLname', FirstName = 'test_firstName', Company = 'Customer', Email = 'email@mail.mail', Phone = '12312421412');
		insert newLead;
		List<Id> leadsToDelete = new List<Id>();
		leadsToDelete.add(newLead.Id);
		Test.startTest();
		    LeadManager.deleteLeadsByIds(leadsToDelete);
		Test.stopTest();
		List<Lead> leadsAfterDelete = [SELECT 
		                                     Id
		                               FROM Lead
		                               WHERE Id IN :leadsToDelete];
		System.assertEquals(0, leadsAfterDelete.size());
	}
}