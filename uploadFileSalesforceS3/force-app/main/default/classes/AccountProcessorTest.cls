@isTest
public class AccountProcessorTest {
    public static testmethod void TestAccountProcessorTest(){
        Account a = new Account();
        a.Name = 'Test Account';
        Insert a;
        
        Contact cont = new Contact();
        cont.FirstName = 'Quan';
        cont.LastName = 'Tran';
      	cont.AccountId = a.Id;
        Insert cont;
        
        Set<Id> setAccountId = new Set<Id>();
        setAccountId.add(a.Id);
        
        Test.startTest();
        AccountProcessor.countContacts(setAccountId);
        Test.stopTest();
       
        Account Acc = [SELECT Number_of_Contacts__c From Account WHERE Id = : a.Id LIMIT 1];
        System.assertEquals(Integer.valueOf(Acc.Number_of_Contacts__c),1);
    }
    
    public static testmethod void TestAccountProcessor(){
        Account a = new Account();
        a.Name = 'Test 2';
        Insert a ;
        
        Contact c = new Contact();
        c.FirstName = 'Nghia';
        c.LastName = 'Nguyen';
        c.AccountId = a.Id;
        insert c;
        
        Set<Id> accountId = new Set<Id>();
        accountId.add(a.Id);
       
        test.startTest();
       	 AccountProcessor.countContacts1(accountId); 
        test.stopTest();
        
        Account Acc = [SELECT Number_of_Contacts__c FROM Account WHERE id = : a.id LIMIT 1];
        System.assertEquals(Integer.valueOf(Acc.Number_of_Contacts__c),1);
    }
}