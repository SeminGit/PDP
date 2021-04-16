public class SendEmailFromOpportunity{
	@InvocableMethod
	public static void SendEmail(List<Opportunity> opportunities){
		//get related ids
		Set<Id> contactIds = new Set<Id>();
		for (Opportunity opp : opportunities){
			if (opp.Contact__c != null){
				contactIds.add(opp.Contact__c);
			}
		}
		List<Contact> contacts = ContactManager.getContactsByIds(contactIds); 
		EmailTemplate template = [SELECT Id
		                          FROM Emailtemplate
		                          WHERE Name = : Constants.THANKS_EMAIL_TEMPLATE_NAME
		                          LIMIT 1];
		List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
		// send emails to related contacts
		for (Contact contact : contacts){
			Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
			message.toAddresses = new String[]{contact.Email};
			message.setTemplateId(template.Id);
			message.setTargetObjectId(contact.Id);
			emailsToSend.add(message);
		}
		Messaging.sendEmail(emailsToSend);
	}
}