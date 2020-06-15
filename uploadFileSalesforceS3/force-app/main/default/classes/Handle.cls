public class Handle {
    public static void handleUpdateParticipateEmail(List<Participate__c> triggerNew,List<Participate__c> triggerOld){
        try{
           Participate__c a = [SELECT Email__c FROM Participate__c Where Email__c =: triggerNew[0].Email__c];
           for(Participate__c b : triggerOld){
               if((b.Email__c.length() - a.Email__c.length())!=0){
                    for(Participate__c c : triggerNew){
                        c.addError('Email already exist');
                        break;
                    }
               }
           }
        }catch(Exception e){
            e.getMessage();
        }
    }
    public static void handleUpdateParticipatePhone(List<Participate__c> triggerNew,List<Participate__c> triggerOld){
       	Set<String> phoneSet = new Set<String>();
         for(Participate__c p : triggerNew){
             phoneSet.add(p.Phone__c);
         }
        Try{
              List<Participate__c>  participates = new List<Participate__c>();
         participates = [SELECT Phone__c FROM Participate__c WHERE Phone__c IN : phoneSet];
           for(Participate__c b : triggerOld){
               for(Participate__c participate : participates){
                   if(b.Phone__c != participate.Phone__c){
                  for(Participate__c participateTrigger : triggerNew){
                    for(Participate__c participateList : participates){
                        if(participateTrigger.Phone__c == participateList.Phone__c){
                          participateTrigger.addError('Phone Already Exist');
                      }
                          break;
                        } 
                   }
                       break;
               }
               }
           }
        }catch(Exception e){
            e.getMessage();
        }
       
    }
     public static void handleUpdateParticipateCompany(List<Participate__c> triggerNew,List<Participate__c> triggerOld){
         Set<String> companySet = new Set<String>();
         for(Participate__c p : triggerNew){
             companySet.add(p.CompanyName__c);
         }
         
         List<Participate__c>  participates = new List<Participate__c>();
         participates = [SELECT CompanyName__c FROM Participate__c WHERE CompanyName__c IN : companySet];
           for(Participate__c b : triggerOld){
               for(Participate__c participate : participates){
                   if((b.CompanyName__c.length() - participate.CompanyName__c.length())!=0){
                  	for(Participate__c participateTrigger : triggerNew){
                    for(Participate__c participateList : participates){
                        if(participateTrigger.CompanyName__c == participateList.CompanyName__c){
                          participateTrigger.addError('Company Already Exist');
                      }
                          break;
                        } 
                   }
                       break;
               	}
               }
           }
    }
}