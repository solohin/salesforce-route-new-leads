({
    removeRule: function (component, ruleId) {
        console.log('helper: removeRule started for ruleId = ', ruleId);
        const action = component.get("c.ruleRemove");
        action.setParams({ruleId: ruleId});

        return new Promise(function (resolve, reject) {
            console.log('c.ruleRemove called with params', JSON.stringify(action.getParams(), null, 2));

            action.setCallback(this, function (response) {
                const state = response.getState();
                if (state === "SUCCESS") {
                    const usersList = response.getReturnValue();
                    resolve(usersList);
                } else {
                    if (response.getError()[0]) {
                        reject(response.getError()[0]);
                    } else {
                        reject(state);
                    }
                }
            });

            $A.enqueueAction(action);
        });
    },

    getUsersList: function (component, callback) {
        const action = component.get("c.getAllSalesPersons");

        action.setCallback(this, function (response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const usersList = response.getReturnValue();
                callback(null, usersList);
            } else {
                if (response.getError()[0]) {
                    callback(response.getError()[0]);
                } else {
                    callback(state);
                }
            }
        });
        $A.enqueueAction(action);
    },
    getRulesFromServer: function (component) {
        const action = component.get('c.getRulesList');

        return new Promise(function (resolve, reject) {
            action.setCallback(this, function (response) {
                const state = response.getState();
                if (state === "SUCCESS") {
                    const itemsList = response.getReturnValue();
                    resolve(itemsList);
                } else {
                    if (response.getError()[0]) {
                        reject(response.getError()[0]);
                    } else {
                        reject(state);
                    }
                }
            });

            $A.enqueueAction(action);
        })
    }
});