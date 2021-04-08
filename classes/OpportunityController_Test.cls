@isTest
public with sharing class OpportunityController_Test {
    @testSetup
    static void setData() {
        Product2 prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getProduct());
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standartPricebookEntry = new PricebookEntry(
                Pricebook2Id = pricebookId,
                Product2Id = prod.Id,
                UnitPrice = 100,
                IsActive = true
            ); 
    }
    @isTest
    static void test_orderProductsPickup_1(){
        Product2 newProduct = DataFactoryProduct.insertProducts(DataFactoryProduct.getProduct());
        Outlet__c newOutlet = DataFactoryOutlet.insertOutlet(DataFactoryOutlet.createOutlet());
        Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
        Test.startTest();
            OpportunityController.orderProductsPickup(newProduct, 100, 'Lead',newLead.Id, newOutlet.Id, 'Pickup');
        Test.stopTest();
        List<Opportunity> opportunitiesAfterInsert = [SELECT Id FROM Opportunity];
        List<OpportunityLineItem> opportunityLineItemAfterInsert = [SELECT Id FROM OpportunityLineItem];
        System.assertEquals(1, opportunitiesAfterInsert.size());
        System.assertEquals(1, opportunityLineItemAfterInsert.size());

    }
    @isTest
    static void test_orderProductsCourier(){
        Product2 newProduct = DataFactoryProduct.insertProducts(DataFactoryProduct.getProduct());
        Outlet__c newOutlet = DataFactoryOutlet.insertOutlet(DataFactoryOutlet.createOutlet());
        Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
        Test.startTest();
            OpportunityController.orderProductsCourier(newProduct, 100, 'Lead',newLead.Id, 'Streer','city','country','Courier');
        Test.stopTest();
        List<Opportunity> opportunitiesAfterInsert = [SELECT Id FROM Opportunity];
        List<OpportunityLineItem> opportunityLineItemAfterInsert = [SELECT Id FROM OpportunityLineItem];
        System.assertEquals(1, opportunitiesAfterInsert.size());
        System.assertEquals(1, opportunityLineItemAfterInsert.size());

    }
    @isTest
    static void test_orderProductsPost(){
        Product2 newProduct = DataFactoryProduct.insertProducts(DataFactoryProduct.getProduct());
        Outlet__c newOutlet = DataFactoryOutlet.insertOutlet(DataFactoryOutlet.createOutlet());
        Lead newLead = DataFactoryLead.insertLead(DataFactoryLead.createLead());
        Test.startTest();
            OpportunityController.orderProductsPost(newProduct, 100, 'Lead', newLead.Id, '112233', 'Post');
        Test.stopTest();
        List<Opportunity> opportunitiesAfterInsert = [SELECT Id FROM Opportunity];
        List<OpportunityLineItem> opportunityLineItemAfterInsert = [SELECT Id FROM OpportunityLineItem];
        System.assertEquals(1, opportunitiesAfterInsert.size());
        System.assertEquals(1, opportunityLineItemAfterInsert.size());
    }
    @isTest
    static void test_addNewLead(){
        Test.startTest();
            String leadId = OpportunityController.addNewLead('test','test','test@test.test','11221233212');
        Test.stopTest();
        List<Lead> newLeads = [SELECT Id FROM Lead];
		System.assertEquals(1,newLeads.size());
    }
    @isTest
    static void test_getDeliveryTypesValues(){
        Map<String, String> deliveryTypesValues = new Map<String, String>();
		Schema.DescribeFieldResult fieldResult = Opportunity.DeliveryType__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for (Schema.PicklistEntry f : ple){
			deliveryTypesValues.put(f.label, f.value);
		}
        Test.startTest();
            Map<String,String> deliveryTypesMap = OpportunityController.getDeliveryTypesValues();
        Test.stopTest();
        System.assertEquals(deliveryTypesValues, deliveryTypesMap);
    }
    @isTest
    static void test_getRelatedOutlets(){
        Outlet__c newOutlet = DataFactoryOutlet.insertOutlet(DataFactoryOutlet.createOutlet());
        Test.startTest();
        Map<String, String> allOutlets = OpportunityController.getRelatedOutlets();
        Test.stopTest();
        System.assertEquals(1, allOutlets.size());
    }
}