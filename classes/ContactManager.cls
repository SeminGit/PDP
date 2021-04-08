public without sharing class ContactManager{
	public static Contact getContactByEmailOrPhone(String email,String phone){
		List<Contact> contacts = [SELECT Id
		                          FROM Contact
		                          WHERE Email = :email OR Phone =:phone
		                          LIMIT 1];
		if (contacts == null || contacts.size() == 0){
			return null;
		}
		return contacts[0];
	}
	public static Contact getContactByEmail(String email){
		List<Contact> contacts = [SELECT Id
		                          FROM Contact
		                          WHERE Email = :email
		                          LIMIT 1];
		if (contacts == null || contacts.size() == 0){
			return null;
		}
		return contacts[0];
	}
	public static List<Contact> getContactsByIds(Set<Id> ids){
		return [SELECT Id,Email,FirstName,LastName,Phone FROM Contact WHERE Id IN :ids];
	}
}