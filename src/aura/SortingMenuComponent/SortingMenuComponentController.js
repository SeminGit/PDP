({
  init: function(component, event, helper) {
    helper.loadProductCategories(component);
  },

  sort: function(component, event, helper) {
    helper.fireFilterEvent(component, 'filtersApplyed');
  },

  openPDF: function(component, event, helper) {
    window.open(
      '/apex/PDFPageToDownload?' +
        helper.formParametersString(component)
    );
  },

  getFilterForTurnPage: function(component, event, helper) {
    helper.fireFilterEvent(component,'getFiltersEvent');
  }
});