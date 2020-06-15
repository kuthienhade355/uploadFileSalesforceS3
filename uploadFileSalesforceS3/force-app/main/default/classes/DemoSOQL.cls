public class DemoSOQL {
    public static void newSOQL(){
       Account acct2 = new Account(
        Name='The SFDC Query Man',
        Phone='(310)555-1213',
        NumberOfEmployees=50,
        BillingCity='Los Angeles',
        Description='Expert in wing technologies.');
    	insert acct2;
    }
}