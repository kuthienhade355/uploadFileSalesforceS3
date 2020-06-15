public class UpdateParentAccount implements Queueable {
	private List<Account> accounts;
    private ID parent;
    public UpdateParentAccount(List<Account> records , ID id){
        this.accounts = records;
        this.parent = id;
    }
    public void execute(QueueableContext qc){
        for(Account account : accounts){
            account.parentId = parent;
        }
        update accounts;
       List<Account> account = [SELECT id From Account Where billingstate = 'NY'];
        Id parentId = [SELECT id From Account Where name ='ACME Corp'][0].Id;
        UpdateParentAccount updateJob = new UpdateParentAccount(accounts,parentId);
        ID jobID = System.enqueueJob(updateJob);
    }
}