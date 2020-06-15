public class ApplicationMisicCC {
    public static void newMucsic(){
        Music__c newM = new Music__c(Name='Chay ngay di');
        newM.Author__c = 'Tran Minh Quan';
        insert newM;
        System.debug('info Music' + newM.Id);
    }
    public static List<Music__c> getMusics(){
		List<Music__c> musics = new List<Music__c>();
        musics = [SELECT name , Author__c FROM Music__c];
        return musics;
    }
    public static Music__c getMusic(Id id){
        return [SELECT name, Author__c FROM Music__c WHERE Id=:id Limit 1];
    }
}