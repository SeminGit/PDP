({
  getProducts: function() {
    let filters = event.getParam("filters"),
    operators = event.getParam("operators");
    displayComponent = component.find("displayComponent");
    displayComponent.setProducts(page, filters, operators);
  }
});