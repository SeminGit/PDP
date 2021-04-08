({
  removeFromCompare: function (component, event, helper) {
    helper.sendProductEvent(component, "removeProductFromCompareListEvent");
  },

  orderProductClicked: function (component, event, helper) {
    helper.sendProductEvent(component, "productSelected");
    helper.sendFlagEvent(component, "isCompareWindowOpenedEvent", false);
    helper.sendFlagEvent(component, "isOrderWindowOpenedEvent", true);
  }
});