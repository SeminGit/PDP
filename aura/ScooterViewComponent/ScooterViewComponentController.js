({
  productSelectedHandler: function(component, event, helper) {
    let product = component.get("v.product"),
        productPrice = component.get("v.productPrice"),
        productSelectedEvent = component.getEvent("productSelected");
      productSelectedEvent.setParam("product", product);
      productSelectedEvent.setParam("productPrice", productPrice);
      productSelectedEvent.fire();
  }
});