public with sharing class STM_StadiumCC {
    public static void newStadium(){
        Stadium__c newStadium = new Stadium__c(Name='Fly emigrate');
        newStadium.Stadium__c = 'Old Trafford';
        insert newStadium;
        system.debug('Show newStadium' + newStadium.Id);
    }
    public static List<Participate__c> getParticipate(){
        List<Participate__c> stadiums = new List<Participate__c>();
        stadiums = [SELECT Id,Name__c FROM Participate__c];
        return stadiums;
    }
    public static Stadium__c getStadium(Id id){
       return [SELECT Name FROM Stadium__c WHERE Id =:id LIMIT 1];
    }
    public static List<List<SObject>> newSOQL(){
       List<List<SObject>> searchList = [FIND 'SFDC' IN ALL FIELDS 
                                      RETURNING Account(Name), Contact(FirstName,LastName)];
    	return searchList;
    }
}