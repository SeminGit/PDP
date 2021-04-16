({
  foundCustomer: function (component, event, helper) {
    let SObjectName = event.getParam("SObjectName"),
      Id = event.getParam("Id");
    component.set("v.stepName", "orderStep");
    component.set("v.customerId", Id);
    component.set("v.sObjectName", SObjectName);
  },
  customerNotFound: function (component, event, helper) {
    let SObjectName = event.getParam("SObjectName"),
      Id = event.getParam("Id");
    component.set("v.stepName", "orderStep");
    component.set("v.emailAttr", SObjectName);
    component.set("v.phoneAttr", Id);
  },
  changeStepHandler: function (component, event, helper) {
    component.set("v.stepName", event.getParam("string"));
  }
});