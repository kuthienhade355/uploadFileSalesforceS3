public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accountList){
        for(Account account : accountList){
            if(account.ShippingState != account.BillingState ){
                account.ShippingState = account.BillingState;
            }
        }
    }
}