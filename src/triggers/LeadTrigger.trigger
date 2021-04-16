trigger LeadTrigger on Lead (after insert, after update) {
    if (!CustomSettingManager.isTriggerActive('LeadTrigger')) {
        return;
    }

    TriggerHandler.run(new LeadTriggerHandler());
}