trigger HR_RegisterTrigger on Register__c (after insert) {
	if(Trigger.isInsert){
		if(Trigger.isAfter){
			Set<Id> ids = new Set<Id>();
			for(Register__c triggerN : Trigger.new){
				ids.add(triggerN.id);
			}
			if(!ids.isEmpty()){
				HR_RegisterTriggerHandle.handleInsert(ids);
			}
		}
	}
}