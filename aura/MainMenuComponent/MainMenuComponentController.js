({
  aboutUsClicked: function(component, event, helper) {
    helper.fireEvent(component, 'isOutletsMapOpenedEvent', 'flag', true);
  },
  compareClicked: function(component, event, helper) {
    helper.fireEvent(component, 'isCompareWindowOpenedEvent', 'flag', true);
  },
  helpClicked: function(component, event, helper) {
    helper.fireEvent(component, 'isCaseModalWindowOpenEvent', 'flag', true);
  },
  downloadPDFClicked : function(component, event, helper) {
    helper.fireEvent(component, 'downloadPDFEvent', 'string', '');
  },
  currencySelected: function(component, event, helper) {
    let value = event.getParam('value');
    helper.fireEvent(component, 'currencyChangedEvent', 'string', value);
  }
});