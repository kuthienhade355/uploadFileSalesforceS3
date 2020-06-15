trigger ValidationEmail_3 on Participate__c (before insert) {
	 try{
        Participate__c p = [SELECT Email__c FROM Participate__c Where Email__c =: trigger.new[0].Email__c LIMIT 1];
        for(Participate__c a : trigger.new){
            if(a.Email__c == p.Email__c)
            {
              a.addError('Email already exist');
            }
        }
    }catch(Exception e){
        e.getMessage();
    }
}