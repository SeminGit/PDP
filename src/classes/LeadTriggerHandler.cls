public inherited sharing class LeadTriggerHandler extends TriggerHandler{

    protected override void afterInsert() {
        List<Task> tasksToCreate = new List<Task>();

        for (Lead l: (List<Lead>) Trigger.new) {
            Task newTask = new Task();

            newTask.WhoId = l.Id;
            newTask.Description = 'Task from Lead';
            newTask.Subject = 'Init Task';
            newTask.Type = Task.Type.getDescribe().picklistValues.get(0).value;

            tasksToCreate.add(newTask);
        }

        insert tasksToCreate;
    }

}