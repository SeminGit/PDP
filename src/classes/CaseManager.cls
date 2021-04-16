public without sharing class CaseManager{
	public static void insertCase(Case caseToInsert){
		try{
			insert caseToInsert;
		}catch(DmlException ex){
			System.debug(ex.getMessage());
		}
	}
}