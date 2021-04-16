global with sharing class DataFactoryOpportunity {
    global static Opportunity createOpportunity(){
        Opportunity opportunity = new Opportunity(Name = 'Opp',StageName = 'Ordered', Probability = 100, CloseDate = Date.today().addDays(10), DeliveryAddress__c = 'here');
        return opportunity;
    }
    global static Opportunity createOpportunity(Id pricebookId){
        Opportunity opportunity = new Opportunity(Name = 'Opp',StageName = 'Ordered', Pricebook2Id = pricebookId,Probability = 100, CloseDate = Date.today().addDays(10), DeliveryAddress__c = 'here');
        return opportunity;
    }
    global static Opportunity insertOpportunity(Opportunity opportunity){
        insert opportunity;
        return opportunity;
    }
}