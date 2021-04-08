public without sharing class ProductController{
	@AuraEnabled(cacheable = true)
	public static ProductPageWrapper getProductsList(Map<String, String> filters, Map<String, String> operators, Decimal pageNumber, Integer limits){
		if (limits == null){
			limits = 100;
		}
		if (pageNumber == null){
			pageNumber = 1;
		}
		Integer pageSize = limits;
		Integer offset = ((Integer)pageNumber - 1) * pageSize;
		// specific fields processing
		String maxPrice = '';
		if (filters != null){
			if (filters.containsKey('maxPrice')){
				if (filters.get('maxPrice') != '' && filters.get('maxPrice') != null){
					maxPrice = filters.get('maxPrice');
					filters.remove('maxPrice');
				}
			}
		}
		// auto creation of a string
		String query = SOQLQueryCreator.createSOQLQueryString(Constants.ALL_PRODUCT2_FIELDS_CONST, 'Product2', filters, operators);
		// sort by price (add subQuery to WHERE block) ---> specific field
		if (maxPrice != ''){
			Map<String, String> subQueryFilters = new Map<String, String>();
			subQueryFilters.put('UnitPrice', maxPrice);
			Map<String, String> subQueryOperators = new Map<String, String>();
			subQueryOperators.put('UnitPrice', '>=');
			List<String> fileds = new List<String>();
			fileds.add('Product2Id');
			query = SOQLQueryCreator.addSubQueryFilter(query, 'Id', 'IN', SOQLQueryCreator.createSOQLQueryString(fileds, 'PricebookEntry', subQueryFilters, subQueryOperators));
		}
		// add end blocks
		query = SOQLQueryCreator.addOrderBySectionToQuery(query, 'Name');
		query = SOQLQueryCreator.addLimitSectionToQuery(query, limits);
		query = SOQLQueryCreator.addOffsetSectionToQuery(query, offset);
		System.debug(query);
		// create a instance of wrapper class.
		ProductPageWrapper obj = new ProductPageWrapper();
		// set the pageSize,Page(Number), total records and accounts List(using OFFSET)
		obj.pageSize = pageSize;
		obj.page = (Integer)pageNumber;
		obj.total = ProductManager.countProductsWithFilters(filters, operators);
		obj.products = ProductManager.getProductsByQueryString(query);
		// return the wrapper class instance .
		return obj;
	}
	@AuraEnabled(cacheable = true)
	public static String getAttachedImage(String parentId){
		List<Attachment> att = [SELECT Id
		                        FROM Attachment
		                        WHERE ParentId = :parentId
		                        LIMIT 1];
		if (att == null){
			return null;
		}
		return att[0].Id;
	}
	@AuraEnabled
	public static List<Decimal> getPageSizes(){
		List<PageSizes__c> pageSizes = PageSizes__c.getAll().values();
		List<Decimal> sizesToSend = new List<Decimal>();
		for (PageSizes__c ps : pageSizes) {
			sizesToSend.add(ps.Size__c);
		}
		sizesToSend.sort();
		return sizesToSend;
	}
	@AuraEnabled(cacheable = true)
	public static Decimal getCurrencyRate(String currencyName){
		return Currency__c.getValues(currencyName).Rate__c;
	}
}