public with sharing class myControllerExtension {
	private final  ProfileCV__c profile;

    public myControllerExtension(ApexPages.StandardController stdController) {

 		this.profile = (ProfileCV__c)stdController.getRecord();
    }

    public String getExperiences() {
    	List<Experience__c> experiences = new List<Experience__c>();
    	experiences = [SELECT name ,toYear__c ,fromYear__c,description__c FROM Experience__c Where ProfileCV__c=:profile.Id Limit 2];
    	return JSON.serialize(experiences);
    }	

    public String getEducations(){
    	List<Education__c> educations = new List<Education__c>();
    	educations = [SELECT name,fromYear__c,toYear__c,title__c,place__c,department__c,description__c FROM Education__c Where ProfileCV__c=:profile.Id Limit 2];
    	return JSON.serialize(educations);
    }
    
    public String getSkills(){
    	List<Skill__c> skills = new List<Skill__c>();
    	skills = [SELECT name,description__c FROM Skill__c Where ProfileCV__c=:profile.Id Limit 2];
    	return JSON.serialize(skills);
    }

    public String getProjectUndertakens(){
    	List<ProjectUndertaken__c> skills = new List<ProjectUndertaken__c>();
    	skills = [SELECT name,title__c,description__c,linkProject1__c,linkProject2__c FROM ProjectUndertaken__c Where ProfileCV__c=:profile.Id Limit 2];
    	return JSON.serialize(skills);
    }

    public String getHobbies(){
    	List<Hobby__c> hobbies = new List<Hobby__c>();
    	hobbies = [SELECT name,description__c FROM Hobby__c Where ProfileCV__c=:profile.Id Limit 2];
    	return JSON.serialize(hobbies);
    }

    public String getObjectives(){
    	List<Objective__c> objectives = new List<Objective__c>();
    	objectives = [SELECT name,description__c FROM Objective__c Where ProfileCV__c=:profile.Id Limit 3];
    	return JSON.serialize(objectives);
    }
}