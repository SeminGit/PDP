public with sharing class OpportunityProductManager{
	public static OpportunityLineItem createOpportunityProduct(Product2 product, Decimal price, Integer quantity, String opportunityId, Decimal discount){
		OpportunityLineItem item;
		if (discount == 0){
			item = new OpportunityLineItem(Product2Id = product.Id, Quantity = quantity, OpportunityId = opportunityId, UnitPrice = price);
		} else{
			item = new OpportunityLineItem(Product2Id = product.Id, Quantity = quantity, OpportunityId = opportunityId, Discount = discount, UnitPrice = price);
		}
		return item;
	}
}