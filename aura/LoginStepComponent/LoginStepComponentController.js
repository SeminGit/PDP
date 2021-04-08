({
  checkInfo: function (component, event, helper) {
    let isValid = helper.checkValidity(component);
    if (isValid) {
      helper.checkInfo(component);
    }
  }
});