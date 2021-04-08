global class DataDisplayController{
    public List<Product2> PDFData{get;set;}
    public List<PricebookEntry> Prices{get;set;}
    public String currencyLabel  {get;set;}
	public DataDisplayController(){
        currencyLabel = 'BYN';
		String name = System.currentPageReference().GetParameters().get('name');
        if(name == null){
            name = '';
        }
        String strName = '%' + name + '%';
        Decimal travel = Decimal.valueOf(System.currentPageReference().GetParameters().get('travel'));
		if(travel == null){
            travel = 1;
        }
        Decimal curr = Decimal.valueOf(System.currentPageReference().GetParameters().get('currency'));
		if(curr == null){
            curr = 1;
        }
		String category = System.currentPageReference().GetParameters().get('category');
		Decimal price = Decimal.valueOf(System.currentPageReference().GetParameters().get('price'));
		if (category == 'All'){
			if(price == 0){
                PDFData =[SELECT Id,Name,MaxWeight__c
                FROM Product2
                WHERE TravelDistance__c >= :travel AND Name LIKE :strName];
            }else if(price != 0){
                PDFData =[SELECT Id,Name,MaxWeight__c
                FROM Product2
                WHERE TravelDistance__c >= :travel AND Name LIKE :strName AND Id IN (SELECT Product2Id FROM PricebookEntry WHERE UnitPrice <= :price)];
            }
		}else{
            if(price == 0){
                PDFData =[SELECT Id,Name,MaxWeight__c
                FROM Product2
                WHERE Category__c = :category AND TravelDistance__c >= :travel AND Name LIKE :strName];
            }else if(price != 0){
                PDFData =[SELECT Id,Name,MaxWeight__c
                FROM Product2
                WHERE Category__c = :category AND TravelDistance__c >= :travel AND Name LIKE :strName AND Id IN (SELECT Product2Id FROM PricebookEntry WHERE UnitPrice <= :price)];
            }
        } 
         Prices = [SELECT Product2Id,UnitPrice FROM PricebookEntry];
         for (Product2 prod : PDFData) {
             for (PricebookEntry en : Prices) {
                 if(en.Product2Id == prod.Id){
                     prod.MaxWeight__c = en.UnitPrice.setScale(2);
                 }
             }
         }
	}
}