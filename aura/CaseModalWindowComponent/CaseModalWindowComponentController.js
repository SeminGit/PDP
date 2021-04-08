({
  submit: function (component, event, helper) {
    let step = event.getParam("string");
    component.set("v.step", step);
  },

  closeWindow: function (component, event, helper) {
    let isWindowOpenEvent = component.getEvent("isCaseModalWindowOpenEvent");
    isWindowOpenEvent.setParam("flag", false);
    isWindowOpenEvent.fire();
  }
});