@isTest
public with sharing class OpportunityProductManager_Test {
    @isTest
    static void test_createOpportunityProduct_all(){
        List<Product2> newProducts =DataFactoryProduct.insertProducts(DataFactoryProduct.getNewProducts());
        Id pbId = Test.getStandardPricebookId();
        
        PricebookEntry standartPricebookEntry = DataFactoryPricebookEntry.insertPricebookEntry(DataFactoryPricebookEntry.createPricebookEntry(pbId,newProducts[0].Id));
        Opportunity newOpportunity = DataFactoryOpportunity.insertOpportunity(DataFactoryOpportunity.createOpportunity(pbId));
        Test.startTest();
            OpportunityLineItem oli1 = OpportunityProductManager.createOpportunityProduct(newProducts[0],100,1,newOpportunity.Id,0.0);
            OpportunityLineItem oli2 = OpportunityProductManager.createOpportunityProduct(newProducts[0],100,1,newOpportunity.Id,10.0);
            List<OpportunityLineItem> itemsList = new List<OpportunityLineItem>();
            itemsList.add(oli1);            
            itemsList.add(oli2);            
            insert itemsList;
        Test.stopTest();
        List<OpportunityLineItem> itemsListAfterInsert = [SELECT Id FROM OpportunityLineItem WHERE Product2Id =: newProducts[0].Id];

        System.assertEquals(2, itemsListAfterInsert.size());
    }
}