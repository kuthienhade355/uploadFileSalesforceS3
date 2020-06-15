public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName,String postal){
        List<Contact> contacts = [SELECT Id,Name,LastName,MailingPostalCode FROM
                                 Contact Where LastName=:lastName And MailingPostalCode=:postal];
        return contacts;
    }
}