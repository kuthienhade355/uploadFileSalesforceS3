global class LeadProcessor implements Database.Batchable<sObject>{
	global Integer recordsProcessor = 0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id , LeadSource FROM Lead');
    }
    
    global void execute(Database.BatchableContext bc , List<Lead> leads){
        List<Lead> new_leads = new List<Lead>();
            for(Lead l : leads){
            l.LeadSource = 'Dreamforce';
            new_leads.add(l);
            recordsProcessor += 1; 
            }
        update new_leads; 
    }
    
       global void finish(Database.BatchableContext bc){
        System.debug('recordsProcessor = ' + recordsProcessor);
    }
}