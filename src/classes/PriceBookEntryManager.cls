public without sharing class PriceBookEntryManager {

    public static PricebookEntry getStandardPricebookEntryByProductId(String productId) {

        /*List<FilterWrapper> filters = new List<FilterWrapper>{
                new FilterWrapper('Product2Id',
                        FilterOperators.EQUAL,
                        productId,
                        null,
                        'String')
        };
        PricebookEntry pricebookToReturn = Database.query(
                QueryCreator.createQuery(
                        new QueryObject(Constants.PRICEBOOK_ENTRY_API_NAME, Constants.FIELDS_FOR_PRICEBOOK_ENTRY, filters,1)
                )
        );*/
        return [SELECT Id, Name, Product2Id, UnitPrice FROM PricebookEntry WHERE Product2Id =: productId LIMIT 1];
    }

}