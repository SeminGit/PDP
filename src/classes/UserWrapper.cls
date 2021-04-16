/**
 * Created by user on 11/23/20.
 */

public with sharing class UserWrapper {

    @AuraEnabled
    public String email {get;set;}
    @AuraEnabled
    public String password {get;set;}
    @AuraEnabled
    public String firstName {get;set;}
    @AuraEnabled
    public String lastName {get;set;}

    public Boolean isEmpty() {
        if (email == null || email == '' || password == null || password == '' ||
                firstName == null || firstName == '' || lastName == null || lastName == '')
        {
            return true;
        }
        return false;
    }

}