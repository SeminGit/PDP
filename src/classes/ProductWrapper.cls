public with sharing class ProductWrapper {

    @AuraEnabled
    public Product2 product {get;set;}
    @AuraEnabled
    public Double price {get;set;}

    public static List<ProductWrapper> createWrapperFromProductsWithPrices(List<Product2> products){
        List<ProductWrapper> productsToReturn = new List<ProductWrapper>();
        Set<Id> productIds = Utility.getSetIdsFromSOBjectCollection(products);
        List<PricebookEntry> pricebookEntries = [SELECT Id, UnitPrice, Product2Id  FROM PricebookEntry WHERE Product2Id IN :productIds];
        for(PricebookEntry entry : pricebookEntries){
            for(Product2 p : products){
                if(p.Id == entry.Product2Id){
                    ProductWrapper pw = new ProductWrapper();
                    pw.product = p;
                    pw.price = entry.UnitPrice;
                    productsToReturn.add(pw);
                }
            }
        }
        return productsToReturn;
    }

}