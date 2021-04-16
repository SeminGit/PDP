({
  sendProductEvent: function (component, eventName) {
    let product = component.get('v.product'),
        sendProdEvent = component.getEvent(eventName);
    sendProdEvent.setParams({'product': product});
    sendProdEvent.fire();
  },

  sendFlagEvent: function (component, eventName,flag) {
    let sendFlagEvent = component.getEvent(eventName);
    sendFlagEvent.setParam('flag', flag);
    sendFlagEvent.fire();
  }
});