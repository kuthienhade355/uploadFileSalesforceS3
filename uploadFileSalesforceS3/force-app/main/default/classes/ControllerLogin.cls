public with sharing class ControllerLogin {		
	@RemoteAction
	public static PageReference getLogin(string username,string password){
		List<CustomUser__c> customUsers = new List<CustomUser__c>();
		customUsers = [SELECT email__c,password__c ,id FROM CustomUser__c WHERE email__c=:username];
		try{
			CustomUser__c loginCustomUser = customUsers.get(0);
			if(loginCustomUser.email__c == username && loginCustomUser.password__c == password){
			    PageReference page = new PageReference(loginCustomUser.id);
			    return page;
			}	
		}catch(Exception e){
			e.getMessage();
		}
		return null;
	}
}