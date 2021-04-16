({
  calculateDate: function (component, event, helper) {
    let date = component.get("v.date");
    console.log( utilities.sum(1, 2) );

    if (date != null) {
      component.set("v.showResult", true);
      return;
    }

    component.set("v.showResult", false);
  },

  CheckForNull: function (component, event, helper) {
    let date = component.get("v.date");

    if (date != null) {
      component.set("v.buttonEnabled", false);
      return;
    }

    component.set("v.buttonEnabled", true);
    component.set("v.showResult", false);

    utilities.showToast($A.get("$Label.c.NumberShouldBePositive"), $A.get("$Label.c.EForceEventTitle"));
    utilities.showToast("Field should not be empty", "Alarm!");
  },

  onScriptLoad: function () {
    utilities.showToast('Loaded!', 'External JScript Was Loaded!');
    console.log( utilities.sum(1, 2) );
  }
})