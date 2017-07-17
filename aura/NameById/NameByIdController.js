({
    doInit: function(component, event, helper){
        const itemsList = component.get('v.itemsList');
        const id = component.get('v.id');
        const nameField = component.get('v.nameField');

        itemsList.map(item=>{
            if(item.Id === id){
                component.set('v.name', item[nameField]);
            }
        })
    }
});