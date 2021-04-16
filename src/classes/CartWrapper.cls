public with sharing class CartWrapper {

    @AuraEnabled
    public List<ProductWrapper> products;

    @AuraEnabled
    public Double totalPrice;

}