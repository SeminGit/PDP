public class OpportunityManager{
	public static Opportunity createOpportunity(Lead lead){
		Opportunity opportunity = new Opportunity(Name = 'Opp', Pricebook2Id = Constants.CURRENT_PRICEBOOK_ID_CONST, StageName = 'Ordered', Probability = 100, CloseDate = Date.today().addDays(10), Lead__c = lead.Id, DeliveryAddress__c = 'here');
		return opportunity;
	}

	public static Opportunity createOpportunity(Contact contact){
		Opportunity opportunity = new Opportunity(Name = 'Opp', Pricebook2Id = Constants.CURRENT_PRICEBOOK_ID_CONST, StageName = 'Ordered', Probability = 100, CloseDate = Date.today().addDays(10), Contact__c = contact.Id, DeliveryAddress__c = 'here');
		return opportunity;
	}
	public static Opportunity createOpportunity(Id Id,String Type){
		Opportunity opportunity;
		switch on Type {
			when 'Contact' {
				opportunity = new Opportunity(Name = 'Opp', Pricebook2Id = Constants.CURRENT_PRICEBOOK_ID_CONST, StageName = 'Ordered', Probability = 100, CloseDate = Date.today().addDays(10), Contact__c = Id, DeliveryAddress__c = 'here');
			}
			when 'Lead'{
				opportunity = new Opportunity(Name = 'Opp', Pricebook2Id = Constants.CURRENT_PRICEBOOK_ID_CONST, StageName = 'Ordered', Probability = 100, CloseDate = Date.today().addDays(10), Lead__c = Id, DeliveryAddress__c = 'here');
			}
		}
		return opportunity;
	}

	public static Opportunity createOpportunity(String firstName, String lastName, String email, String phone){
		Lead lead = LeadManager.getLeadByEmail(email);
		Contact contact = ContactManager.getContactByEmail(email);
		if (contact != null){
			return OpportunityManager.createOpportunity(contact);
		} else if (lead != null){
			return OpportunityManager.createOpportunity(lead);
		} else{
			Lead newLead = new Lead(LastName = lastName, FirstName = firstName, Company = 'Customer', Email = email, Phone = phone);
			insert newLead;
			return createOpportunity(newLead);
		}
	}

	@AuraEnabled(cacheable = true)
	public static Map<String, String> getDeliveryTypesValues(){
		Map<String, String> deliveryTypesValues = new Map<String, String>();
		Schema.DescribeFieldResult fieldResult = Opportunity.DeliveryType__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for (Schema.PicklistEntry f : ple){
			deliveryTypesValues.put(f.label, f.value);
		}
		return deliveryTypesValues;
	}
}