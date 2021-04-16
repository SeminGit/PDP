@isTest
public with sharing class OutletManager_Test{
	@isTest
	static void test_getAllOutlets(){
		Outlet__c newOutlet = DataFactoryOutlet.insertOutlet(DataFactoryOutlet.createOutlet());
		Test.startTest();
		    List<Outlet__c> allOutlets = OutletManager.getAllOutlets();
		Test.stopTest();
		System.assertEquals(1, allOutlets.size());
	}

	@isTest
	static void test_getOutletsByQuery(){
		Outlet__c newOutlet = DataFactoryOutlet.insertOutlet(DataFactoryOutlet.createOutlet());
		Test.startTest();
		    List<Outlet__c> allOutlets = OutletManager.getOutletsByQuery('SELECT Id FROM Outlet__c');
		Test.stopTest();
		System.assertEquals(1, allOutlets.size());
	}
}