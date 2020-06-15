@isTest
private class ExperienceControllerTest{
	
	@testSetup
	static void testSetup(){
		Function__c function = new Function__c();
		function.Title__c = 'MinhQuan';
		function.Name__c = 'Test';
		insert function;
		Experience1__c experience = new Experience1__c();
		experience.Name__c ='MinhQuan';
		experience.description__c ='tranminhquan';
		insert experience;
		CustomUser__c customUser = new CustomUser__c(NameUser__c = 'test CustomUser');
		customUser.email__c = 'test';
		customUser.password__c = '123';
		customUser.role__c = 'Dev';
		insert customUser;
		customUser = [SELECT id FROM CustomUser__c WHERE email__c ='test'];
		Cookie counter = apexpages.currentPage().getCookies().get('urlID');   
		counter = new Cookie('urlID',customUser.id,null,-1,false);
		ApexPages.currentPage().setCookies(new Cookie[]{counter});
	}

	@isTest
	static void testGetCustomUser(){
		CustomUser__c customUser = [SELECT id FROM CustomUser__c WHERE email__c ='test'];
		ExperienceCC experience = new ExperienceCC();
		test.startTest();
		experience.getCustomUser(customUser.id);
		test.stopTest();
	}


	@isTest
	static void testPageReferentInit(){
		Cookie counter = apexpages.currentPage().getCookies().get('urlID');
		ExperienceCC experience = new ExperienceCC();
		test.startTest();
		experience.init();
		test.stopTest();
	}
	@isTest
	static void testPageReferentInitNull(){
		ExperienceCC experience = new ExperienceCC();
		test.startTest();
		experience.init();
		test.stopTest();
	}

	@isTest
	static void testExperience(){
		Cookie counter = apexpages.currentPage().getCookies().get('urlID');
		ExperienceCC experience = new ExperienceCC();
		test.startTest();
		experience.getExperience1();
		test.stopTest();
	}

}