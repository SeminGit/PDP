public with sharing class CustomSettingManager {

    public static Boolean isTriggerActive(String triggerName) {
        return Trigger_Activation__c.getValues(triggerName) == null ? true : Trigger_Activation__c.getValues(triggerName).isActive__c;
    }

}