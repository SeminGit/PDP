global with sharing class DataFactoryPricebookEntry {
    
    global static PricebookEntry createPricebookEntry(Id pricebook2Id, Id productId){
        PricebookEntry standartPricebookEntry = new PricebookEntry(
                Pricebook2Id = pricebook2Id,
                Product2Id = productId,
                UnitPrice = 100,
                IsActive = true
            ); 
        return standartPricebookEntry;
    }
    global static PricebookEntry insertPricebookEntry(PricebookEntry entry){
        insert entry;
        return entry;
    }
}