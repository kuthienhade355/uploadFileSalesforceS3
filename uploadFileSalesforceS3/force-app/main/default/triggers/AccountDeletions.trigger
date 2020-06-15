trigger AccountDeletions on Account (before insert) {
    for(Account a : [SELECT Id From Account Where Id IN (SELECT AccountId From Opportunity) AND Id IN : Trigger.old]){
        Trigger.oldMap.get(a.Id).addError('Cannot deletion Account related Opportunity');
    }
}