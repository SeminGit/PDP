global class NbRBService {
    private static String NATIONAL_BANK_NAMED_CREDENTIALS = 'callout:National_Bank/?Periodicity=0';

    public static Map<String,Decimal> getRates(){
        HttpRequest request = HttpUtils.createGetRequest(NATIONAL_BANK_NAMED_CREDENTIALS, 60000);
        HttpResponse response = HttpUtils.sendRequest(request);
        List<CurrenciesManager.Rate> rates = (List<CurrenciesManager.Rate>)RestUtils.deserializeResponseBody(response.getBody(), List<CurrenciesManager.Rate>.class);

        return CurrenciesManager.createNameToRateMapFromRateList(rates);
    }
}