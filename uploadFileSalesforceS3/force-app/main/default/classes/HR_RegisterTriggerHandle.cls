public with sharing class HR_RegisterTriggerHandle {
	public static void handleInsert(Set<Id> ids){
		List<ApprovalRegister__c> ars = new List<ApprovalRegister__c>();
		for(String id : ids){
			ApprovalRegister__c ar = new ApprovalRegister__c();
			ar.Register__c = id;
			ar.status__c = false;
			ars.add(ar);
		}
		insert ars; 
	}

	public static void handleAfter(Set<Id> ids){
		List<Store_Candidate__c> scs = [SELECT id,Last_Name__c,First_Name__c,Phone__c,Email__c FROM Store_Candidate__c WHERE Id=: ids];
        String[] addresses = new String[]{},
            	 subjects = new String[]{},
                 messages = new String[]{};
        for(Store_Candidate__c sc: scs)	{
            addresses.add(sc.Email__c);
            subjects.add('Speaker Confirmation');
            messages.add('Dear ' + sc.First_Name__c + ',\nYour session "' + sc.Last_Name__c + '" on ' +
                    sc.Phone__c + ' is confirmed and waited for position.\n\n' +
                    'Thanks for speaking at the conference!');
        }
        EmailManager.sendMail(addresses, subjects, messages);
	}
}