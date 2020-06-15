public with sharing class CustomerCC {
	public CustomUser__c customUser {get;set;}
	public CustomerCC(){
		Cookie counter = apexpages.currentPage().getCookies().get('urlID');
		if(counter!=null){
			this.customUser = getCustomUser(counter.getValue());	
		}
	}
	public PageReference init(){
		Cookie counter = apexpages.currentPage().getCookies().get('urlID');
		PageReference p = new PageReference('/');
		if(counter!=null){
			return null;
		}
		p.setRedirect(true);
		return p;
	}
	public CustomUser__c getCustomUser(String urlID){
		CustomUser__c c  = [SELECT NameUser__c,Role__c,MemberId__c,ExpriedDate__c,Email__c,LastLogin__c,FirstLogin__c FROM CustomUser__c Where id = :urlID];
		return c;
	}
	public String getExperience1(){
		Cookie counter = ApexPages.currentPage().getCookies().get('urlID');
		String urlID = counter.getValue();
		List<Experience1__c> experience = new List<Experience1__c>();
		experience = [SELECT Description__c,Name__c FROM Experience1__c Where CustomUser__c =:urlID];
		String jsonstrng = String.escapeSingleQuotes(JSON.serialize(experience));
		return jsonstrng;
	}
	public String getFunctions(){
		List<Function__c> functions = new List<Function__c>();
		functions = [SELECT Active__c, Title__c, Name__c,ParentID__c FROM Function__c];
		return JSON.serialize(functions);
	}
	@RemoteAction
	public static PageReference getLogOutRA(){
		PageReference page = new PageReference('/');
		return page;
	}
}