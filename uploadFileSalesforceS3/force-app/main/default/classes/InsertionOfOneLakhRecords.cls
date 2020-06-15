global class InsertionOfOneLakhRecords implements database.Batchable<Sobject>,database.stateful{
   public integer count = 0;
global database.QueryLocator start(database.BatchableContext bc){
    return database.getQueryLocator('select id, Name FROM Contact');
}
global void execute(database.BatchableContext bc, List<Contact> sobj){
    for(integer j =0;j<10;j++){
            List<Contact> contacts = new List<Contact>();
            for(integer i = 0 ; i < 11000 ;i++){
               Contact c = new Contact(LastName = 'test' + i, Email = 'test@salesforce.com', Phone = '123456');
                contacts.add(c);
            }
            try{
                database.SaveResult[] result = database.insert(contacts);
                }catch(Exception e){
                    System.debug('Exception' + e.getMessage());
                }
        }
}
global void finish(database.BatchableContext bc){
 system.debug('total:'+count);   
  }
}