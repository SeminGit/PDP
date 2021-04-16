public without sharing class StudentSharingRecalculate implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([SELECT Id FROM Student__c]);
    }

    public void execute(Database.BatchableContext context, List<SObject> scope) {
        List<Student__Share> sharesToInsert = new List<Student__Share>();

        for (Student__c stu : (List<Student__c>) scope) {
            Student__Share share = new Student__Share();

            share.RowCause = Schema.Student__Share.RowCause.BecauseICan__c;
            share.ParentId = stu.Id;
            share.UserOrGroupId = '00G2v000004WYM6EAO';
            share.AccessLevel = 'Edit';

            sharesToInsert.add(share);
        }

        insert sharesToInsert;
    }

    public void finish(Database.BatchableContext context) {

    }

}