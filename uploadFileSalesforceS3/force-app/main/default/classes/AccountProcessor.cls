public class AccountProcessor {
    @future
    public static void countContacts(Set<Id> setId){
        List<Account> accounts = [SELECT Id , Number_of_Contacts__c ,(SELECT Id FROM Contacts) FROM Account WHERE Id IN : setId];
        for(Account a : accounts){
 			List<Contact> contacts = a.Contacts;
            a.Number_of_Contacts__c = contacts.size();
        }
		Update accounts;
    }
    @future
    public static void countContacts1(Set<Id> setId){
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c,(SELECT Id FROM Contacts) FROM Account Where Id In : setId];
        for(Account a : accounts){
            List<Contact> contacts = a.Contacts;
            a.Number_of_Contacts__c = contacts.size();
        }
        Update accounts;
    }
}