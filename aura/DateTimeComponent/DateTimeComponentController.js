({
    calculateDate : function(component, event, helper) {
        let date = component.get("v.date");
        if(date != null){
        component.set("v.showResult",true);
        return;
        }
        component.set("v.showResult", false);
    },
    CheckForNull : function(component, event, helper){
        let date = component.get("v.date");
        if(date != null) {
            component.set("v.buttonEnabled",false);
            return;
            }
        component.set("v.buttonEnabled", true);
        component.set("v.showResult",false);
        helper.Show($A.get("$Label.c.NumberShouldBePositive"),$A.get("$Label.c.EForceEventTitle"));
        helper.Show("Field should not be empty", "Alarm!");
    }
})