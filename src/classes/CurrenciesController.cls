public with sharing class CurrenciesController {
    @AuraEnabled
    public static Map<String,Decimal> getCurrencies(){
        return CurrenciesManager.getAllCurrencies();
    }
}