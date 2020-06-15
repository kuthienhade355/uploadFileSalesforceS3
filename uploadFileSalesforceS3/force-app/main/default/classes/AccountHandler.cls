public class AccountHandler {
    public static Account insertNewAccount(String name){
        
            Account acct = new Account();
            acct.Name = name;
            // Insert the account 
        try {
            insert acct;
        } catch (DmlException e) {
            Return null;
        }
        return acct;
    }
}