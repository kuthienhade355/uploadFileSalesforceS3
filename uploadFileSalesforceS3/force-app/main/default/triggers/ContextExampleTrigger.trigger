trigger ContextExampleTrigger on Account (before insert, after insert, after delete) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            System.debug('Beforce');
        } else if (Trigger.isAfter) {
            System.debug('After');
        }        
    }
    else if (Trigger.isDelete) {
       System.debug('delete success');
    }
}