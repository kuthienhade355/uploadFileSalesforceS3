global  class receiveEmailService implements Messaging.InboundEmailHandler {
    
    global  Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
				// Create an InboundEmailResult object for returning the result of the 
                // Apex Email Service
                Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        		String myPlainText= '';
        		
                // Add the email plain text into the local variable if client want change color for email using .escapeHtml4()
                    if(email.htmlBody == null){
                        myPlainText = email.plainTextBody;
                    }else{
                         myPlainText = email.htmlBody;
                    } 
                    //myPlainText = email.htmlBody;
        		   system.debug('myPlainText'+myPlainText);
                // New Task object to be created
               
                // Try to look up any contacts based on the email from address
                // If there is more than one contact with the same email address,
                // an exception will be thrown and the catch statement will be called.
                try {
                    Recipient__c newTask = new Recipient__c();
                  // Add a new Task to the contact record we just found above.
                  newTask.Body__c =  myPlainText;
                  newTask.isReceiveMail__c = true;
                  newTask.From__c = email.fromAddress;
                  newTask.Subject__c = email.subject;
                 
                 // Insert the new Task 
                 insert newTask;    
                 List<Attachment> attachments = new List<Attachment>();
                  if(email.textAttachments != null)
                  {
                    for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                      Attachment attachment = new Attachment();
                      attachment.Name = tAttachment.fileName;
                      attachment.Body = Blob.valueOf(tAttachment.body);
                      attachment.ParentId = newTask.Id;
                      attachments.add(attachment);
                    }
                  }
                  if(email.binaryAttachments != null)
                  {
                    for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
                      Attachment attachment = new Attachment();
                      attachment.Name = bAttachment.fileName;
                      attachment.Body = bAttachment.body;
                      attachment.ParentId = newTask.Id;
                      attachments.add(attachment);
                    }
                  }
                  if(attachments.size() > 0)
                  {
                    insert attachments;
                  }
                 System.debug('New Task Object: ' + newTask );   
                }
                // If an exception occurs when the query accesses 
                // the contact record, a QueryException is called.
                // The exception is written to the Apex debug log.
               catch (QueryException e) {
                   System.debug('Query Issue: ' + e);
               }
               
               // Set the result to true. No need to send an email back to the user 
               // with an error message
               result.success = true;
        	
               return result;
    }
}