public with sharing class samplePagerCtrl {
   @AuraEnabled
 public static AccountPagerWrapper fetchAccount(Decimal pageNumber ,Integer recordToDisply) {
      Integer pageSize = recordToDisply;
      Integer offset = ((Integer)pageNumber - 1) * pageSize;
    AccountPagerWrapper obj =  new AccountPagerWrapper(); 
        obj.pageSize = pageSize;
        obj.page = (Integer) pageNumber;
        obj.total = [SELECT count() FROM account];
        obj.accounts = [SELECT Id, Name,Phone FROM Account ORDER BY Name LIMIT :recordToDisply OFFSET :offset];
        return obj;
     }
 public class AccountPagerWrapper {
    @AuraEnabled public Integer pageSize {get;set;}
    @AuraEnabled public Integer page {get;set;}
    @AuraEnabled public Integer total {get;set;}
    @AuraEnabled public List<Account> accounts {get;set;}
   }
}