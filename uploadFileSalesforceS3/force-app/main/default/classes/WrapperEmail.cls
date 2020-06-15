public class WrapperEmail {
    private String to {get;set;}
    private String bcc {get;set;}
    private String cc {get;set;}
    private String subject {get;set;}
    private String body {get;set;}
    private String uploadImage {get;set;}
    private Recipient__c recipient {get;set;}
    public WrapperEmail( String to,
     String bcc ,
     String cc,
     String subject ,
     String body ,
     String uploadImage,Recipient__c recipient){
        recipient = new Recipient__c();
        this.to = recipient.To__c;
        this.cc = recipient.CC__c;
        this.subject = recipient.BCC__c;
        this.body = recipient.Body__c;
        this.uploadImage = uploadImage;
    }
}