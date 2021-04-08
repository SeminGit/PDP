public with sharing class SortingMenuController {
    @AuraEnabled
    public static List<String> getProductCatigories(){
        List<String> categories = new List<String>();
        categories.add('All');
		Schema.DescribeFieldResult fieldResult = Product2.Category__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for (Schema.PicklistEntry f : ple){
			categories.add(f.label);
		}
		return categories;
    }
}