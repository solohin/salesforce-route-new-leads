//noinspection BadExpressionStatementJS
({
	triggerSaved : function(component, rule, isInsert) {
		const event = component.getEvent('itemUpdate');
        event.setParams({rule:rule, isInsert:isInsert});
        event.fire();
	},
    saveRuleToServer: function(component, ruleItem) {
        return new Promise(function(resolve, reject){
            const action = component.get('c.updateRule');
            action.setParams({rule: ruleItem});
            action.setCallback(this, function(response){
                const state = response.getState();
                if(state === 'SUCCESS'){
                    console.log('saveRuleToServer done');
                    resolve(response.getReturnValue());
                }else{
                    if(response.getError()[0]){
                        reject(response.getError()[0]);
                    }else{
                        reject(state);
                    }
                }
            });
            console.log('c.updateRule called with params', JSON.stringify(action.getParams(), null, 2));
            $A.enqueueAction(action);
        });
    }
})