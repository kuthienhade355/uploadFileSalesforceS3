trigger CandidatePositionTrigger on Candidate_Position__c (after insert) {
	if(Trigger.isInsert){
		if(Trigger.isAfter){
			//Set<Id> ids = new Set<Id>();
			//for(Candidate_Position__c triggerN : Trigger.new){
			//	ids.add(triggerN.id);
			//}
			//if(!ids.isEmpty()){
			//	PositionTriggerHandle.handleInsert(ids);
			//}
			PositionTriggerHandle.handleCandidateInsert(Trigger.new);
		}
	}
}