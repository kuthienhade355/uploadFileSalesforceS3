public with sharing class ExperienceCC {
	
	public CustomUser__c customUser {get;set;}

	public ExperienceCC(){
		Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
		if(cookie!=null){
			this.customUser = getCustomUser(cookie.getValue());	
		}
	}

	public PageReference init(){
	Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
	PageReference p = new PageReference('/apex/login');
	if(cookie!=null){
			return null;
		}
		p.setRedirect(true);
		return p;
	}

	public CustomUser__c getCustomUser(String urlID){
		//list sobject
		CustomUser__c c  = [SELECT NameUser__c,Role__c,MemberId__c,ExpriedDate__c,Email__c,LastLogin__c,FirstLogin__c FROM CustomUser__c Where id = :urlID Limit 1];
		return c;
	}

	public String getExperience1(){
		Cookie cookie = ApexPages.currentPage().getCookies().get('urlID');
		String urlID = cookie.getValue();
		List<Experience1__c> experience = [SELECT Description__c,Name__c FROM Experience1__c Where CustomUser__c =:urlID]; 
		String jsonstrng = String.escapeSingleQuotes(JSON.serialize(experience));
		return jsonstrng;
	}

	public String getFunctions(){
		List<Function__c> functions =[SELECT Active__c, Title__c, Name__c,ParentID__c FROM Function__c];
		return JSON.serialize(functions);
	}

	public PageReference getLogOut(){
		PageReference page = new PageReference('/apex/login');
		Cookie cookie = new Cookie('urlId', '',null,0,false);
		ApexPages.currentPage().setCookies(new Cookie[]{cookie});
		page.setRedirect(true);
		return page;
	}
}