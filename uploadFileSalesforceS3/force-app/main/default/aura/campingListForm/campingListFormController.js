({
	myAction : function(component, event, helper) {
		
	},
    clickCreateItem : function(component, event, helper){
        var validItem = component.find('itemsform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validItem){
            var newItem = component.get("v.newItem");
            helper.createItem(component,newItem);
        }
    }
})