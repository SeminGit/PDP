public without sharing class ScooterService {


    @AuraEnabled
    public static List<Scooter__c> getScooters(List<String> fields, List<FilterWrapper> filters) {
        /*String query = QueryCreator.createQuery(
                new QueryObject(ScooterManager.SCOOTER_API_NAME,fields,filters)
        );*/
        //QueryObject qo = new QueryObject(ScooterManager.SCOOTER_API_NAME, fields, filters);
        return null;
    }


}