({
  doInit: function (component, event, helper) {
    let action = component.get("c.getOutlets");
    let markers = [];
    action.setCallback(this, function (response) {
      let answer = response.getReturnValue();
      alert(answer);
      for (let i = 0; i < answer.length; i++) {
        let outlet = answer[i];
        markers.push({
          location: {
            Latitude: outlet.Location__Latitude__s,
            Longitude: outlet.Location__Longitude__s
          },
          title: outlet.Name,
          icon: "standart:account"
        });
      }
      component.set("v.mapMarkers", markers);
    });
    $A.enqueueAction(action);
  }
});