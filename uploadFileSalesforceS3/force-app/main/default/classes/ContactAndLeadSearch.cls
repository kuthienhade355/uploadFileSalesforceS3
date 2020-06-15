public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String searchWord){
       	String querySOSL = 'FIND \''+ searchWord + '\' IN ALL FIELDS RETURNING Lead(FirstName,LastName), Contact(FirstName,LastName)';
        List<List<SObject>> searchList = search.query(querySOSL);
        return searchList;
    }
}