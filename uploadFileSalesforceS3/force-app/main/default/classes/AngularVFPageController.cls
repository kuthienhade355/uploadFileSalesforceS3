public with sharing class AngularVFPageController {
 public String RecordId {get;set;} 
 public List<String> strid{get;set;}
   public class Accountwrap{        
        public string id;
        public string name;
        public string Phone;       
        public string accnumber;        
        public Accountwrap(){            
        }        
    }       
   
    public static String getlstAccount() {
      List<Accountwrap> lstwrap = new List <Accountwrap>();           
      List<account> lstacc = [SELECT Id, Name,AccountNumber,Phone FROM Account];
        for (Account a: lstacc) {
            Accountwrap awrap = new Accountwrap();
            awrap.id = a.id;
            awrap.name =(a.name!=null)?a.name:'--';
            awrap.accnumber=(a.AccountNumber !=null)?a.AccountNumber:'--';
            awrap.Phone=(a.Phone !=null)?a.Phone:'--';         
            lstwrap.add(awrap);        }
        return JSON.serialize(lstwrap);
     }
     
     @RemoteAction
     public static boolean getRecord(String RecordIds){
         if(!String.isEmpty(RecordIds)){   
             String [] str=RecordIds.split('-');
             delete [Select Id from Account where Id in :str];                  
         } 
         return true;     
     }
     
     public void deleteRecord(){
          if(!String.isEmpty(RecordId)){ 
              String [] str=RecordId.split('-');
              delete [Select Id from Account where Id in : str];
          }
     }

}