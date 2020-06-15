global class DailyLeadProcessor implements Schedulable  {
    global void execute(SchedulableContext sc){
        List<Lead> leads = [SELECT Id FROM Lead WHERE LeadSource = null LIMIT 200];
        List<Lead> lstOfUpdateLead = new List<Lead>();
            for(Lead l : leads){
                l.LeadSource = 'Dreamforce';
                lstOfUpdateLead.add(l);
            }
            UPDATE lstOfUpdateLead;
    }
}