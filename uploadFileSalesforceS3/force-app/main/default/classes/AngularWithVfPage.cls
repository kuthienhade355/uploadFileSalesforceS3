public with sharing class AngularWithVfPage {
	public static String getAccounts1(){
       return JSON.serialize([SELECT Id,Name,Phone,Description,AccountNumber FROM account ]); 
   	}
   	
    public static String getAllAccounts() {    
       return JSON.serialize([SELECT Id,Name,Phone,Description,AccountNumber FROM account ]); 
    }
   	private integer counter=0; 
   	private integer list_size=10; 
   	public integer total_size; 
   	public AngularWithVfPage() {
  		 total_size = [SELECT count() FROM Account];
  		 System.debug('1'  + total_size);
	}
   public Account[] getAccounts() {
      try {
         Account[] accounts = [SELECT Id, Name, AccountNumber,Phone,Description FROM Account ORDER BY AccountNumber LIMIT :list_size OFFSET :counter];
         return accounts;
      } catch (Exception e) {
         e.getMessage(); 
         return null;
      }
   }
   public PageReference Beginning() { 
      counter = 0;
      return null;
   }
   public PageReference Previous() { 
      counter -= list_size;
      return null;
   }
   public PageReference Next() { 
      counter += list_size;
      return null;
   }
   public PageReference End() { 
      counter = total_size - math.mod(total_size, list_size);
      return null;
   }
   public Boolean getDisablePrevious() {
      if (counter>0) return false;
      else return true;
   }
   public Boolean getDisableNext() { 
      if (counter + list_size < total_size) return false; else return true;
   }
   public Integer getTotal_size() {
      return total_size;
   }
   public Integer getPageNumber() {
      return counter/list_size + 1;
   }
   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }

}