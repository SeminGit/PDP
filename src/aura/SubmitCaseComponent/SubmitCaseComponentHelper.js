({
    submitCase : function(component) {
        component.set('v.isSpinnerActive',true);
        const email = component.get('v.email'),
              subject = component.get('v.subject'),
              description = component.get('v.body'),
              action = component.get('c.submitCase');
        action.setParams({
          email: email,
          subject: subject,
          description: description
        });
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state === 'SUCCESS'){
                // вынести в helper
                let successEvent = component.getEvent('sendCaseState');
                successEvent.setParam('string','success');
                successEvent.fire();
            }else{
                let successEvent = component.getEvent('sendCaseState');
                successEvent.setParam('string','fail');
                successEvent.fire();
            }
            component.set('v.isSpinnerActive',false);
        })
        $A.enqueueAction(action);
    }
})