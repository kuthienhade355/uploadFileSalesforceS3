({
	myAction : function(component, event, helper) {
		
	},
    clickCreateItem : function(component, event, helper){
        var validItem = component.find('itemsform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validItem){
            // Create the new items
            var newItem = component.get("v.newItem");
           	var theItems = component.get("v.items");
            var newItemValue = JSON.parse(JSON.stringify(newItem));
            theItems.push(newItemValue);
            component.set("v.items", theItems);
            helper.createItem(component,newItem); 
            component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                'Name': '',
                'Quantity__c': 0,
                'Price__c': 0,
                'Packed__c': false});
            }
        },
    doInit : function(component, event, helper){
        var action = component.get("c.getItems");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state==='SUCCESS'){
                console.log("this state" +state);
                component.set("v.items",response.getReturnValue());
            }else{
                console.log("Failed this state" + state);
            }
        });
        
        $A.enqueueAction(action);
    },
    handleAddItem: function(component, event, helper) {
    //   var newItem = event.getParam("item");
    //helper.addItem(component, newItem);
    var action = component.get("c.saveItem");
    		action.setParams({"item": newItem});
    		action.setCallback(this, function(response){
        		var state = response.getState();
        		if (component.isValid() && state === "SUCCESS") {
            		// all good, nothing to do.
            var items = component.get("v.items");
            items.push(response.getReturnValue());
            component.set("v.items", items);
        		}
    		});
    		$A.enqueueAction(action);
        		}
})