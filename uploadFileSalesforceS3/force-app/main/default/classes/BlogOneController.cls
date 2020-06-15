public with sharing class BlogOneController{ 
        public class AccountWrap {
                AccountWrap() {
                        Website = 'http://bigmoonblack.github.io';
                        Description = '';
                        Phone = '';
                        Type = '';

                }
                public string name;
                public string Website;
                public string Description;
                public string Phone;
                public string Type;
                public string id;
        }
        public static String getAccounts() {
                List <AccountWrap> lstwrap = new List <AccountWrap>();
                List <account> acounts = [SELECT id, Name, Phone, Type, Website, Description FROM Account ];
                for (Account a: acounts) {
                        AccountWrap awrap = new AccountWrap();
                        awrap.name = a.name;
                        awrap.id = a.id ;
                        if (a.Website != null) {
                                awrap.Website = a.Website;
                        }
                        if (a.Phone != null) {
                                awrap.Phone = a.Phone;
                        }
                        if (a.Type != null) {
                                awrap.Type = a.Type;
                        }
                        if (a.Description != null) {
                                awrap.Description = a.Description;
                        }
                        lstwrap.add(awrap);
                }
                return JSON.serialize(lstwrap);
        }

        @RemoteAction
        public static Account deleteAccount(String name){
                Delete [SELECT id FROM Account Where id =: name];
                return null;
        }

        @RemoteAction
        public static Account saveAccount(String name,string description,string phone,string types,String website){
                Account account = new Account(Name=name);
                account.description = description;
                account.phone = phone;
                account.type = types;
                account.website = website;
                insert account;
                return null;
        }

        @RemoteAction
        public static Account saveEditAccount(ID ids,String name,string description,string phone,string types,String website){
                Account account = [SELECT Name,description ,phone, type,website FROM Account WHERE id=:ids];
                account.Name=name;
                account.description = description;
                account.phone = phone;
                account.type = types;
                account.website = website;
                update account;
                return null;
        }

        
        //private integer counter=0; 
        //private integer list_size=10; 
        //public integer total_size; 
        //public BlogOneController() {
        //         total_size = [SELECT count() FROM Account];
        //}
        //   public Account[] getAccounts2() {
        //      try {
        //         Account[] accounts = [SELECT Name, Phone, Type, Website, Description FROM Account ORDER BY Name LIMIT :list_size OFFSET :counter];
        //         return accounts;
        //      } catch (Exception e) {
        //         e.getMessage(); 
        //         return null;
        //      }
        //   }
        //   public PageReference Beginning() { 
        //      counter = 0;
        //      return null;
        //   }
        //   public PageReference Previous() { 
        //      counter -= list_size;
        //      return null;
        //   }
        //   public PageReference Next() { 
        //      counter += list_size;
        //      return null;
        //   }
        //   public PageReference End() { 
        //      counter = total_size - math.mod(total_size, list_size);
        //      return null;
        //   }
        //   public Boolean getDisablePrevious() {
        //      if (counter>0) return false;
        //      else return true;
        //   }
        //   public Boolean getDisableNext() { 
        //      if (counter + list_size < total_size) return false; else return true;
        //   }
        //   public Integer getTotal_size() {
        //      return total_size;
        //   }
        //   public Integer getPageNumber() {
        //      return counter/list_size + 1;
        //   }
        //   public Integer getTotalPages() {
        //      if (math.mod(total_size, list_size) > 0) {
        //         return total_size/list_size + 1;
        //      } else {
        //         return (total_size/list_size);
        //      }
        //   }
   
}