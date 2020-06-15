//Tran Minh Quan
//31/10/2018
//Unit test LoginController
@isTest
private class LoginControllerTest{
	@testSetup
	static void testSetup(){
		CustomUser__c customUser = new CustomUser__c(NameUser__c = 'test CustomUser');
		customUser.email__c = 'test';
		customUser.password__c = '123';
		insert customUser;
	}
	
	@isTest
		static void testLoginAccountEmpty(){
		test.startTest();
		LoginCC lg = new LoginCC();
		lg.getLoginAccount();
		test.stopTest();
	}

	@isTest
		static void testLoginAccountSuccess(){
		test.startTest();
		String username = 'test';
		String password = '123';
		LoginCC lg = new LoginCC(username,password);
		lg.getLoginAccount();
		test.stopTest();
	}

	@isTest
		static void testLoginAccountWrongPassword(){
		test.startTest();
		String username = 'test';
		String password = '12';
		LoginCC lg = new LoginCC(username,password);
		lg.getLoginAccount();
		test.stopTest();
	}


	@isTest
		static void testLoginAccountRemoteActionWrongPassword(){
		test.startTest();
		String username = 'test';
		String password = '12';
		System.assertEquals(null,LoginCC.getLogin(username,password));
		test.stopTest();
	}

	@isTest
		static void testLoginAccountRemoteActionSuccess(){
		test.startTest();
		String username = 'test';
		String password = '123';
		LoginCC.getLogin(username,password);
		test.stopTest();
	}
}