public without sharing class OpportunityService {

    @AuraEnabled
    public static List<OpportunityLineItem> getCartProducts(String contactId) {
        List<FilterWrapper> filtersForCartOpportunity = new List<FilterWrapper>{
                new FilterWrapper('StageName', FilterOperators.EQUAL, 'Cart', WHERE_OPERATORS.AND_OPERATOR, 'String'),
                new FilterWrapper('Contact__c', FilterOperators.EQUAL, contactId, null,'String')
        };
        List<Opportunity> cartOpportunities = [
                SELECT Id
                FROM Opportunity
                WHERE StageName = 'Cart'
                AND ContactId = :contactId
        ];
               /* Database.query(
                QueryCreator.createQuery(
                        new QueryObject(Constants.OPPORTUNITY_API_NAME, Constants.FIELDS_FOR_OPPORTUNITY, filtersForCartOpportunity)
                )
        );*/
        System.debug('CART' + cartOpportunities);
        String cartId = '';

        if (cartOpportunities != null && cartOpportunities.size() > 0)
            cartId = cartOpportunities[0].Id;
        List<FilterWrapper> filtersForCartProducts = new List<FilterWrapper>{
                new FilterWrapper('OpportunityId', FilterOperators.EQUAL, cartId, null, 'String')
        };
        List<OpportunityLineItem> opportunityLineItems = [
                SELECT Id, Name, OpportunityId, UnitPrice, TotalPrice, Quantity, Product2Id
                FROM OpportunityLineItem
                WHERE OpportunityId =: cartId
        ];
                /*Database.query(
                QueryCreator.createQuery(
                        new QueryObject(
                                Constants.OPPORTUNITY_LINE_ITEM_API_NAME,
                                Constants.FIELDS_FOR_OPPORTUNITY_LINE_ITEM,
                                filtersForCartProducts
                        )
                )
        );*/
        System.debug(opportunityLineItems);
        if(opportunityLineItems == null && opportunityLineItems.size() == 0) return null;

        return opportunityLineItems;
    }

}