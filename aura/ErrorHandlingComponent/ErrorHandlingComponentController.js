({
    closeWindow : function(component, event, helper) {
        component.set('v.isModalWindowOpen',false);
    },
    openModalWindow : function(component, event, helper) {
        component.set('v.isModalWindowOpen',true);
    },
    showComponent : function(component, event, helper) {
        let isVis = event.getParam('arguments').isVisible;
        component.set('v.isComponentActive',isVis);
    },
    closeComponent : function(component,event,helper){
        component.set('v.isComponentActive',false);
    }
})