public class AccountUtils {
    public static List<Account> accountsByState(String st){
        List<Account> ac = [SELECT Id, Name From Account Where BillingState=:st];
        return ac;
    }
}