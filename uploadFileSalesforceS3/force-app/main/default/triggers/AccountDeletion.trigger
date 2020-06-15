trigger AccountDeletion on Account (before delete) {
    System.debug('Trigger old'+ Trigger.old);
    System.debug('Trigger new' + Trigger.new);
    for(Account a : [SELECT Id From Account Where Id IN (SELECT AccountId FROM Opportunity) AND Id IN : Trigger.old]){
        Trigger.oldMap.get(a.Id).addError('Cannot delete account with related opportunities.');
    }
}