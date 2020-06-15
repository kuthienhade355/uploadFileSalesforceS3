public  class sendEmailLCCC {
    @AuraEnabled
    public static String sendMail(String Email,String Cc1,String Bcc1,String Subject,String Body,List<String> attach){
        try{
        String[] bcc = new String[]{Bcc1};
        String[] cc = new String[]{Cc1};
        String[] email1 = new String[] {Email};
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        if(!String.isEmpty(Cc1)){
           message.setCcAddresses(cc);
        }
        if(!String.isEmpty(Bcc1)){
           message.setBccAddresses(bcc);
        }
        message.toAddresses = new String[] { Email };
        message.optOutPolicy = 'FILTER';
        message.subject = Subject;
        message.setHTMLBody(Body);
        ApprovalRegister__c temp = [SELECT Id FROM ApprovalRegister__c LIMIT 1];
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        if(!attach.isEmpty()){
            List<String> abc1 = new List<String>();
            for(String a : attach){
                abc1.add(a.replace('"', ''));
            }
  			system.debug('abc1'+abc1);
        	Set<Id> abc = new Set<Id>();
            for(String a : attach){
                abc.add(Id.valueOf(a.replace('"', '')));
            }
        	List<ContentDocumentLink> cdl = [SELECT ContentDocumentID, LinkedEntity.type, LinkedEntityId 
                                    FROM ContentDocumentLink 
                                    WHERE ContentDocumentID IN:abc];
        	Set<Id> ids = new Set<Id>();
            for(ContentDocumentLink cd : cdl){
                ids.add(cd.ContentDocumentID);
           	}
            
           	ContentVersion[] contentVersions = [SELECT title, 
													PathOnClient, FileType,
													versiondata 
											  FROM contentversion 
											  WHERE ContentDocumentId IN : ids 
											   ];
			for ( ContentVersion cversion : contentVersions)
			 {
			  //blob WOCFbody = cversion.versiondata;
			  Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
			  efa.setFileName(cversion.PathOnClient);
			  efa.setBody(cversion.versiondata);
			  fileAttachments.add(efa); 
            }
            message.setFileAttachments(fileAttachments);
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                system.debug('message'+message);
                 Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
            Recipient__c recipent = new Recipient__c(To__c=Email,From__c='torres851995@gmail.com',Subject__c= Subject,Body__c=Body,Attachments__c=abc1[0],isReceiveMail__c=false);
            insert recipent;
            List<Attachment> attachments = new List<Attachment>();
                for (ContentVersion cversion : contentVersions) {
                      Attachment attachment = new Attachment();
                      attachment.Name = cversion.PathOnClient;
                      attachment.Body = cversion.versiondata;
                      attachment.ParentId = recipent.Id;
                      attachments.add(attachment);
           	    }
                if(attachments.size() > 0)
                  {
                    insert attachments;
                  }
                System.debug('The email failed to send: '
                      + results[0].errors[0].message);
                return null;
            } else {
                System.debug('The email failed to send: '
                      + results[0].errors[0].message);
                return results[0].errors[0].message;
            }
        }else{
              Messaging.SingleEmailMessage[] messages = 
            	new List<Messaging.SingleEmailMessage> {message};
                system.debug('message'+message);
                 Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
            System.debug('The email was sent successfully.');
            Recipient__c recipent = new Recipient__c(To__c=Email,From__c='torres851995@gmail.com',Subject__c= Subject,Body__c=Body,isReceiveMail__c=false);
            insert recipent;
                System.debug('The email failed to send: '
                      + results[0].errors[0].message);
                return null;
            } else {
                System.debug('The email failed to send: '
                      + results[0].errors[0].message);
                return results[0].errors[0].message;
            }
        }   
        }catch(System.EmailException ex){
            String results = ex.getMessage();
            system.debug('results'+results);
            return results;
        }
       
    }
    
    @AuraEnabled
    public static String getRecipient(){
        return WrapperEmailDetail.getValues();
    }
    
    
    @AuraEnabled
    public static String deleteRecipient(String ids){
        System.debug('ids 12346'+ids);
        delete [SELECT id FROM Recipient__c Where id=:ids];
        return null;
    }
    
    @AuraEnabled
    public static List<Recipient__c> getRecipients(String ids){
        System.debug('ids'+ids);
       	return [SELECT To__c,CC__c,BCC__c,Body__c,Subject__c,From__c,(select id,Name from attachments)  FROM Recipient__c WHERE id=:ids ];
    }
	    
    @AuraEnabled
    public static List<ContentVersion> getFiles(List<String> ids){
        Set<Id> abc = new Set<Id>();
        for(String a : ids){
            abc.add(Id.valueOf(a.replace('"', '')));
        }
        List<ContentVersion> cvs = [SELECT Id,title,PathOnClient, FileType,versiondata,ContentSize,ContentDocumentId FROM contentversion WHERE ContentDocumentId IN : abc ];
        Set<Id> error = new Set<Id>();
        Set<Id> arr = new Set<Id>();
        for(ContentVersion cv : cvs){
            if(cv.ContentSize > 3145728){
               error.add(cv.Id);
            }else{
               arr.add(cv.ContentDocumentId);
            }
        }
        if(error.size()>0){
            ContentVersion cv = [SELECT id, ContentDocumentId FROM ContentVersion where id =: error];
            ContentDocument cd = [SELECT id FROM ContentDocument where id =:cv.ContentDocumentId];
            delete cd;
            return [SELECT Id,title,PathOnClient, FileType,versiondata,ContentSize,ContentDocumentId FROM contentversion WHERE ContentDocumentId IN : arr];
        }else{
            return cvs;
        }
       	 
    }
    
    
    @AuraEnabled
    public static List<ContentVersion> getFiles1(List<String> ids){
        Set<Id> abc = new Set<Id>();
        List<FileUploadID__c> fileUploads = new List<FileUploadID__c>();
        for(String a : ids){
            FileUploadID__c fileUpload = new FileUploadID__c();
            abc.add(Id.valueOf(a.replace('"', '')));
            fileUpload.isCheckID__c = Id.valueOf(a.replace('"', ''));
            fileUploads.add(fileUpload);
        }
		insert fileUploads;
        return  [SELECT Id,title,PathOnClient, FileType,versiondata,ContentSize,ContentDocumentId FROM contentversion WHERE ContentDocumentId IN : abc ];
    }
    
    
    @AuraEnabled
    public static void deleteFilesContentDocument(String ids){
        Set<Id> abc = new Set<Id>();
        abc.add(Id.valueOf(ids.replace('"', '')));
        ContentVersion cv = [SELECT id, ContentDocumentId FROM ContentVersion where id =: abc];
        ContentDocument cd = [SELECT id FROM ContentDocument where id =:cv.ContentDocumentId];
        delete cd;
    }
    
    //Delete file when cancel upload files
    @AuraEnabled
    public static void deleteFiles(List<String> ids,List<String> fileUploads){
		List<String> isCheck = new List<String>();        
        List<String> abc = new List<String>();
        if(!fileUploads.isEmpty()){
            for(String is : fileUploads){
                isCheck.add(is.replace('"', ''));
            }
            List<String> idsAdd = new List<String>();
            for(String idFile : ids){
                idsAdd.add(idFile.replace('"', ''));
            }
            for (integer i = 0; i < idsAdd.size(); i++){
                if (!isCheck.contains(idsAdd.get(i))){
                    abc.add(idsAdd.get(i));
                }
            }
            for (integer j = 0; j < isCheck.size(); j++){
                if (!idsAdd.contains(isCheck.get(j))){
                    abc.add(isCheck.get(j));
                }
            }
        }else{
            for(String idFile : ids){
                abc.add(Id.valueOf(idFile.replace('"', '')));
            }
        }
        
      
        ContentVersion[] cv = [SELECT id, ContentDocumentId FROM ContentVersion where ContentDocumentId IN: abc];
        Set<Id> idsCV = new Set<Id>();
        for(ContentVersion idCV : cv){
            idsCV.add(idCV.ContentDocumentId);
        }
        List<ContentDocument> cd = [SELECT id FROM ContentDocument where id IN: idsCV];
        delete cd;
    }
    
       
    @AuraEnabled
    public static void deleteFilesContentDocuments(List<String> ids){
        system.debug('ids'+ids);
        Set<Id> abc = new Set<Id>();
        for(String idString : ids){
           abc.add(Id.valueOf(idString.replace('"', '')));
        }
        ContentVersion[] cv = [SELECT id, ContentDocumentId FROM ContentVersion where ContentDocumentId IN: abc];
        Set<Id> idsCV = new Set<Id>();
        for(ContentVersion idCV : cv){
            idsCV.add(idCV.ContentDocumentId);
        }
        List<ContentDocument> cd = [SELECT id FROM ContentDocument where id IN: idsCV];
        delete cd;
    }
    
    @AuraEnabled
    public static String callApiClass(){
        String results = UtilClass.getContent();
    	return results;
    }

	@AuraEnabled
    public static List<Junction_Incident_Asset__c> searchIncident(String idIncidents ,String nameAssert, String idAssert){
        system.debug('resultItAssets 0' + idIncidents + 'nameAssert' + nameAssert + 'idAssert '+idAssert);
        if(!String.isEmpty(idAssert) && String.isEmpty(nameAssert)){
            system.debug('resultItAssets 1');
            List<Junction_Incident_Asset__c>  jias = [SELECT IT_Asset__c,IT_Asset__r.Name FROM  Junction_Incident_Asset__c WHERE Incident__c =:idIncidents AND IT_Asset__c =:idAssert];
        	return jias;
        }else if(!String.isEmpty(idAssert) && !String.isEmpty(nameAssert)){
             system.debug('resultItAssets 2');
             Set<Id> resultItAssets = new Set<Id>();
                String n = '%'+nameAssert+'%';
                List<IT_Asset__c> nameAssets = [SELECT id FROM IT_Asset__c WHERE Name LIKE :n];
                system.debug('nameAssets' +nameAssets);
                for(IT_Asset__c nameAsset :nameAssets){
                    String newID = nameAsset.id;
                    if(newID.indexOf(idAssert) > -1){
                         system.debug('1'+newID);
                         resultItAssets.add(nameAsset.id);     
                    }
                }
                if(!resultItAssets.isEmpty()){
                   List<Junction_Incident_Asset__c>  jias = [SELECT IT_Asset__c,IT_Asset__r.Name FROM  Junction_Incident_Asset__c WHERE Incident__c =:idIncidents AND IT_Asset__c IN: resultItAssets];
                  system.debug('jias'+jias);
                    return jias;
                }else{
                    return [SELECT IT_Asset__c,IT_Asset__r.Name FROM  Junction_Incident_Asset__c WHERE Incident__c =:idIncidents];
                }
            						
        }else if(String.isEmpty(idAssert) && !String.isEmpty(nameAssert)){
            system.debug('resultItAssets 3');
            Set<Id> resultItAssets = new Set<Id>();
                String n = '%'+nameAssert+'%';
                List<IT_Asset__c> nameAssets = [SELECT id FROM IT_Asset__c WHERE Name LIKE :n];
                system.debug('nameAssets' +nameAssets);
                for(IT_Asset__c nameAsset :nameAssets){
                        resultItAssets.add(nameAsset.id);     
                }
            List<Junction_Incident_Asset__c>  jias = [SELECT IT_Asset__c,IT_Asset__r.Name FROM  Junction_Incident_Asset__c WHERE Incident__c =:idIncidents AND IT_Asset__c IN : resultItAssets];
            return jias;
        }else{
            system.debug('resultItAssets 4');
            return  [SELECT IT_Asset__c,IT_Asset__r.Name FROM  Junction_Incident_Asset__c WHERE Incident__c =:idIncidents];
        } 
    }
    
    @AuraEnabled
    public static List<Junction_Incident_Asset__c> searchAssetID(String idAssert ,String nameIncident, String idIncident){
        system.debug('resultItAssets 1' + idAssert + 'nameIncident' +nameIncident +'idIncident'+idIncident);
         if(!String.isEmpty(idIncident) && String.isEmpty(nameIncident)){
           system.debug('resultItAssets 2');
           List<Junction_Incident_Asset__c>  jias = [SELECT Incident__c,Incident__r.Name FROM  Junction_Incident_Asset__c WHERE IT_Asset__c =:idAssert AND Incident__c =:idIncident];
           return jias;
        }else if(!String.isEmpty(idIncident) && !String.isEmpty(nameIncident)){
             system.debug('resultItAssets 3');
           Set<Id> resultItAssets = new Set<Id>();
            String n = '%'+nameIncident+'%';
            List<Incident__c> incidents = [SELECT id FROM Incident__c WHERE Name LIKE :n];
            for(Incident__c incident :incidents){
                String newID = incident.id;
                if(newID.indexOf(idIncident) > -1){
                     resultItAssets.add(incident.id);     
                }
            }
            if(!resultItAssets.isEmpty()){
               List<Junction_Incident_Asset__c>  jias = [SELECT Incident__c,Incident__r.Name FROM  Junction_Incident_Asset__c WHERE IT_Asset__c =:idAssert AND Incident__c IN: resultItAssets];
              system.debug('jias'+jias);
                return jias;
            }else{
               return [SELECT Incident__c,Incident__r.Name FROM Junction_Incident_Asset__c WHERE IT_Asset__c =:idAssert]; 
            }
            						
        }else if(String.isEmpty(idIncident) && !String.isEmpty(nameIncident)){
            system.debug('resultItAssets 3');
            Set<Id> resultItAssets = new Set<Id>();
            String n = '%'+nameIncident+'%';
            List<Incident__c> incidents = [SELECT id FROM Incident__c WHERE Name LIKE :n];
            for(Incident__c incident :incidents){
               resultItAssets.add(incident.id);     
            }
            List<Junction_Incident_Asset__c>  jias = [SELECT Incident__c,Incident__r.Name FROM  Junction_Incident_Asset__c WHERE IT_Asset__c =:idAssert AND Incident__c IN :resultItAssets];
            return jias;
        }else{
            system.debug('resultItAssets ');
            return  [SELECT Incident__c,Incident__r.Name FROM Junction_Incident_Asset__c WHERE IT_Asset__c =:idAssert];
        }
    }
    
    public void testWireEmailOrganization(String email){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String s = email;
        Integer i = 0;
        String[] toAddresses = new String[] {'quandevkaizen@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('月極請求処理結果');
        String body = '月極請求処理に失敗しました。'+ '<br/>' + '請求書が作成済みだった取引先 : ' + '<br/>' + s  + '<br/>' + '請求書作成件数 : '+'5件' ;
        mail.setPlainTextBody(body);
        mail.setHtmlBody(body);
        List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'torres851995@gmail.com'];
        mail.setOrgWideEmailAddressId(addresses[0].Id);
        system.debug('mail' + mail);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}