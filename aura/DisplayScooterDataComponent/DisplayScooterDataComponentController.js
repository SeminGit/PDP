({
    currencyChanged : function(component, event, helper) {
        let price = component.get('v.productPrice'),
        currency = component.get('v.currencyRate').value;
        component.set('v.price',(price/currency).toFixed(2));
    }
})