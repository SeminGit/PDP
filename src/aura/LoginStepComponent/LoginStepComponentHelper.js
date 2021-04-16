({
  checkValidity: function (component) {
    return component.find("field").reduce(function (validSoFar, inputCmp) {
      inputCmp.reportValidity();
      return validSoFar && inputCmp.checkValidity();
    }, true);
  },

  fireCustomerEvent: function (component, eventName, SObjectName, Id) {
    let foundEvent = component.getEvent(eventName);
    foundEvent.setParams({
      SObjectName: SObjectName,
      Id: Id
    });
    foundEvent.fire();
  },

  checkInfo : function(component){
    component.set("v.isSpinnerActive", true);
    let checkCustomerInfoAction = component.get("c.checkCustomer"),
    email = component.get("v.emailAttr"),
    phone = component.get("v.phoneAttr");
    checkCustomerInfoAction.setParams({
      email: email,
      phoneNumber: phone
    });
    checkCustomerInfoAction.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let answer = response.getReturnValue();
        if (answer) {
          this.fireCustomerEvent(component, 'foundCustomerEvent', answer.SObjectName, answer.Id);
      } else {
        this.fireCustomerEvent(component, 'notFoundCustomerEvent', email, phone);
      }
      component.set("v.isSpinnerActive", false);
    } else {
      component.set("v.isSpinnerActive", false);
      let errorHandler = component.find("errorHandler");
      errorHandler.setVisible(true);
    }
  });
  $A.enqueueAction(checkCustomerInfoAction);
  }
});