public without sharing class CaseController{
	@AuraEnabled
	public static void submitCase(String email, String subject, String description){
		Contact contact = ContactManager.getContactByEmail(email);
		Lead lead = LeadManager.getLeadByEmail(email);
		Case newCase = new Case(SuppliedEmail = email, Subject = subject);
		if (contact != null){
			newCase.ContactId = contact.Id;
		} else if (lead != null){
			newCase.Lead__c = lead.Id;
		}
		CaseManager.insertCase(newCase);
	}
}