@isTest
public with sharing class CurrenciesController_Test {
    @isTest
    static void test_getCurrencies_Controller(){
        Currency__c curr = new Currency__c();
        curr.Rate__c = 1;
        curr.Name = 'test';
        insert curr;
        Test.startTest();
            Map<String,Decimal> currencies = CurrenciesController.getCurrencies();
        Test.stopTest();
        System.assertEquals(1,currencies.size());
    }
    @isTest
    static void test_getCurrencies_Manager(){
        Currency__c curr = new Currency__c();
        curr.Rate__c = 1;
        curr.Name = 'test';
        insert curr;
        Test.startTest();
            Map<String,Decimal> currencies = CurrenciesManager.getAllCurrencies();
        Test.stopTest();
        System.assertEquals(1,currencies.size());
    }
}