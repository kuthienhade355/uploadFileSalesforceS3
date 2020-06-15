public class CC_CafeHouse {
    public static void newCafeHouse(){
        ProfileCV__c ch = new ProfileCV__c(Name='MinhQuan');
        ch.name__c = 'On Thai Hung';
        ch.address__c = '355 p28 Quan binh Thanh';
        insert ch;
       	System.debug('info cafeHouse' + ch.Id);
    }
    public static List<CafeHouse__c> getCafeHouse(){
        List<CafeHouse__c> cafes = new List<CafeHouse__c>();
        cafes = [SELECT Name,Cafe__c FROM CafeHouse__c];
        return cafes;
    }
    
    public static List<ProfileCV__c> getProfileCV(){
        List<ProfileCV__c> cafes = new List<ProfileCV__c>();
        cafes = [SELECT name__c,address__c,email__c,phone__c,website__c FROM ProfileCV__c LIMIT 1];
        return cafes;
    }
}