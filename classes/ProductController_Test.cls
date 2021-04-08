@isTest
public with sharing class ProductController_Test {
    @isTest
    static void test_getProductsList_success(){
        List<Product2> prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getNewProducts());
        Test.startTest();
            ProductPageWrapper returnedProducts = ProductController.getProductsList(null,null,1,4);
        Test.stopTest();
        System.debug(returnedProducts);
        System.debug(returnedProducts.products);
        System.assertEquals(prod.size(), returnedProducts.products.size());
    }
    @isTest
    static void test_getProductsList_limits_Null(){
        List<Product2> prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getNewProducts());
        Test.startTest();
            ProductPageWrapper returnedProducts = ProductController.getProductsList(null,null,1,null);
        Test.stopTest();
        System.debug(returnedProducts);
        System.debug(returnedProducts.products);
        System.assertEquals(prod.size(), returnedProducts.products.size());
    }
    @isTest
    static void test_getProductsList_pageSize_Null(){
        List<Product2> prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getNewProducts());
        Test.startTest();
            ProductPageWrapper returnedProducts = ProductController.getProductsList(null,null,null,4);
        Test.stopTest();
        System.debug(returnedProducts);
        System.debug(returnedProducts.products);
        System.assertEquals(prod.size(), returnedProducts.products.size());
    }
    @isTest
    static void test_getProductsList_maxPrice(){
        List<Product2> prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getNewProducts());
        Map<String,String> filters = new Map<String,String>();
        filters.put('maxPrice', '10000');
        Map<String,String> operators = new Map<String,String>();
        operators.put('maxPrice', '<=');
        Test.startTest();
            ProductPageWrapper returnedProducts = ProductController.getProductsList(filters,operators,1,4);
        Test.stopTest();
        System.assertEquals(prod.size(), returnedProducts.products.size());
    }
    @isTest
    static void test_getAttachedImage(){
        Product2 prod = DataFactoryProduct.insertProducts(DataFactoryProduct.getProduct());
        Blob attachmentBody = EncodingUtil.base64Decode('AA==');
        Attachment attachment = new Attachment();
            attachment.Body = attachmentBody;
            attachment.Name = 'Test';
            attachment.ParentId = prod.Id; 
            insert attachment;
        Test.startTest();
            String attachId = ProductController.getAttachedImage(prod.Id);
        Test.stopTest();
        System.assertEquals(attachment.Id, attachId);
    }
    @isTest(SeeAllData = true)
    static void test_getCurrencyRate(){
        String currencyName = 'BYN';
        Decimal settingValue = Currency__c.getValues(currencyName).Rate__c;
        Test.startTest();
            Decimal testValue = ProductController.getCurrencyRate(currencyName);
        Test.stopTest();
        System.assertEquals(settingValue, testValue);
    }
    @isTest(SeeAllData = true)
    static void test_getPageSizes(){
        List<PageSizes__c> sizes = PageSizes__c.getAll().values();
		List<Decimal> s = new List<Decimal>();
		for (PageSizes__c ps : sizes) {
			s.add(ps.Size__c);
        }
        s.sort();
        Test.startTest();
            List<Decimal> pageSizes = ProductController.getPageSizes();
        Test.stopTest();
        System.assertEquals(s, pageSizes);
    }
}