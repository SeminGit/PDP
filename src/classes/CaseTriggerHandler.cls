public with sharing class CaseTriggerHandler extends TriggerHandler{
    
    // public override void beforeInsert(){
        
    //     List<String> emails = new List<String>();
    //     List<Lead> newLeads = new List<Lead>();
        
    //     for(Case item : (List<Case>)Trigger.new) {
    //         if(item.SuppliedEmail != null){
    //             emails.add(item.SuppliedEmail);
    //         }
    //     }

        
    //     for (Lead lead : [SELECT Id,Email FROM Lead WHERE Email IN :emails]){
    //         for (Case itemCase : (List<Case>)Trigger.new) {
    //             if(itemCase.SuppliedEmail == lead.Email){
    //                 itemCase.Lead__c = lead.Id;
    //                 emails.remove(emails.indexOf(lead.Email));
    //                 break;
    //             }
    //         }   
    //     }
    //     for (Contact contact : [SELECT Id,Email FROM Contact WHERE Email IN :emails]){
    //         for (Case itemCase : (List<Case>)Trigger.new) {
    //             if(itemCase.SuppliedEmail == contact.Email){
    //                 itemCase.ContactId = contact.Id;
    //                 break;
    //             }else{
    //                 Lead lead = new Lead(
    //                 Email = itemCase.SuppliedEmail,
    //                 LastName = 'question',
    //                 Company = 'question'
    //                     );
    //             newLeads.add(lead);
    //             }
    //         }
    //     }
    //     insert newLeads;

    //      Integer i = 0;
    //      for (Case item : (List<Case>)Trigger.new) {
    //          if(item.ContactId == null && item.Lead__c == null){
    //              item.Lead__c = newLeads[i].Id;
    //              i++;
    //          }
    //      }
    // }
}