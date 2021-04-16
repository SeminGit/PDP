@isTest
public with sharing class ProductManager_Test {
    @isTest
    static void test_countProductsWithFilters(){
        Product2 prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getProduct());
        Test.startTest();
            Decimal numberOfProducts = ProductManager.countProductsWithFilters(null, null);
        Test.stopTest();
        System.assertEquals(1, numberOfProducts);
    }
    @isTest
    static void test_getProductsByQueryString(){
        Product2 prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getProduct());
        Test.startTest();
            List<Product2> returnedProducts = ProductManager.getProductsByQueryString('SELECT Id FROM Product2');
        Test.stopTest();
        System.assertEquals(1, returnedProducts.size());
    }
}