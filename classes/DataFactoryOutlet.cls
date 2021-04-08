global  with sharing class DataFactoryOutlet {
    global static Outlet__c createOutlet(){
        Outlet__c outlet = new Outlet__c(City__c = 'Hrodna',Email__c = 'test@mail.ru',Location__Latitude__s = 53.670429, Location__Longitude__s = 23.823311, PhoneNumber__c = '1231231232', CloseTime__c = Datetime.now().time(), OpenTime__c = Datetime.now().time(), Street__c = 'Sovet');
        return outlet;
    }
    global static Outlet__c insertOutlet(Outlet__c outlet){
        insert outlet;
        return outlet;
    }
}