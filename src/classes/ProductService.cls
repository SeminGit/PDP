public with sharing class ProductService {

    @AuraEnabled
    public static List<ProductWrapper> getProducts(List<Filter> filters) {
        QueryObject queryToSelectProducts = new QueryObject(Constants.PRODUCT_API_NAME);
        queryToSelectProducts.setFilters(filters);
        queryToSelectProducts.setFields(Constants.FIELDS_FOR_PRODUCT);

        List<Product2> returnedProducts = Database.query(queryToSelectProducts.generateSOQLString());

        if(returnedProducts.isEmpty()) return null;

        return ProductWrapper.createWrapperFromProductsWithPrices(returnedProducts);
    }

}