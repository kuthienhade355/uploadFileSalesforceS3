@isTest
public class LeadProcessorTest {
	@isTest
    public static void testList(){
        List<Lead> leads = new List<Lead>();
        for(integer i =0 ; i<200 ;i++){
           lead l = new Lead();
            l.lastName ='name'+i;
            l.company = 'Companay';
            l.Status = 'Random Status';
            leads.add(l);
        }
        insert leads;
        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
    }
}