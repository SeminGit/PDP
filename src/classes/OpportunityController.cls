public without sharing class OpportunityController{
	@AuraEnabled
	public static void orderProductsPickup(Product2 product, Decimal price,String Type,String Id, String outletId, String deliveryType){
		// create simple opportunity
		Opportunity opportunity = OpportunityManager.createOpportunity(Id,Type);
		// add necessary fields
		opportunity.OutletId__c = outletId;
		opportunity.DeliveryType__c = deliveryType;
		insert opportunity;
		// add products
		OpportunityLineItem opportunityLineItem = OpportunityProductManager.createOpportunityProduct(product, price, 1, opportunity.Id, 0);
		insert opportunityLineItem;	
	}
	@AuraEnabled
	public static void orderProductsCourier(Product2 product, Decimal price,String Type,String Id,String street, String city, String country, String deliveryType){
		// create simple opportunity
		Opportunity opportunity = OpportunityManager.createOpportunity(Id,Type);
		// add necessary fields
		opportunity.DeliveryAddress__c = country + ',' + city + ',' + street;
		opportunity.DeliveryType__c = deliveryType;
		opportunity.OutletId__c = Constants.MAIN_WAREHOUSE_ID_CONST;
		insert opportunity;
		// add products
		OpportunityLineItem opportunityLineItem = OpportunityProductManager.createOpportunityProduct(product, price, 1, opportunity.Id, 0);
		insert opportunityLineItem;
	}
	@AuraEnabled
	public static void orderProductsPost(Product2 product, Decimal price,String Type,String Id,String postCode, String deliveryType){
		// create simple opportunity
		Opportunity opportunity = OpportunityManager.createOpportunity(Id,Type);
		// add necessary fields
		opportunity.OutletId__c = Constants.MAIN_WAREHOUSE_ID_CONST;
		opportunity.DeliveryType__c = deliveryType;
		opportunity.DeliveryAddress__c = 'PostCode: ' + postCode;
		insert opportunity;
		// add products
		OpportunityLineItem opportunityLineItem = OpportunityProductManager.createOpportunityProduct(product, price, 1, opportunity.Id, 0);
		insert opportunityLineItem;
	}
	@AuraEnabled
	public static Id addNewLead(String firstName,String lastName,String email,String phone){
		Id newLeadId = LeadManager.createNewLead(firstName, lastName, email, phone);
		return newLeadId;
	}
	@AuraEnabled(cacheable = true)
	public static Map<String, String> getDeliveryTypesValues(){
		return OpportunityManager.getDeliveryTypesValues();
	}
	@AuraEnabled(cacheable = true)
	public static Map<String, String> getRelatedOutlets(){
		return OutletController.getDeliveryPoints();
	}
}