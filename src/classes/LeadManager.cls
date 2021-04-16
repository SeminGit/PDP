public without sharing class LeadManager{
	public static Lead getLeadByEmail(String email){
		List<Lead> leads = [SELECT Id
		                    FROM Lead
		                    WHERE Email = :email
		                    LIMIT 1];
		if (leads == null || leads.size() == 0){
			return null;
		}
		return leads[0];
	}
	public static Lead getLeadByEmailOrPhone(String email, String phone){
		List<Lead> leads = [SELECT Id
		                    FROM Lead
		                    WHERE Email = :email OR Phone = :phone
		                    LIMIT 1];
		if (leads == null || leads.size() == 0){
			return null;
		}
		return leads[0];
	}
	public static void deleteLeadsByIds(List<Id> ids){
		delete [SELECT Id
		        FROM Lead
		        WHERE Id IN :ids];
	}
	@AuraEnabled
	public static String createNewLead( String firstName, String lastName,String email,String phone){
		Lead newLead = new Lead(LastName = lastName, FirstName = firstName, Company = 'Customer', Email = email, Phone = phone);
		try{
			insert newLead;
		}catch(DmlException ex){
			System.debug(ex.getMessage());
			return null;
		}
		return newLead.Id;
	}
}