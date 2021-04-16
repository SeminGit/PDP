({
  orderProduct: function (component) {
    let product = component.get("v.product"),
        contactType = component.get("v.SObjectName"),
        contactId = component.get("v.Id"),
        price = component.get("v.productPrice"),
        deliveryType = component.get("v.selectedDeliveryType");
    component.set("v.isSpinnerActive", true);
    if (deliveryType == "Pickup") {
      let outlet = component.get("v.selectedOutlet"),
          action = component.get("c.orderProductsPickup");
      action.setParams({
        Id: contactId,
        Type: contactType,
        product: product,
        price: price,
        deliveryType: deliveryType,
        outletId: outlet
      });
      action.setCallback(this, function (response) {
        component.set("v.isSpinnerActive", false);
        if (response.getState() === "SUCCESS") {
          let nextStepEvent = component.getEvent("changeStepEvent");
          console.log("nextStepEvent:" + nextStepEvent);
          nextStepEvent.setParam("string", "orderRecieved");
          nextStepEvent.fire();
        } else {
          let errorHandler = component.find("errorHandler");
          errorHandler.setVisible(true);
        }
      });
      $A.enqueueAction(action);
    } else if (deliveryType == "Courier") {
      let city = component.get("v.cityAttr"),
          street = component.get("v.streetAttr"),
          country = component.find("addressFields").get("v.country"),
          action = component.get("c.orderProductsCourier");
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
      action.setCallback(this, function (response) {
        component.set("v.isSpinnerActive", false);
        if (response.getState() === "SUCCESS") {
          let nextStepEvent = component.getEvent("changeStepEvent");
          console.log("nextStepEvent:" + nextStepEvent);
          nextStepEvent.setParam("string", "orderRecieved");
          nextStepEvent.fire();
        } else {
          let errorHandler = component.find("errorHandler");
          errorHandler.setVisible(true);
        }
      });
      $A.enqueueAction(action);
    } else if (deliveryType == "Post") {
      let postCode = component.get("v.postCodeAttr"),
          action = component.get("c.orderProductsPost");
      action.setParams({
        Id: contactId,
        Type: contactType,
        product: product,
        price: price,
        deliveryType: deliveryType,
        postCode: postCode
      });
      action.setCallback(this, function (response) {
        component.set("v.isSpinnerActive", false);
        if (response.getState() === "SUCCESS") {
          let nextStepEvent = component.getEvent("changeStepEvent");
          console.log("nextStepEvent:" + nextStepEvent);
          nextStepEvent.setParam("string", "orderRecieved");
          nextStepEvent.fire();
        } else {
          let errorHandler = component.find("errorHandler");
          errorHandler.setVisible(true);
        }
      });
      $A.enqueueAction(action);
    }
  },

  loadDeliveryTypes: function (component) {
    let getDeliveryTypesAction = component.get("c.getDeliveryTypesValues"),
        deliveryTypes = [];
    getDeliveryTypesAction.setCallback(this, function (response) {
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
  },

  loadOutletPoints: function (component) {
    let deliveryPoints = [],
        getOutletPointsAction = component.get("c.getRelatedOutlets");
    getOutletPointsAction.setCallback(this, function (response) {
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

  createNewLead: function (component) {
    let firstName = component.get("v.firstNameAttr"),
      lastName = component.get("v.lastNameAttr"),
      email = component.get("v.emailAttr"),
      phone = component.get("v.phoneAttr");
    let createLeadAction = component.get("c.addNewLead");
    createLeadAction.setParams({
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone
    });
    createLeadAction.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let answer = response.getReturnValue();
        component.set("v.SObjectName", "Lead");
        component.set("v.Id", answer);
        this.orderProductsMethod(component);
      } else {
        component.set("v.isSpinnerActive", false);
        let errorHandler = component.find("errorHandler");
        errorHandler.setVisible(true);
      }
    });
    $A.enqueueAction(createLeadAction);
  },
});