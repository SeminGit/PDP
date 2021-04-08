({
  firePageTurnedEvent: function(component, page) {
    let pageTurnedEvent = component.getEvent("pageTurnedEvent");
    pageTurnedEvent.setParam("page", page);
    pageTurnedEvent.fire();
  },
  
  getProducts: function(component, page, limits, filters, operators) {
    component.set("v.productsList", null);
    component.set("v.isSpinnerActive", true);
    let action = component.get("c.getProductsList"),
      crutch = {},
      crutch2 = {};
    if (filters != null && operators != null) {
      for (let key of filters.keys()) {
        crutch[key] = filters.get(key);
      }
      for (let key of operators.keys()) {
        crutch2[key] = operators.get(key);
      }
    } else {
      crutch = new Map();
      crutch2 = new Map();
    }
    action.setParams({
      filters: crutch,
      operators: crutch2,
      pageNumber: page,
      limits: limits
    });
    action.setCallback(this, function(response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        // store the response return value (wrapper class insatance)
        let result = response.getReturnValue(),
            productsList = [],
            answer = result.products;
        for (let i = 0; i < answer.length; i++) {
          productsList.push({
            product: answer[i],
            price: answer[i].PricebookEntries[0].UnitPrice
          });
        }
        component.set("v.productsList", productsList);
        component.set("v.page", result.page);
        component.set("v.total", result.total);
        component.set("v.pagesAmount", Math.ceil(result.total / limits));
        component.set("v.isSpinnerActive", false);
      } else {
        console.log(response.getError[0]);
      }
    });
    $A.enqueueAction(action);
  },

  loadPageSizes: function(component){
    let action = component.get('c.getPageSizes');
    action.setCallback(this,function(response){
      let state = response.getState();
      if(state === 'SUCCESS'){
        let answer = response.getReturnValue();
        component.set('v.pageSizesList',answer);
      }
    });
    $A.enqueueAction(action);
  }
});