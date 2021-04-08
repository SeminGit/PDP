public with sharing class WebServiceCallInitiatedTriggerHandler extends TriggerHandler{

    protected override void afterInsert() {
        Task newTask = new Task();

        newTask.Description = 'Task from Lead';
        newTask.Subject = 'Init Task';
        newTask.Type = Task.Type.getDescribe().picklistValues.get(0).value;

        insert newTask;
    }

}