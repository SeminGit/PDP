({
  sendCurrency: function (component, currencyLabel) {
    let sendCurrencyEvent = component.getEvent("currencyChangedEvent"),
      currencies = component.get("v.currencies"),
      currencyToSend = new Object();
    currencyToSend.label = currencyLabel;
    currencyToSend.value = currencies[currencyLabel];
    sendCurrencyEvent.setParam("currencyObj", currencyToSend);
    sendCurrencyEvent.fire();
  },

  loadCurrencies: function (component) {
    let loadCurrenciesAction = component.get("c.getCurrencies");
    loadCurrenciesAction.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let answer = response.getReturnValue(),
            currencyLabels = [];
        component.set("v.currencies", answer);
        for (let key in answer) {
          currencyLabels.push(key);
        }
        component.set("v.currencyLabels", currencyLabels);
        this.sendCurrency(component, currencyLabels[0]);
      } else if (state === "ERROR" || state === "INCOMPLETE") {
        let errors = response.getError();
        if (errors) {
          if (errors[0] && errors[0].message) {
            console.log("Error message: " + errors[0].message);
          }
        } else {
          console.log("Unknown error");
        }
      }
    });
    $A.enqueueAction(loadCurrenciesAction);
  }
});