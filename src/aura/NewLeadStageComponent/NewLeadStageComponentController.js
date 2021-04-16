({
  doInit: function(component, event, helper) {
    let getDeliveryTypesAction = component.get("c.getDeliveryTypesValues");
    let deliveryTypes = [];
    getDeliveryTypesAction.setCallback(this, function(response) {
      if (response.getState() === "SUCCESS") {
        let answer = response.getReturnValue();
        deliveryTypes.push({ key: "None", value: "None" });
        for (let key in answer) {
          deliveryTypes.push({ key: key, value: answer[key] });
        }
        component.set("v.deliveryTypes", deliveryTypes);
      }
    });
    $A.enqueueAction(getDeliveryTypesAction);
    let deliveryPoints = [];
    let getOutletPointsAction = component.get("c.getRelatedOutlets");
    getOutletPointsAction.setCallback(this, function(response) {
      if (response.getState() === "SUCCESS") {
        let answer = response.getReturnValue();
        deliveryPoints.push({ key: "None", value: "None" });
        for (let key in answer) {
          deliveryPoints.push({ key: key, value: answer[key] });
        }
        component.set("v.outlets", deliveryPoints);
      }
    });
    $A.enqueueAction(getOutletPointsAction);
  },
  newLead: function(component, event, helper) {
    let action = component.get("c.createNewLead"),
      firstName = component.get("v.firstName"),
      lastName = component.get("v.lastName"),
      email = component.get("v.emailAttr"),
      phone = component.get("v.phoneAttr");
    action.setParams({
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phone
    });
    action.setCallback(this, function(response) {
      let responseState = response.getState();
      if (responseState === "SUCCESS") {
        let answer = response.getReturnValue();
        alert("answer:" + answer);
        let foundEvent = component.getEvent("foundCustomerEvent");
        foundEvent.setParams({
          SObjectName: "Lead",
          Id: answer
        });
        foundEvent.fire();
      } else {
        alert("fail");
      }
    });
    $A.enqueueAction(action);
  },
  setAddress: function(component, event, helper) {
    component.set(
      "v.streetAttr",
      component.find("addressFields").get("v.street")
    );
    component.set("v.cityAttr", component.find("addressFields").get("v.city"));
  },
  onOutletFieldChanged: function(component, event, helper) {
    let selectedOutlet = component.find("outletField").get("v.value");
    component.set("v.selectedOutlet", selectedOutlet);
  },
  onDeliveryTypesChanged: function(component, event, helper) {
    let selectedDeliveryType = component
      .find("deliveryTypeChoise")
      .get("v.value");
    component.set("v.streetAttr", "");
    component.set("v.selectedOutlet", "");
    component.set("v.cityAttr", "");
    component.set("v.postCodeAttr", "");
    component.set("v.selectedDeliveryType", selectedDeliveryType);
  },
  orderProductsMethod: function(component, event, helper) {
    let product = component.get("v.product"),
      contactType = component.get("v.SObjectName"),
      contactId = component.get("v.Id"),
      price = component.get("v.productPrice"),
      deliveryType = component.get("v.selectedDeliveryType");

    if (deliveryType == "Pickup") {
      let outlet = component.get("v.selectedOutlet");
      let action = component.get("c.orderProductsPickup");
      action.setParams({
        Id: contactId,
        Type: contactType,
        product: product,
        price: price,
        deliveryType: deliveryType,
        outletId: outlet
      });
      action.setCallback(this, function(response) {
        if (response.getState() === "SUCCESS") {
          alert("well done");
        } else {
          let errorHandler = component.find("errorHandler");
          errorHandler.setVisible(true);
        }
      });
      $A.enqueueAction(action);
    } else if (deliveryType == "Courier") {
      let city = component.get("v.cityAttr");
      let street = component.get("v.streerAttr");
      let country = component.find("addressFields").get("v.country");
      let action = component.get("c.orderProductsCourier");
      action.setParams({
        Id: contactId,
        Type: contactType,
        product: product,
        price: price,
        deliveryType: deliveryType,
        street: street,
        city: city,
        country: country
      });
      action.setCallback(this, function(response) {
        if (response.getState() === "SUCCESS") {
          alert("well done");
        } else {
          let errorHandler = component.find("errorHandler");
          errorHandler.setVisible(true);
        }
      });
      $A.enqueueAction(action);
    } else if (deliveryType == "Post") {
      let postCode = component.get("v.postCodeAttr");
      let action = component.get("c.orderProductsPost");
      action.setParams({
        Id: contactId,
        Type: contactType,
        product: product,
        price: price,
        deliveryType: deliveryType,
        postCode: postCode
      });
      action.setCallback(this, function(response) {
        if (response.getState() === "SUCCESS") {
          alert("well done");
        } else {
          let errorHandler = component.find("errorHandler");
          errorHandler.setVisible(true);
        }
      });
      $A.enqueueAction(action);
    }
    let windowEvent = component.getEvent("isOrderWindowOpenedEvent");
    windowEvent.setParam("flag", false);
    windowEvent.fire();
  }
});