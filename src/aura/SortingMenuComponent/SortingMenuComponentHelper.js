({
  fireFilterEvent: function (component, eventName) {
    let name = component.get("v.name"),
      maxPrice = component.get("v.maxPrice"),
      currencyValue = component.get("v.currencyRate").value,
      catigory = component.find("categoryPicklist").get("v.value"),
      distance = component.get("v.maxDistance");
    if (name != undefined) {
      name = name.trim();
    }
    if (maxPrice) {
      maxPrice *= currencyValue;
    }
    if (catigory == "All") {
      catigory = "";
    }

    let filters = new Map(),
        operators = new Map();

    filters.set("Name", name);
    filters.set("maxPrice", maxPrice);
    filters.set("Category__c", catigory);
    filters.set("TravelDistance__c", distance);

    operators.set("Name", "LIKE");
    operators.set("maxPrice", "<=");
    operators.set("Category__c", "LIKE");
    operators.set("TravelDistance__c", ">=");
    let compEvent = component.getEvent(eventName);
    compEvent.setParams({
      filters: filters,
      operators: operators
    });
    compEvent.fire();
  },

  formParametersString: function (component) {
    let name = component.get("v.name"),
      maxPrice = component.get("v.maxPrice"),
      catigory = component.find("categoryPicklist").get("v.value"),
      distance = component.get("v.maxDistance"),
      currency = component.get("v.currencyRate");
    // check for nulls
    if (name != null) {
      name = name.trim();
    } else {
      name = "";
    }
    if (catigory == "") {
      catigory = "All";
    }
    if (distance == null) {
      distance = 1;
    }
    if (maxPrice == null) {
      maxPrice = 0;
    }
    // form parameters string
    let str =
      "name=" +
      name +
      "&category=" +
      catigory +
      "&travel=" +
      distance +
      "&price=" +
      maxPrice / currency.value +
      "&currency=" +
      currency.value +
      "&currencyLabel=" +
      currency.label;
    return str;
  },

  loadProductCategories: function (component) {
    let loadProductCategoriesAction = component.get("c.getProductCatigories");
    loadProductCategoriesAction.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        component.set("v.category", response.getReturnValue());
      }
    });
    $A.enqueueAction(loadProductCategoriesAction);
  }
});