trigger ValidationEmail on Participate__c (before insert) {
    try{
        Participate__c p = [SELECT phone__c FROM Participate__c Where phone__c=: trigger.new[0].phone__c LIMIT 1];
        for(Participate__c a : trigger.new){
            if(a.phone__c == p.phone__c)
            {
              a.addError('phone already exist');
            }
        }
    }catch(Exception e){
        System.debug(e.getMessage());
    }
}