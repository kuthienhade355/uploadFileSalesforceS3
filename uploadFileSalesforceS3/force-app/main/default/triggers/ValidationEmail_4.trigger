trigger ValidationEmail_4 on Participate__c (before update) {
	Handle.handleUpdateParticipateEmail(trigger.new,trigger.old);
    Handle.handleUpdateParticipatePhone(trigger.new,trigger.old);
    Handle.handleUpdateParticipateCompany(trigger.new,trigger.old);
}