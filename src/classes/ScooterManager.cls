/**
 * Created by user on 11/25/20.
 */

public without sharing class ScooterManager {

    public static String SCOOTER_API_NAME = 'Scooter__c';

    public static List<Scooter__c> getScooters(){
        List<Scooter__c> scootersToReturn = [SELECT Name, Price__c FROM Scooter__c LIMIT 2];
        if(scootersToReturn == null && scootersToReturn.size() == 0) return null;
        return scootersToReturn;
    }

}