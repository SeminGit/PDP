global class GetCurrencyRatesSheduleJob implements Schedulable{
	global static void execute(SchedulableContext sc){
		CurrenciesManager.setCurrencyRates();
	}
}