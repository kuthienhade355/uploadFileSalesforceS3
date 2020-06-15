@isTest
public class TestRestrictContactByName {
    @isTest static void testdemo(){
        Contact c = new Contact(LastName='INVALIDNAME');
        Database.SaveResult result = Database.insert(c,false);
        system.assertEquals('The Last Name INVALIDNAME is not allowed for DML', result.getErrors()[0].getMessage());
    }
}