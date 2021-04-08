public with sharing class OutletController{
	@AuraEnabled(cacheable = true)
	public static Map<String, String> getDeliveryPoints(){
		Map<String, String> maps = new Map<String, String>();
		List<Outlet__c> outlets = OutletManager.getAllOutlets();
		for (Outlet__c outlet : outlets){
			String str = outlet.Name + ',' + outlet.Street__c + ',' + outlet.City__c;
			System.debug(str);
			maps.put(str, outlet.Id);
		}
		return maps;
	}

	@AuraEnabled(cacheable = true)
	public static List<Outlet__c> getOutlets(){
		return OutletManager.getAllOutlets();
	}
}