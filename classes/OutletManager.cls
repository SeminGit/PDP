public with sharing class OutletManager{
	public static List<Outlet__c> getAllOutlets(){
		return Database.query(SOQLQueryCreator.createSOQLQueryString(Constants.ALL_OUTLET_FIELDS_CONST, 'Outlet__c', null, null));
	}

	public static List<Outlet__c> getOutletsByQuery(String query){
		return Database.query(query);
	}
}