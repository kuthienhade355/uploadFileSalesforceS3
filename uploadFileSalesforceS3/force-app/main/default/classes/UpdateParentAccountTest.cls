@isTest
public class UpdateParentAccountTest {
	@testSetup
    static void setup(){
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(name='Parent'));
        for(Integer i = 0 ; i<100 ; i++){
            accounts.add(new Account(name='Test Account' + i));
        }
         insert accounts;
    }
   
    static testmethod void testQueueable(){
        Id parentId = [SELECT id From Account WHere name='Parent'][0].Id;
        List<Account> accounts = [SELECT id , name From Account Where name like 'Test Account%'];
        UpdateParentAccount upa = new UpdateParentAccount(accounts,parentId);
        Test.startTest();
        System.enqueueJob(upa);
        Test.stopTest();
        System.assertEquals(100, [SELECT count() From account Where parentId =: parentId]);
    }
    
}