public without sharing class OpportunityLineItemManager {

    public static Boolean deleteOLIById(String id) {
        /*List<FilterWrapper> filtersForOLI = new List<FilterWrapper>{
                new FilterWrapper('Id', FilterOperators.EQUAL, id, null, 'String')
        };
        List<OpportunityLineItem> opportunityLineItemsToDelete = Database.query(
                QueryCreator.createQuery(
                        new QueryObject(
                                Constants.OPPORTUNITY_LINE_ITEM_API_NAME, Constants.FIELDS_FOR_OPPORTUNITY_LINE_ITEM, filtersForOLI
                        )
                )
        );*/
        try {
            delete [SELECT Id FROM OpportunityLineItem WHERE Id = :id];
            return true;
        } catch (DmlException ex) {
            System.debug(ex);
            return false;
        }
    }

    public static OpportunityLineItem createOPIByProductId(String productId, String oppId) {
        if (String.isEmpty(productId) || String.isEmpty(oppId)) return null;

        OpportunityLineItem opi = new OpportunityLineItem();

        opi.Product2Id = productId;
        opi.OpportunityId = oppId;
        opi.Quantity = 1;
        opi.UnitPrice = PriceBookEntryManager.getStandardPricebookEntryByProductId(productId).UnitPrice;

        try {
            insert opi;
            return opi;
        } catch (DmlException ex) {
            System.debug(ex);
            return opi;
        }
    }

    public static List<OpportunityLineItem> getOLIByOpportunityId(String opportunityId) {
        if (String.isEmpty(opportunityId)) return null;

        List<OpportunityLineItem> oppls = [SELECT Id, Name, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :opportunityId];

        return oppls;
    }

}