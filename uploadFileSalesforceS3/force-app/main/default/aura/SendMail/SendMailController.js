({ 
     //handle request data init
     doInit : function(cmp,event,helper){
            console.log('cmp',cmp);
            var actions = [
                { label: 'Show details', name: 'show_details' },
                { label: 'Delete', name: 'delete' }
            ];
            cmp.set('v.columns', [
                {label: 'Type', fieldName: 'isReceiveMail', type: 'text'},
                {label: 'To', fieldName: 'toEmail', type: 'email'},
                {label: 'From', fieldName: 'fromEmail', type: 'email'},
                {label: 'Subject', fieldName: 'subject', type: 'text',typeAttributes: {tooltip: {fieldName: 'subject'}}, editable: true},
                {label: 'ViewPopup', type: 'button', initialWidth: 135, typeAttributes: { label: 'Details', name: 'view_details', title: 'Click to View Details'}},
                {label: '', type: 'action', initialWidth: 135, typeAttributes: {rowActions:actions}}
            ]);
             helper.getEmails(cmp, helper);
            
        },
    
    //handle send reply email  
    handleReply: function (component,event,helper){
        var answer = confirm('Are you sure you want send email');
        if(answer){
           var to = component.find('inputToReply');
        if(to){
            to = component.find('inputToReply').get('v.value');
        }else{
            to = component.find('inputFromReply').get('v.value');
        }
        var subject = component.find('inputSubjectReply').get('v.value');
        var body = component.find('inputBodyReply').get('v.value');
        var attachments = component.get("v.files");
        var action = component.get("c.sendMail");
        //set params for apex class
       	action.setParams({
            "Email" : to,
            "Subject" : subject,
            "Body" : body,
            "attach" : attachments 
        });
        
        action.setCallback(this, function (response) {
                    var state = response.getState();
                    var result = response.getReturnValue();
                    if (state === "SUCCESS") {
                        console.log('result', response.getReturnValue());
                        if(result === null){
                            response.sendMail;
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Success!",
                                "message": "Send mail successfully.",
                                "type": "success"
                            });
                            toastEvent.fire();
                        }else{
                             var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Bad!",
                                "message": result,
                                "type" : "error"
                            });
                            toastEvent.fire();
                        }
                    }else if(state === "ERROR"){
                        var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Bad!",
                                "message": "Send mail errors.",
                                "type" : "error"
                            });
                            toastEvent.fire();
                    }
                });
                $A.enqueueAction(action);
                helper.setTimeOut(); 
        }
    },
    
    //handle send email and validation input
    handleClick: function (component, event,helper) {
       var to = component.find("inputTo");
       var cc = component.find("inputCC");
       var bcc = component.find("inputBBC");
       var subject = component.find("inputSubject");
       var body = component.find("inputBody");
       var valueTo = to.get("v.value");
       var valueCC = cc.get("v.value");
       var valueBCC = bcc.get("v.value");
       var valueSubject = subject.get("v.value");
       var valueBody = body.get("v.value");
        
        
        if(valueBody){
            component.set("v.validity", true);
        }else{
            component.set("v.validity", false);
        }
        helper.validation(component,event,valueCC,cc);
        helper.validation(component,event,valueBCC,bcc);
      	if (valueSubject) {
            subject.set("v.errors", null);
            var isErrors = component.get('v.isNotErrors');
            component.set('v.isNotErrors',true);
        } else {
            subject.set("v.errors", [{message:"Not empty value "}]);
            var isErrors = component.get('v.isNotErrors');
            component.set('v.isNotErrors',false);
        }
        
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(valueTo)) {
           to.set("v.errors", null);
            var isErrors = component.get('v.isNotErrors');
            //Review fields
            component.set('v.isNotErrors',true);
        } else {
            to.set("v.errors", [{message:"Email must be valid OR Not empty value"}]);
            var isErrors = component.get('v.isNotErrors');
            component.set('v.isNotErrors',false);
        }
        
        //Handle send mail
        if(isErrors && component.get("v.validity")){
            var answer = confirm('Are you sure you want send email');
            if(answer){
                component.set("v.message", valueTo);
                var attachments = component.get("v.files");
                var action = component.get("c.sendMail");
                action.setParams({
                    "Email" : valueTo,
                    "Cc1" : valueCC,
                    "Bcc1" : valueBCC,
                    "Subject" : valueSubject,
                    "Body" : valueBody,
                    "attach" : attachments
                });
                
                action.setCallback(this, function (response) {
                    var state = response.getState();
                    var result = response.getReturnValue();
                    if (state === "SUCCESS") {
                        console.log('result', response.getReturnValue());
                        if(result === null){
                            response.sendMail;
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Success!",
                                "message": "Send mail successfully.",
                                "type" : "success"
                            });
                            toastEvent.fire();
                        }else{
                             var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Bad!",
                                "message": result,
                                "type" : "error"
                            });
                            toastEvent.fire();
                        }
                          
                    }else if(state === "ERROR"){
                        console.log('result',result);
                        var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Bad!",
                                "message": result,
                                "type" : "error"
                            });
                            toastEvent.fire();
                    }
                });
                $A.enqueueAction(action);
                helper.setTimeOut();    	
            }
        }else{
             var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": "Input invalid.",
                        "type" : "warning"
                    });
            toastEvent.fire();
        }
    },
    //handle show erros
    handleError: function(component, event){
        /* do any custom error handling
         * logic desired here */
        // get v.errors, which is an Object[]
        var errorsArr  = event.getParam("errors");
        if(errorsArr.length == 1){
            component.set('v.isNotErrors',false);
        }
    },
    
	
    handleClearError: function(component, event) {
        /* do any custom error handling
         * logic desired here */
    
    },
    
    handleUploadFinishedReply: function (cmp, event,helper) {
        var answer = confirm('Are you sure you want update file ?');
        if(answer){
        var uploadedFiles = cmp.get("v.files");
        var singleFile  = event.getParam("files");
        var documentId = singleFile [0].documentId;
        for(var i = 0; i < singleFile.length; i++){
            uploadedFiles.push(JSON.stringify(singleFile[i].documentId));
        }
        cmp.set("v.documentIdReply",documentId);
        helper.showFilesReply(cmp,event,uploadedFiles);
        cmp.set("v.files", uploadedFiles);
        }else{
         var uploadedFiles = cmp.get("v.files");
         var singleFile  = event.getParam("files");
         var documentId = singleFile [0].documentId;
         var fileName = singleFile [0].name;
         for(var i = 0; i < singleFile.length; i++){
              uploadedFiles.push(JSON.stringify(singleFile[i].documentId));
         }
             var deleteFiles = cmp.get("c.deleteFiles");
             deleteFiles.setParams({ ids : uploadedFiles});
             $A.enqueueAction(deleteFiles);
         }
    },
    
    
    handleUploadFinished: function (cmp, event,helper) {
        	var answer = confirm('Are you sure you want update file ?');
            if(answer){
                var uploadedFiles = cmp.get("v.files");
                var singleFile  = event.getParam("files");
                var documentId = singleFile [0].documentId;
                var fileName = singleFile [0].name;
                for(var i = 0; i < singleFile.length; i++){
                    uploadedFiles.push(JSON.stringify(singleFile[i].documentId));
                }
                cmp.set("v.documentId",documentId);
                helper.showFiles(cmp,event,uploadedFiles);
                cmp.set("v.files", uploadedFiles);
            }else{
                var uploadedFiles = cmp.get("v.files");
                var singleFile  = event.getParam("files");
                var documentId = singleFile [0].documentId;
                var fileName = singleFile [0].name;
                for(var i = 0; i < singleFile.length; i++){
                    uploadedFiles.push(JSON.stringify(singleFile[i].documentId));
                }
                var fileUploadIds = cmp.get("v.temporaryFile")
                var deleteFiles = cmp.get("c.deleteFiles");
                deleteFiles.setParams({ ids : uploadedFiles,fileUploads:fileUploadIds});
                $A.enqueueAction(deleteFiles);
            }
    },
    
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'show_details':
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": row.id,
                    "slideDevName": "detail"
                });
                navEvt.fire();
                break;
            case 'delete':
                var answer = confirm('Are you sure you want delete email ?');
            	if(answer){
                var rows = cmp.get('v.data');
                var rowIndex = rows.indexOf(row);
                var deleteAct = cmp.get("c.deleteRecipient");
                deleteAct.setParams({ ids : rows[rowIndex].id });
                deleteAct.setCallback(this, function (response) {
                	var state = response.getState();
                    if(state ==='SUCCESS'){
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Success!",
                            "message": "The record has been delete successfully.",
                            "type" : "success"
                        });
                        toastEvent.fire();
                        //rows.splice(rowIndex, 1);
                        //cmp.set('v.data', rows);
                    }
                });
                $A.enqueueAction(deleteAct);
                helper.setTimeOut();
                }
                break;
           
               	case 'view_details':
        		cmp.set("v.rowId",row.id); 
                var rows = cmp.get('v.data');
                var rowIndex = rows.indexOf(row);
                var idRecipients = rows[rowIndex].id;
                helper.openmodal(cmp,event,idRecipients);
                break;
        }
    },

    deleteFile: function (cmp, event, helper) {
       var answer = confirm('Are you sure you want delete file');
       if(answer){
           var idx = event.target.id;
           var deleteAct1 = cmp.get("c.deleteFilesContentDocument");
           deleteAct1.setParams({ ids : idx });
           $A.enqueueAction(deleteAct1);
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
              "title": "Success!",
              "message": "A File has been delete successfully.",
              "type" : "success"
           });
           toastEvent.fire();
           var uploadedFiles = cmp.get("v.files");
           helper.showFiles1(cmp,event,uploadedFiles);
        }
         
    },	
    
    deleteFileReply: function (cmp, event, helper) {
       var answer = confirm('Are you sure you want delete file ?');
       if(answer){
           var idx = event.target.id;
           var deleteAct1 = cmp.get("c.deleteFilesContentDocument");
           deleteAct1.setParams({ ids : idx });
           $A.enqueueAction(deleteAct1);
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
              "title": "Success!",
              "message": "A File has been delete successfully.",
              "type" : "success"
           });
           toastEvent.fire();
           var uploadedFiles = cmp.get("v.files");
           helper.showFiles1Reply(cmp,event,uploadedFiles);
        }
         
    },	
    
    closeModal:function(component,event){    
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        var uploadedFiles = component.get("v.files");
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
        var elements = document.getElementsByClassName("myTest");
        elements[0].style.display = 'none';
        component.set("v.truthy", false);
       	var deleteFiles = component.get("c.deleteFilesContentDocuments");
        deleteFiles.setParams({ ids : uploadedFiles });
        $A.enqueueAction(deleteFiles); 
    },
    
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber+1);
        helper.buildData(component, helper);
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.buildData(component, helper);
    },
    
    processMe : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.buildData(component, helper);
    },
    
    onFirst : function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.buildData(component, helper);
    },
    
    onLast : function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.buildData(component, helper);
    },
    
    hide : function(component,event,helper){
        var elements = document.getElementsByClassName("myTest");
        var uploadedFiles = component.get("v.files");
        elements[0].style.display = 'none';
        component.set("v.truthy", false);
        var deleteFiles = component.get("c.deleteFilesContentDocuments");
        deleteFiles.setParams({ ids : uploadedFiles });
        $A.enqueueAction(deleteFiles); 
    },
    
    show : function(component,event,helper){
        var uploadedFiles = component.get("v.files");
        if(uploadedFiles){
           helper.showFiles1Reply(component,event,uploadedFiles);
        }
        var elements = document.getElementsByClassName("myTest");
        elements[0].style.display = 'block';
        component.set("v.truthy", true);
    },
    
    getClassName : function(component,event,helper){
        var api = component.get('c.callApiClass');
        api.setParams({nameClass : 'sendEmailLCCC'});
        api.setCallback(this, function (response) {
            var state = response.getReturnValue();
            console.log('state',state);
        })
        $A.enqueueAction(api); 
    },
    
    
    searchAsset : function(component,event){
        var radioGrpValue = component.get("v.value");
        if(radioGrpValue == 'option1'){
            var assetID = component.find('inputAssetID').get('v.value');
            var name = component.find('inputName').get('v.value'); 
            var api = component.get('c.searchIncident');
            api.setParams({idIncidents : 'a1B6F000009xpuuUAA',
                           nameAssert :name,
                           idAssert :assetID});
            api.setCallback(this, function (response) {
                var state = response.getState();
                if(state ==='SUCCESS'){
                   var results = response.getReturnValue();
                	if(results == null){
                    	component.set("v.data1", '');
                    }else{
                        component.set("v.data1", results);
                    }
                }
            })
            
            $A.enqueueAction(api); 
            
        }else{
            var assetID = component.find('inputAssetID').get('v.value');
            var name = component.find('inputName').get('v.value'); 
            var api = component.get('c.searchAssetID');
            api.setParams({idAssert : 'a1C6F00000Si5EXUAZ',
                           nameIncident :name,
                           idIncident :assetID});
            api.setCallback(this, function (response) {
                var state = response.getState();
                if(state ==='SUCCESS'){
                   var results = response.getReturnValue();
                    console.log('results',results)
                	if(results == null){
                    	component.set("v.data1", '');
                    }else{
                        component.set("v.data1", results);
                    }
                }
            })
            $A.enqueueAction(api); 
        }
        
    },
    handleChange : function(component, event, helper) {
    var radioGrpValue = component.get("v.value");
    	console.log('radioGrpValue',radioGrpValue);
	},
    
    selectoptionvalue: function(component, event, helper) {
        var selected = [], checkboxes = component.find("checkbox");
        if(!checkboxes) {   // Find returns zero values when there no items
            checkboxes = [];
        } else if(!checkboxes.length) { // Find returns a normal object with one item
            checkboxes = [checkboxes];
        }
        checkboxes
        .filter(checkbox => checkbox.get("v.value"))    // Get only checked boxes
        .forEach(checkbox => selected.push(checkbox.get("v.label")));   // And get the labels
        component.set("v.selectedCities", selected);    // Set to display
    },
    
    searchAll : function(cpm,event){
        var mailSubject = cpm.find('inputMailSubject').get('v.value');
        var resultSearch = cpm.get('v.selectedCities');
        console.log('selectedRows' ,resultSearch);
        console.log('mailSubject' ,mailSubject);
    }
    
})