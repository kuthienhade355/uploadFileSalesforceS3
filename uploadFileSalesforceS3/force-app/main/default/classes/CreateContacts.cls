public class CreateContacts {
    public static void CreateContact(){
        List<Contact> cons = new List<Contact>();
        for (integer i = 0; i < 5500; i++) {
            Contact c = new Contact(LastName = 'test' + i, Email = 'test@salesforce.com', Phone = '123456');
            cons.add(c);
        }
        try {
            Database.SaveResult[] result = database.insert(cons);
        } catch (exception e) {
            system.debug('Exception:' + e.getMessage());
        } 
    }
}