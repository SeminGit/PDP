({
  closeModel: function(component, event, helper) {
    let mapOpenedEvent = component.getEvent("isOutletsMapOpenedEvent");
    mapOpenedEvent.setParam("flag", false);
    mapOpenedEvent.fire();
  }
});