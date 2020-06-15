@isTest
public class AccountTriggerTest {
    @isTest static void TestCreate200Records(){
        List<Account> accts = new List<Account>();
        for(integer i = 0;i<200;i++){
            Account acct = new Account(Name='Test Acccount' + i, BillingState='CA');
            accts.add(acct);
        }
        Test.startTest();
        insert accts;
        Test.stopTest();
        List<Account> lstAccount = [SELECT ShippingState From Account];
        for(Account a : lstAccount){
            system.assertEquals('CA',a.ShippingState,'ERROR');
        }
    }
}