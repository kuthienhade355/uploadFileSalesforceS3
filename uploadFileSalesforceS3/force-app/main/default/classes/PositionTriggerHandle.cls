public with sharing class PositionTriggerHandle {
	//public static String handleInsert(Set<Id> ids){
	//	List<Candidate_Position__c> cps = [SELECT Store_Candidate__c,Store_Position__c FROM Candidate_Position__c WHERE Id=:ids];
	//	Set<Id> idCandidates = new Set<Id>();
	//	for(Candidate_Position__c cp : cps){
	//		if(!String.isEmpty(cp.Store_Candidate__c) && !String.isEmpty(cp.Store_Position__c)){
	//			idCandidates.add(cp.Store_Candidate__c);
	//		}
	//	}
	//	List<Store_Candidate__c> scs = [SELECT PositionStatus__c FROM Store_Candidate__c WHERE Id=:idCandidates];
	//	for(Store_Candidate__c sc : scs){
	//		sc.PositionStatus__c = true;
	//		scs.add(sc);
	//	}
	//	upsert scs;
	//	return null;
	//}
	public static void handleCandidateInsert(List<Candidate_Position__c> triggerNew){
		Set<Id> ids = new Set<Id>();
		for(Candidate_Position__c triggerN : triggerNew){
			ids.add(triggerN.Id);
		}
		List<Candidate_Position__c> cps = [SELECT Store_Candidate__c,Store_Position__c FROM Candidate_Position__c WHERE Id=:ids];
		Set<Id> idCandidates = new Set<Id>();
		for(Candidate_Position__c cp : cps){
			if(!String.isEmpty(cp.Store_Candidate__c) && !String.isEmpty(cp.Store_Position__c)){
				idCandidates.add(cp.Store_Candidate__c);
			}
		}
		List<Store_Candidate__c> scs = [SELECT Id,PositionStatus__c FROM Store_Candidate__c WHERE Id=:idCandidates];
		Store_Candidate__c[] storeCandidate = new Store_Candidate__c[]{};
		for(Store_Candidate__c sc : scs){
			storeCandidate.add(new Store_Candidate__c(Id =sc.Id,PositionStatus__c=true));
		}
		upsert storeCandidate;
	}
}