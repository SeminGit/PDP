({
  doInit: function (component, event, helper) {
    helper.loadCurrencies(component);
  },

  currencySelected: function (component, event, helper) {
    let currencyLabel = event.getParam("value");
    helper.sendCurrency(component, currencyLabel);
  }
});