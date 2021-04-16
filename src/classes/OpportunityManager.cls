public without sharing class OpportunityManager {

    public static Opportunity getCartOpportunityByContactId(String contactId) {
        return Database.query(
                'SELECT ' + String.join(Constants.FIELDS_FOR_OPPORTUNITY, ',') + ' FROM ' + Constants.OPPORTUNITY_API_NAME +
                        ' WHERE ContactId = \'' + contactId + '\''
        );
    }
}