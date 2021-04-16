({
  orderProductClicked: function (component, event, helper) {
    let windowEvent = component.getEvent("isOrderWindowOpenedEvent");
    windowEvent.setParam("flag", true);
    windowEvent.fire();
  },

  addToCompareClicked: function (component, event, helper) {
    let product = component.get("v.product"),
      productPrice = component.get("v.productPrice"),
      productSelectedEvent = component.getEvent(
      "addProductToCompareListEvent"
    );
    productSelectedEvent.setParam("product", product);
    productSelectedEvent.setParam("productPrice", productPrice);
    productSelectedEvent.fire();
  }
});