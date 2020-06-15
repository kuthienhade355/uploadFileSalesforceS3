trigger HR_StoreCandidateTrigger on Store_Candidate__c (after update) {
	if(Trigger.isUpdate){
		if(Trigger.isAfter){
			Set<Id> ids = new Set<Id>();
			for(Store_Candidate__c triggerN : Trigger.new){
				Store_Candidate__c triggerO = trigger.oldMap.get(triggerN.Id);
					if(triggerO.status__c == false && triggerN.status__c == true){
						ids.add(triggerN.Id);
					}
			}
			if(!ids.isEmpty()){
				HR_RegisterTriggerHandle.handleAfter(ids);
			}
		}
	}
}