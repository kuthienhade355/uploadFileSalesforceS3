@isTest
public class AddPrimaryContactTest {
    @isTest static void TestList(){
        List<Account> testAccount = new List<Account>();
        for(integer i=0;i<50;i++){
           	testAccount.add(new Account(BillingState ='CA' , name ='Test' +i));
        }
        for(integer j=0;j<50;j++){
            testAccount.add(new Account(BillingState ='NY', name = 'Test'+j));
        }
        insert testAccount;
        
        Contact co = new Contact();
        co.FirstName = 'Quan';
        co.LastName = 'Minh';
        insert co ;
        String state ='CA';
        
        AddPrimaryContact apc = new AddPrimaryContact(co,state);
        test.startTest();
        System.enqueueJob(apc);
        test.stopTest();
        
    }
    
}