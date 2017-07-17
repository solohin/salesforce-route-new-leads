({
    saveRule: function(component, event, helper){
        //validate user
        const userSelect = component.find('selectUser');
        if(!userSelect.get('v.value')){
            return userSelect.set('v.errors', [{message: 'Select a user'}]);
        }else{
            userSelect.set('v.errors', null);
        }

        //validate user
        const domainsTextarea = component.find('domains');
        if(!domainsTextarea.get('v.value')){
            return domainsTextarea.set('v.errors', [{message: 'Should be a teast one domain'}]);
        }else{
            domainsTextarea.set('v.errors', null);
        }

        const ruleToSave = component.get('v.rule');
        helper.saveRuleToServer(component, ruleToSave).then(function(savedRule){
            const isInsert = !ruleToSave.Id;
            helper.triggerSaved(component, savedRule, isInsert);
        }).catch(function(e){
            //TODO handle error
            debugger;
            console.error('saveRule error', e);
        });
        
        component.set('v.rule', {'sobjectType':'LeadRoutingRule__c', 'UserId__c': ''});
        component.set('v.showForm', false);
    },
    showForm: function(component, event, helper){
        component.set('v.showForm', true);
    }
});