public class ProductManager {
	@AuraEnabled
    public static Integer countProductsWithFilters(Map<String,String> filters, Map<String,String> operators){
        return Database.countQuery(SOQLQueryCreator.createSOQLQueryString(Constants.COUNT_PRODUCTS_FIELD, 'Product2', filters, operators));
    }
    public static List<Product2> getProductsByQueryString(String query){
        return Database.query(query);
    }
}