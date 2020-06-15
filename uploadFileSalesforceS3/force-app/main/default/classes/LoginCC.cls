//Tran Minh Quan
public with sharing class LoginCC {		
	@RemoteAction
	public static String getLogin(string username,string password){
		List<CustomUser__c> customUsers = [SELECT email__c,password__c ,id FROM CustomUser__c WHERE email__c=:username Limit 1];
		CustomUser__c loginCustomUser = customUsers.get(0);
		if(!customUsers.isEmpty() && loginCustomUser.password__c == password){
			return loginCustomUser.id;
		}	
		return null;
	}

	//Apex Form 
	public String userName {get; set;}
    public String password {get; set;}
    public Boolean getInput {get;set;}
    //public List<CustomUser__c> customUsers {get; set;}
    public List<LoginUserCalendar__c> loginUserCalendars {get;set;}

    public LoginCC(String userName ,String password){
    	this.username = userName;
    	this.password = password;
    }

    public LoginCC() {
       getInput = True;
       //customUsers = new List<CustomUser__c>();
       loginUserCalendars = new List<LoginUserCalendar__c>();
       Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
       System.debug('cookie' + cookie);
    }

    public PageReference getLoginAccount() {
       	getInput = False;
        //customUsers = [SELECT email__c, password__c,role__c  FROM CustomUser__c WHERE email__c=:username Limit 1];
		loginUserCalendars = [SELECT userName__c, password__c  FROM LoginUserCalendar__c WHERE userName__c=:username Or alias__c=:username Limit 1];
		if(loginUserCalendars.isEmpty()){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'username or password is wrong please try it again!'));
	    	return null;	
		}
		
		//CustomUser__c loginCustomUser = customUsers.get(0);
		LoginUserCalendar__c loginUserCalendar = loginUserCalendars.get(0);
		//if(!customUsers.isEmpty()&& loginCustomUser.password__c == password && loginCustomUser.role__c == 'Admin'){
  //          PageReference page = new PageReference('/Pagination');
		//	page.setRedirect(true);
		//	return page;
		//}	

  //      if(!loginUserCalendars.isEmpty()&& loginUserCalendar.password__c == password){
  //          PageReference page = new PageReference('/apex/Experience');
		//	Cookie c = new Cookie('urlId',loginUserCalendar.id,null,-1,false);
		//	page.setCookies(new Cookie[] {c});
		//	page.setRedirect(true);
		//	return page;
		//}	

		if(!loginUserCalendars.isEmpty()&& loginUserCalendar.password__c.toLowerCase() == password.toLowerCase()){
            PageReference page = new PageReference('/apex/Calendar');
			Cookie c = new Cookie('urlId',loginUserCalendar.id,null,-1,false);
			page.setCookies(new Cookie[] {c});
			page.setRedirect(true);
			return page;
		}	

		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'username or password is wrong please try it again!'));
	    return null;
	}		
}