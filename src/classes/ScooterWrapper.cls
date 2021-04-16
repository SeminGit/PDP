/**
 * Created by user on 11/25/20.
 */

public with sharing class ScooterWrapper {

    @AuraEnabled
    public String name { get; set; }
    @AuraEnabled
    public Double price { get; set; }
    @AuraEnabled
    public String imageId { get; set; }

    public ScooterWrapper() {
    }

}