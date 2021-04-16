public without sharing class OpportunityLineItemService {

    @AuraEnabled
    public static Boolean deleteOpportunityLineItemById(String id){
        return OpportunityLineItemManager.deleteOLIById(id);
    }
    @AuraEnabled
    public static OpportunityLineItem addOpportunityLineItemByProductId(String productId, String contactId){
        Opportunity cartOpportunity = OpportunityManager.getCartOpportunityByContactId(contactId);

        return OpportunityLineItemManager.createOPIByProductId(productId, cartOpportunity.Id);
    }

}