@isTest
public class DailyLeadProcessorTest {
	@testSetup
    static void setup(){
        List<Lead> leads = new List<Lead>();
        for(integer i=1 ; i<=200;i++){
            Lead ld = new Lead(Company='Comp' + i  ,LastName='LN' + i,Status= 'Working - Contacted');
            leads.add(ld);    
        }
        insert leads;
    }
    
    static testmethod void testDailyLeadProcessorScheduledJob(){
        String sch = '0 5 12 * * ?';
        Test.startTest();
        String jobId = System.schedule('SchedulableApexTest', sch, new DailyLeadProcessor());
        List<Lead> leads = [SELECT Id FROM Lead Where LeadSource = null LIMIT 200];
        System.assertEquals(200, leads.size());
        Test.stopTest();
    }
}