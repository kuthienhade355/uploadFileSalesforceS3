({ 
    //function init validation
    validation : function(component,event,value,position){
       if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value)||value  == null||value==0 ) {
            position.set("v.errors", null);
            var isErrors = component.get('v.isNotErrors');
            component.set('v.isNotErrors',true);
        } else {
            position.set("v.errors", [{message:"Email must be valid"}]);
            var isErrors = component.get('v.isNotErrors');
            component.set('v.isNotErrors',false);
        } 
    },
    setTimeOut : function(){
        window.setTimeout(
                    $A.getCallback(function() {
                    $A.get('e.force:refreshView').fire();
                        window.setTimeout(
   								 $A.getCallback(function() {
                                 $A.get('e.force:refreshView').fire();
                                  
                              }), 5000
                		);
                   }), 5000
         );
    }
    ,
    openmodal: function(component,event,idRecipients) {
        var getValueRecipient = component.get("c.getRecipients");
        getValueRecipient.setParams({ ids : idRecipients });
        getValueRecipient.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var results = response.getReturnValue();
                component.set("v.to1",results[0].To__c);
                component.set("v.from1",results[0].From__c);
                component.set("v.cc1",results[0].CC__c);
                component.set("v.bcc1",results[0].BCC__c);
                component.set("v.subject1",results[0].Subject__c);
                component.set("v.body1",results[0].Body__c);
                if(results[0].Attachments !=null){
                   component.set("v.attachment1",results[0].Attachments[0].Id);
                   component.set("v.nameAttachment1",results[0].Attachments[0].Name);
                   component.set("v.atlist",results[0].Attachments);
                }else{
                   component.set("v.attachment1",'');
                }
                component.set("v.recipients", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(getValueRecipient);
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
    },
        showFilesReply: function(component,event,idRecipients) {
        var getValueRecipient1 = component.get("c.getFiles1");
        getValueRecipient1.setParams({ ids : idRecipients });
        getValueRecipient1.setCallback(this, function(response1) {
            var state1 = response1.getState();
            var results1 = response1.getReturnValue();
            var getValueRecipient = component.get("c.getFiles");
            getValueRecipient.setParams({ ids : idRecipients });
            getValueRecipient.setCallback(this, function(response) {
                var state = response.getState();
                console.log('state1',state1);
                if (state === "SUCCESS") {
                    var results = response.getReturnValue();
                     console.log('results',results);
                    if(results==''){
                        component.set("v.documentIdReply",'');
                    }
                    if(results == null){
                        component.set("v.isCheckSizeFileReply",true);
                    }else{
                        if(results1.length > results.length){
                           component.set("v.arrFileReply", results);
                           component.set("v.isCheckSizeFileReply",true);
                        }else{
                           component.set("v.arrFileReply", results);
                           component.set("v.isCheckSizeFileReply",false);
                        }
                    }
                }
                else {
                    console.log("Failed with state: " + state);
                }
            });
            $A.enqueueAction(getValueRecipient);
        });
        $A.enqueueAction(getValueRecipient1); 
    },
    
    showFiles: function(component,event,idRecipients) {
        var getValueRecipient1 = component.get("c.getFiles1");
        getValueRecipient1.setParams({ ids : idRecipients });
        getValueRecipient1.setCallback(this, function(response1) {
            var state1 = response1.getState();
            var results1 = response1.getReturnValue();
            var getValueRecipient = component.get("c.getFiles");
            component.set("v.temporaryFile", idRecipients);
            getValueRecipient.setParams({ ids : idRecipients });
            getValueRecipient.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var results = response.getReturnValue();
                    if(results==''){
                        component.set("v.documentId",'');
                    }
                    if(results == null){
                        component.set("v.isCheckSizeFile",true);
                    }else{
                        if(results1.length > results.length){
                           component.set("v.arrFile", results);
                           component.set("v.isCheckSizeFile",true);
                        }else{
                           component.set("v.arrFile", results);
                           component.set("v.isCheckSizeFile",false);
                        }
                    }
                }
                else {
                    console.log("Failed with state: " + state);
                }
            });
            $A.enqueueAction(getValueRecipient);
        });
        $A.enqueueAction(getValueRecipient1); 
    },
    
    showFiles1: function(component,event,idRecipients) {
        var getValueRecipient = component.get("c.getFiles");
        getValueRecipient.setParams({ ids : idRecipients });
        getValueRecipient.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var results = response.getReturnValue();
     			if(results==''){
                    component.set("v.documentId",'');
                }
                if(results == null){
                    component.set("v.isCheckSizeFile",true);
                }else{
                    component.set("v.arrFile", results);
                    component.set("v.isCheckSizeFile",false);
                }
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(getValueRecipient); 
    },
        
    showFiles1Reply: function(component,event,idRecipients) {
        var getValueRecipient = component.get("c.getFiles");
        getValueRecipient.setParams({ ids : idRecipients });
        getValueRecipient.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var results = response.getReturnValue();
     			if(results==''){
                    component.set("v.documentIdReply",'');
                }
                if(results == null){
                    component.set("v.isCheckSizeFileReply",true);
                }else{
                    component.set("v.arrFileReply", results);
                    component.set("v.isCheckSizeFileReply",false);
                }
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(getValueRecipient); 
    },    
    
    getEmails : function(component, helper) {
        var action = component.get("c.getRecipient");
        action.setStorable();
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('state',state);
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.totalPages", Math.ceil(JSON.parse(result).length/component.get("v.pageSize")));
                component.set("v.allData", JSON.parse(result));
                component.set("v.currentPageNumber",1);
                helper.buildData(component, helper);
            }
        });
        var requestInitiatedTime = new Date().getTime();
        $A.enqueueAction(action);
    },
    
    // function will build table data
    // based on current page selection
    buildData : function(component, helper) {
        var data = [];
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var allData = component.get("v.allData");
        var x = (pageNumber-1)*pageSize;
        
        //creating data-table data
        for(; x<=(pageNumber)*pageSize; x++){
            if(allData[x]){
           	   data.push(allData[x]);
            }
       	}	
        component.set("v.data", data);
        helper.generatePageList(component, pageNumber);
    },
    
    /*
     * this function generate page list
     * */
    generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPages");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
        component.set("v.pageList", pageList);
    }
})