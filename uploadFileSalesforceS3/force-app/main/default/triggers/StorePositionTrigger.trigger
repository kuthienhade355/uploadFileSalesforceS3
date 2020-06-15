trigger StorePositionTrigger on Store_Position__c (after insert) {
	//if(Trigger.isAfter){
	//	if(Trigger.isInsert){
	//		Set<Id> ids = new Set<Id>();
	//		for(Store_Position__c triggerO : Trigger.old){
	//			ids.add(triggerO.id);
	//		}
	//		if(!ids.isEmpty()){
	//			PositionTriggerHandle.handleInsert(ids);
	//		}
	//	}
	//}
}