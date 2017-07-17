({
    onRoutingItemUpdated: function (component, event, helper) {
        const routingItem = event.getParam('item');
        let rules = component.get('v.rules');
        const isInsert = event.getParam('isInsert');
        const ruleFromEvent = event.getParam('rule');

        if (isInsert) {
            rules.push(ruleFromEvent);
        } else {
            rules = rules.map(function (rule) {
                if (rule.Id === ruleFromEvent.Id) {
                    return ruleFromEvent;
                } else {
                    return rule;
                }
            });
        }

        component.set('v.rules', rules);
    },
    editRule: function (component, event, helper) {
        const ruleId = event.getSource().get('v.value');
        const rules = component.get('v.rules');
        const rule = rules.reduce(function (result, value) {
            if (value.Id === ruleId) {
                return value;
            }
            return result;
        }, null);
        component.set('v.rule', rule);
        component.set('v.showForm', true);
    },

    removeRule: function (component, event, helper) {
        if(!confirm('A you sure?')){
            return; //TODO replace with lightning component
        }

        const ruleId = event.getSource().get('v.value');
        helper.removeRule(component, ruleId).then(function () {
            let rules = component.get('v.rules');
            rules = rules.filter(function (value) {
                return value.Id !== ruleId;
            });
            component.set('v.rules', rules);
        }).catch(function (e) {
            //TODO handle error
            console.error('removeRule error', e);
        });
    },

    doInit: function (component, event, helper) {
        helper.getRulesFromServer(component).then(function (rules) {
            component.set('v.rules', rules);
        }).catch(function (e) {
            //TODO handle error
            console.error('getRulesFromServer error', e);
        });

        //storable, so no promises
        helper.getUsersList(component, function (err, usersList) {
            if (err) {
                //TODO handle error
                console.error('getUsersList error', e);
                return;
            }

            component.set('v.usersList', usersList);
        })
    }
});