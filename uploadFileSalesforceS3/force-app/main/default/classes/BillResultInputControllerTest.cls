public class BillResultInputControllerTest {
    // Test Pagination
    public Integer rec { get; set; }
    public Integer tot { get; set; }
    integer totalRecs = 0;
    integer count= 0;
    integer LimitSize= 5;
    public List<wrapAccount> wrapAccountList {get; set;}
     
    public BillResultInputControllerTest(ApexPages.StandardController sc) {
        tot=totalRecs = [select count() from Account];
    }
    public List<Account> leads = new List<Account>();
    public List<wrapAccount> getLeads() {
      wrapAccountList = new List<wrapAccount>();
      for(Account a: [select Id, Name,BillingState, Website, Phone FROM Account LIMIT:limitsize OFFSET:count]) {
          wrapAccountList.add(new wrapAccount(a));
      }
     return wrapAccountList;
    }

    //Update page when click button change page 
    public void updatePage() {
       wrapAccountList.clear();
       limitsize=rec;
       for(Account a: [select Id, Name,BillingState, Website, Phone FROM Account LIMIT:limitsize OFFSET:count]) {
      		wrapAccountList.add(new wrapAccount(a));
       }
    }

    //return page The firstPage     
    public PageReference Firstbtn() {
     count=0;
        return null;
    }

    //return step by step the firstPage 
    public PageReference prvbtn() {
      count=count-limitsize;
        return null;
    }
   
    //return step by step the endPage
    public PageReference Nxtbtn() {
    count=count+limitsize;
    system.debug('count' +count);
        return null;
    }

    //return step by step the lastPage
    public PageReference lstbtn() {
    count= totalrecs - math.mod(totalRecs,LimitSize);
        return null;
    }

    //Condition hiden button the FistPage
    public Boolean getNxt() {
        if((count+ LimitSize) > totalRecs)
        return true;
        else
        return false;
    }

    //Condition hiden button lastPage
     public Boolean getPrv() {
      if(count== 0)
          return true;
        else
          return false;
        }
    // end


    public void initAction() {
        ops = [SELECT id,Name FROM Account Limit 5];
    }
    public System.PageReference saveAction() {
        return null;
    }

    public List<Account> ops{
        get;
        set;
    }

    //Test check box alll
    public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
        public wrapAccount(Account a) {
            acc = a;
            selected = false;
        }
    } 
}