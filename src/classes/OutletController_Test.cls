@isTest
public with sharing class OutletController_Test {
    @isTest
    static void test_getDeliveryPoints_1(){
        Outlet__c newOutlet = DataFactoryOutlet.insertOutlet(DataFactoryOutlet.createOutlet());
        Test.startTest();
            Map<String,String> outlets = OutletController.getDeliveryPoints();
            List<Outlet__c> allOutlets = OutletController.getOutlets();
        Test.stopTest();
        System.assertEquals(1, outlets.size());
        System.assertEquals(1, allOutlets.size());
    }
}