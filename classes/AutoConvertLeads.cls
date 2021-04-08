public class AutoConvertLeads{
	@InvocableMethod
	public static void ConvertToContact(List<Id> leadIds){
		List<Opportunity> opportunities = [SELECT Contact__c,Lead__c
		                                   FROM Opportunity
		                                   WHERE Lead__c IN :leadIds];
		List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
		LeadStatus CLeadStatus = [SELECT Id, MasterLabel
		                          FROM LeadStatus
		                          WHERE IsConverted = true
		                          Limit 1];
		for (Id currentlead : leadIds){
			List<Opportunity> tempOpportunities = new List<Opportunity>();
			for (Opportunity opp : opportunities){
				if (opp.Lead__c == currentlead){
					tempOpportunities.add(opp);
				}
			}
			Database.LeadConvert Leadconvert = new Database.LeadConvert();
			Leadconvert.setLeadId(currentlead);
			Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
			Database.LeadConvertResult lcr = Database.convertLead(Leadconvert);
			Id cId = lcr.getContactId();
			for (Opportunity opp : tempOpportunities){
				opp.Contact__c = cId;
				opp.Lead__c = null;
			}
			opportunitiesToUpdate.addAll(tempOpportunities);
		}
		System.debug(opportunitiesToUpdate);
		update opportunitiesToUpdate;
		LeadManager.deleteLeadsByIds(leadIds);
	}
}