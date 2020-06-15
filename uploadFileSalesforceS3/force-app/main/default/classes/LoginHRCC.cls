//Tran Minh Quan
public with sharing class LoginHRCC {		
	//Apex Form 
	public String userName {get; set;}
    public String password {get; set;}
    public Boolean getInput {get;set;}
    public List<CustomUser__c> customUsers {get; set;}

    public LoginHRCC(String userName ,String password){
    	this.username = userName;
    	this.password = password;
    }

    public LoginHRCC() {
       getInput = True;
       customUsers = new List<CustomUser__c>();
       Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
       System.debug('cookie' + cookie);
    }

    public PageReference getLoginAccount() {
       	getInput = False;
        customUsers = [SELECT email__c, password__c,role__c  FROM CustomUser__c WHERE email__c=:username Limit 1];
		//loginUserCalendars = [SELECT userName__c, password__c  FROM LoginUserCalendar__c WHERE userName__c=:username Or alias__c=:username Limit 1];
		if(customUsers.isEmpty()){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'username or password is wrong please try it again!'));
	    	return null;	
		}
		
		CustomUser__c loginCustomUser = customUsers.get(0);
		//LoginUserCalendar__c loginUserCalendar = loginUserCalendars.get(0);
		//if(!customUsers.isEmpty()&& loginCustomUser.password__c == password && loginCustomUser.role__c == 'Admin'){
  //          PageReference page = new PageReference('/Pagination');
		//	page.setRedirect(true);
		//	return page;
		//}	

        if(!customUsers.isEmpty()&& loginCustomUser.password__c == password){
            PageReference page = new PageReference('/apex/Experience');
			Cookie c = new Cookie('urlId',loginCustomUser.Id,null,-1,false);
			page.setCookies(new Cookie[] {c});
			page.setRedirect(true);
			return page;
		}	

		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'username or password is wrong please try it again!'));
	    return null;
	}		
}