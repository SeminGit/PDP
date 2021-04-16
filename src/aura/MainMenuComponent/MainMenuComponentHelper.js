({
  fireEvent: function(component, eventName, paramName, paramValue) {
    let helpOpenedEvent = component.getEvent(eventName);
    helpOpenedEvent.setParam(paramName, paramValue);
    helpOpenedEvent.fire();
  }
});