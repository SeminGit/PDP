({
  doInit: function (component, event, helper) {
    helper.loadDeliveryTypes(component);
    helper.loadOutletPoints(component);
  },

  setAddress: function (component, event, helper) {
    component.set(
      "v.streetAttr",
      component.find("addressFields").get("v.street")
    );
    component.set("v.cityAttr", component.find("addressFields").get("v.city"));
  },

  onOutletFieldChanged: function (component, event, helper) {
    let selectedOutlet = component.find("outletField").get("v.value");
    component.set("v.selectedOutlet", selectedOutlet);
  },

  mapMarkerSelected: function (component, event, helper) {
    let selectedOutlet = event.getParam("outlet");
    component.set("v.selectedOutlet", selectedOutlet.Id);
  },

  onDeliveryTypesChanged: function (component, event, helper) {
    let selectedDeliveryType = component.find("deliveryTypeChoise").get("v.value");
    component.set("v.selectedDeliveryType", selectedDeliveryType);
  },

  order: function (component, event, helper) {
    let SObject = component.get("v.SObjectName");
    if (SObject) {
      helper.orderProduct(component);
    } else {
      helper.createNewLead(component);
    }
  }
});