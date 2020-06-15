({
	createItem : function(component,newItem) {
        var action = component.get("c.saveItem");
        action.setParams({
            "item":newItem
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var newItem =  component.get("v.items");
                newItem.push(response.getReturnVaulue());
                component.set("v.items",newItem);
            }
        });
        $A.enqueueAction(action);
	},
    
})