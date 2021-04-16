global with sharing class CurrenciesManager {

    @future(callout = true)
    public static void setCurrencyRates(){
        List<Currency__c> allCurrencies = Currency__c.getAll().values(); 
        Map<String,Decimal> returnedCurrencies = NbRBService.getRates();

        for (Currency__c curr : allCurrencies) {
            Decimal value = returnedCurrencies.get(curr.Name);

            if(value != null){
                curr.Rate__c = value;
            }
        }

        try{
            update allCurrencies;
        }catch(DmlException ex){
            System.debug(ex.getMessage());
        }
    }

    public static Map<String, Decimal> createNameToRateMapFromRateList(List<Rate> rates) {
        if (rates == null || rates.isEmpty()) {
            Utilities.throwCustomException(Constants.NULL_OR_EMPTY_PARAM);
        }

        Map<String,Decimal> currencyMap = new Map<String,Decimal>();

        for (Rate rate : rates) {
            currencyMap.put(rate.Cur_Abbreviation, rate.Cur_OfficialRate / rate.Cur_Scale);
        }

        return currencyMap;
    }
    
    public static Map<String,Decimal> getAllCurrencies(){
        Map<String,Decimal> currencyMap = new Map<String,Decimal>();

        for (Currency__c curr : Currency__c.getAll().values()) {
            currencyMap.put(curr.Name, curr.Rate__c);
        }

        return currencyMap;
    }

    public class Rate{
        public String CUR_ID;
        public String Cur_Abbreviation ;
        public Decimal Cur_Scale;
        public String Cur_Name;
        public Decimal Cur_OfficialRate;
    }
}