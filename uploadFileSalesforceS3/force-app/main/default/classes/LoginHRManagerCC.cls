//Tran Minh Quan
public with sharing class LoginHRManagerCC {		
	//Apex Form 
	public String userName {get; set;}
    public String password {get; set;}
    public Boolean getInput {get;set;}
    public List<Register__c> registers {get;set;}
    public List<ApprovalRegister__c> approvalRegisters {get;set;}

    public LoginHRManagerCC(String userName ,String password){
    	this.username = userName;
    	this.password = password;
    }

    public LoginHRManagerCC() {
       getInput = True;
       //registers = new List<Register__c>();
       approvalRegisters = new List<ApprovalRegister__c>();
       Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
       System.debug('cookie' + cookie);
    }

    public PageReference getLoginAccount() {
       	getInput = False;
		//registers = [SELECT email__c,password__c FROM Register__c WHERE email__c =:username Limit 1];
		approvalRegisters = [SELECT Register__c,status__c,Register__r.email__c,Register__r.password__c FROM ApprovalRegister__c WHERE Register__r.email__c =:username Limit 1];
		if(approvalRegisters.isEmpty()){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'username or password is wrong please try it again!'));
	    	return null;	
		}
		
		ApprovalRegister__c loginCustomUser = approvalRegisters.get(0);

        if(!approvalRegisters.isEmpty() && loginCustomUser.Register__r.password__c == password && loginCustomUser.status__c==true){
            PageReference page = new PageReference('/apex/RegisterPage');
			Cookie c = new Cookie('urlId',loginCustomUser.Register__c,null,-1,false);
			page.setCookies(new Cookie[] {c});
			page.setRedirect(true);
			return page;
		}	

		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'username or password is wrong please try it again!'));
	    return null;
	}		
}