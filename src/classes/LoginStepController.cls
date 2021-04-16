public with sharing class LoginStepController{
	@AuraEnabled
	public static LoginAnswerWrapper checkCustomer(String email, String phoneNumber){
		Contact checkContact = ContactManager.getContactByEmailOrPhone(email,phoneNumber);
		Lead checkLead = LeadManager.getLeadByEmailOrPhone(email,phoneNumber);
		if (checkContact != null){
            LoginAnswerWrapper wrapper = new LoginAnswerWrapper();
            wrapper.SObjectName = 'Contact';
            wrapper.Id = checkContact.Id;
            System.debug(wrapper);
            return wrapper;
        }
        if(checkLead != null){
            LoginAnswerWrapper wrapper = new LoginAnswerWrapper();
            wrapper.SObjectName = 'Lead';
            wrapper.Id = checkLead.Id;
            System.debug(wrapper);
            return wrapper;
        }
        return null;
	}
}