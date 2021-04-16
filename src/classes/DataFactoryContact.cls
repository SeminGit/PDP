global with sharing class DataFactoryContact {
    
    global static Contact createContact(){
        Contact newContact = new Contact(FirstName = 'testFName',LastName = 'testLName', Email = 'test@email.ru',Phone = '1242121421');
        return newContact;
    }
    global static Contact insertContact(Contact contactToInsert){
        insert contactToInsert;
        return contactToInsert;
    }

}