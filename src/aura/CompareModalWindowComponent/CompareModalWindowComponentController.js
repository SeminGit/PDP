({
  closeWindow: function(component, event, helper) {
    let windowEvent = component.getEvent("isCompareWindowOpenedEvent");
    windowEvent.setParam("flag", false);
    windowEvent.fire();
  }
});