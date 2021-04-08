public with sharing class MainMenuController {
    @AuraEnabled
    public static Map<String,Decimal> getCurrencies(){
        return CurrenciesManager.getAllCurrencies();
    }
}