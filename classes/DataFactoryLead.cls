global with sharing class DataFactoryLead {
    global static Lead createLead(){
        Lead newLead = new Lead(FirstName = 'testFName',LastName = 'testLName', Company = 'testComp', Email = 'test@email.ru',Phone = '1242121421');
        return newLead;
    }
    global static Lead insertLead(Lead leadToInsert){
        insert leadToInsert;
        return leadToInsert;
    }
}