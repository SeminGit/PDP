({
  doInit: function (component, event, helper) {
    helper.loadMapMarkers(component);
  },
  
  handleMarkerSelect: function (component, event, helper) {
    let outletId = event.getParam("selectedMarkerValue"),
        outletToSend = helper.findOutletById(component, outletId);
    helper.sendOutlet(component, outletToSend);
  }
});