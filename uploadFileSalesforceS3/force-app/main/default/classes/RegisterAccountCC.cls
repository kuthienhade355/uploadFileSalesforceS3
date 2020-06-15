public class RegisterAccountCC {
    public static void newRegisterAccount(){
   		RegisterAccount__c ra = new RegisterAccount__c(Name='MonKeyDQuan');
        ra.FirstName__c = 'MinhQuan';
        insert ra;
        system.debug('info account Id' + ra.Id);
    }
    public static List<RegisterAccount__c> getAccounts(){
        List<RegisterAccount__c> accounts = new List<RegisterAccount__c>();
        accounts = [SELECT Name ,FirstName__c FROM RegisterAccount__c];
        return accounts;
    }
    public static RegisterAccount__c getAccount(Id id){
        return [SELECT Name,FirstName__c FROM RegisterAccount__c WHERE Id=:id LIMIT 1];
    }
}