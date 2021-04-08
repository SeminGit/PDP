({
  init: function(component, event, helper) {
    helper.loadPageSizes(component);
    helper.getProducts(component, 1, component.get('v.pageSize'), null, null);
  },

  showProducts: function(component, event, helper) {
      let page = component.get('v.page'),
      filters = event.getParam('arguments').filters,
      operators = event.getParam('arguments').operators,
      limits = component.get('v.pageSize');
    helper.getProducts(component, page, limits, filters, operators);
  },

  showSortedProducts: function(component, event, helper) {
      let filters = event.getParam('arguments').filters,
          operators = event.getParam('arguments').operators,
          limits = component.get('v.pageSize');
    helper.getProducts(component, 1, limits, filters, operators);
  },

  changePage: function(component, event, helper) {
    let source = event.getSource().get('v.title'),
        page = component.get('v.page');
    switch (source) {
      case 'Next':
        page += 1;
        break;
      case 'Previous':
        page -= 1;
        break;
      case 'First':
        page = 1;
        break;
      case 'Last':
        page = component.get('v.pagesAmount');
        break;
    }
    component.set('v.page',page);
    helper.firePageTurnedEvent(component, page);
  },
  
  pageSizeChanged: function(component, event, helper) {
	let size = component.find('pageSizeField').get('v.value');
      if(size == 8){
          component.set('v.pageSize',6);
      }else{
    	component.set('v.pageSize',size);
      }
    helper.firePageTurnedEvent(component, 1);
  }
});