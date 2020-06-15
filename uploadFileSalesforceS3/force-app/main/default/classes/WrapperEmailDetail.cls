public class WrapperEmailDetail {
    
    public class wrapperObject{
        public String label;
        public String url ;
        public String version;
    }
    
    public class EmailWrap {
                EmailWrap() {
                        toEmail = '';
                        fromEmail = '';
                        subject = '';
                        body = '';
                    	cc = '';
						bcc = '';
                    	isReceiveMail = '';
                }
       			private String id;
               	private String toEmail ;
                private String fromEmail ;
                private String subject ;
                private String body ;
                private String cc ;
                private String bcc ;
                private String isReceiveMail ;
    }
    public static String getValues(){
        List<Recipient__c> recipients = [SELECT id,To__c,CC__c,BCC__c,Body__c,Subject__c,From__c,isReceiveMail__c  FROM Recipient__c order by LastModifiedDate desc];
        List<EmailWrap> ews = new List<EmailWrap>();
        for(Recipient__c recipient : recipients){
            EmailWrap ew = new EmailWrap();
            ew.id = recipient.id;
            ew.cc = recipient.CC__c;
            ew.bcc = recipient.BCC__c;
            ew.body = recipient.Body__c;
            ew.subject = recipient.Subject__c;
            ew.fromEmail = recipient.From__c;
            if(!String.isEmpty(recipient.To__c)){
              ew.toEmail = recipient.To__c;
            }else{
              ew.toEmail = 'Me';
            }
            if(recipient.isReceiveMail__c == true){
             ew.isReceiveMail = 'received';
            }else{
             ew.isReceiveMail = 'send';        
            }
           ews.add(ew);
        }
        return JSON.serialize(ews);
    }
}