public class AddPrimaryContact implements Queueable {
    private Contact c;
   	private String state;
    public AddPrimaryContact(Contact c , String state){
		this.c = c;
		this.state = state;        
    } 
    public void execute(QueueableContext qc){
        List<Account> accounts = [SELECT id ,name, (SELECT Id,FirstName,LastName From Contacts) From Account WHERE BillingState =:
                                 state LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        for(Account a : accounts){
            Contact cont = c.clone(false,false,false,false);
            cont.AccountId = a.id;
            contacts.add(cont);
        }
        if(contacts.size()>0){
            insert contacts;
        }
    }
}