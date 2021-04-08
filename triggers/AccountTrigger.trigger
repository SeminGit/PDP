trigger AccountTrigger on Account (before insert, before update) {
    if (!CustomSettingManager.isTriggerActive('AccountTrigger')) {
        return;
    }

    AccountTriggerHandler handler = new AccountTriggerHandler();

    handler.run(Trigger.operationType);
}