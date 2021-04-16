public with sharing class AccountTriggerHandler extends TriggerHandler{

    protected override void beforeUpdate() {
        if (!Utilities.canEditFields(Account.class.getName(), new Set<String>{'Website'})) {
            Utilities.throwCustomException('User does not have access required to the field!');
        }

        for (Account acc : (List<Account>) Trigger.new) {
            if (!acc.Website.contains('.')) {
                acc.addError('Website address must contain a dot!');
            }
        }
    }

}