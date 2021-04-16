({
  setCustomerInfo: function (component, SObjectName, Id) {
    component.set("v.customerId", Id);
    component.set("v.sObjectName", SObjectName);
  },

  setNewLeadInfo: function(component,email,phone){
    component.set("v.emailAttr", email);
    component.set("v.phoneAttr", phone);
  }
});