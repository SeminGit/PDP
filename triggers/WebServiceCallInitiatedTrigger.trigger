trigger WebServiceCallInitiatedTrigger on WebServiceCallInitiated__e (after insert) {
    if (!CustomSettingManager.isTriggerActive('WebServiceCallInitiatedTrigger')) {
        return;
    }

    WebServiceCallInitiatedTriggerHandler handler = new WebServiceCallInitiatedTriggerHandler();

    handler.run(Trigger.operationType);
}