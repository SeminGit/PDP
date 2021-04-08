({
    closeWindow : function (component,event,helper){
        let windowEvent = component.getEvent('isOrderWindowOpenedEvent');
        windowEvent.setParam('flag',false);
        windowEvent.fire();
    }
})