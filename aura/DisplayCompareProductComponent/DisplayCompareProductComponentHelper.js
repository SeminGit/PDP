({
  sendProductEvent: function (component, eventName) {
    let product = component.get('v.product'),
        productPrice = component.get('v.productPrice'),
        sendProdEvent = component.getEvent(eventName);
    sendProdEvent.setParam('product', product);
    sendProdEvent.setParam('productPrice', productPrice);
    sendProdEvent.fire();
  },

  sendFlagEvent: function (component, eventName,flag) {
    let sendFlagEvent = component.getEvent(eventName);
    sendFlagEvent.setParam('flag', flag);
    sendFlagEvent.fire();
  }
});