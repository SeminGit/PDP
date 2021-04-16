({
  init: function(component, event, helper) {},
  setProducts: function(component, event, helper) {
    const filters = event.getParam("filters");
    const operators = event.getParam("operators");
    const displayComponent = component.find("displayComponent");

    displayComponent.setProducts(filters, operators);
  },

  setNewProducts: function(component, event, helper) {
    let filters = event.getParam("filters"),
      operators = event.getParam("operators"),
      displayComponent = component.find("displayComponent");
    displayComponent.setNewProducts(filters, operators);
  },

  showSelectedProduct: function(component, event, helper) {
    component.set("v.selectedProduct", event.getParam("product"));
    component.set("v.selectedProductPrice", event.getParam("productPrice"));
  },

  sendPDFData: function(component, event, helper) {
    let sortingComponent = component.find("sortingComponent");
    sortingComponent.getPDFFile();
  },

  changeCurrency: function(component, event, helper) {
    let curr = event.getParam("currencyObj"),
        turn = component.get('c.turnPageEventHandler');
    component.set("v.currencyRate", curr);
    $A.enqueueAction(turn);
  },

  turnPageEventHandler: function(component, event, helper) {
    // call sorting component method to get sort values
    let sortingComponent = component.find("sortingComponent");
    sortingComponent.getFilters();
  },

  isOutletsMapOpenedEventHandler: function(component, event, helper) {
    component.set("v.isOutletsMapOpened", event.getParam("flag"));
  },

  isOrderModalWindowOpenedEventHandler: function(component, event, helper) {
    component.set("v.isOrderModalWindowOpened", event.getParam("flag"));
  },

  isCompareWindowOpenedEventHandler: function(component, event, helper) {
    component.set("v.isCompareWindowOpened", event.getParam("flag"));
  },

  addProductToCompareListEventHandler: function(component, event, helper) {
    let compareProducts = component.get("v.compareProductsList"),
        productToAdd = event.getParam('product'),
        productPrice = event.getParam('productPrice'),
        hasRepeat = false;
    for(let i = 0; i < compareProducts.length;i++){
      if(compareProducts[i].product.Name == productToAdd.Name){
          hasRepeat = true;
          break;
      }
    }
    if(!hasRepeat){
      compareProducts.push({
        product: productToAdd,
        price: productPrice
      });
    }
  },

  removeProductFromCompareListEventHandler: function(component, event, helper) {
    let compareProducts = component.get("v.compareProductsList");
    compareProducts.splice(compareProducts.indexOf(event.getParam('product')),1);

    component.set('v.compareProductsList', compareProducts);
  },

  isCaseModalWindowOpenEventHandler: function(component, event, helper) {
    component.set("v.isCaseModalWindowOpen", event.getParam("flag"));
  }
});