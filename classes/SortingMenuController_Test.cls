@isTest
public with sharing class SortingMenuController_Test {
    @isTest
    static void test_getProductCatigories(){
        List<String> categories = new List<String>();
        categories.add('All');
		Schema.DescribeFieldResult fieldResult = Product2.Category__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for (Schema.PicklistEntry f : ple){
			categories.add(f.label);
		}
        Test.startTest();
            List<String> returnedCategories = SortingMenuController.getProductCatigories();
        Test.stopTest();
        System.assertEquals(categories, returnedCategories);
    }   
}