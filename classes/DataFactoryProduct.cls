global with sharing class DataFactoryProduct {
    global static List<Product2> getNewProducts(){
        Product2 newProduct1 = new Product2(Name = 'testProduct1',BataryCapacity__c = 1,Category__c = 'Adult',ChargingTime__c = 1,Color__c ='Black', MaxSpeed__c = 20,MaxWeight__c = 10,TravelDistance__c = 10);
        Product2 newProduct2= new Product2(Name = 'testProduct2',BataryCapacity__c = 1,Category__c = 'Adult',ChargingTime__c = 1,Color__c ='Black', MaxSpeed__c = 20,MaxWeight__c = 10,TravelDistance__c = 10);
        Product2 newProduct3 = new Product2(Name = 'testProduct2',BataryCapacity__c = 1,Category__c = 'Adult',ChargingTime__c = 1,Color__c ='Black', MaxSpeed__c = 20,MaxWeight__c = 10,TravelDistance__c = 10);
        List<Product2> newProducts = new List<Product2>();
        newProducts.add(newProduct1);
        newProducts.add(newProduct2);
        newProducts.add(newProduct3);
        return newProducts;
    }
    global static Product2 getProduct(){
        return new Product2(Name = 'testProduct1',BataryCapacity__c = 1,Category__c = 'Adult',ChargingTime__c = 1,Color__c ='Black', MaxSpeed__c = 20,MaxWeight__c = 10,TravelDistance__c = 10);
    }
    global static Product2 insertProducts(Product2 product){
        insert product;
        return product;
    }
    global static List<Product2> insertProducts(List<Product2> products){
        insert products;
        return products;
    }
}