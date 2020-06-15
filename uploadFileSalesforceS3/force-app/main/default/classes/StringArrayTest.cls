public class StringArrayTest {
	 //public static void generateStringArray(){
       /// Music__c newM = new Music__c(Name='Chay ngay di');
        //newM.Author__c = 'Tran Minh Quan';
        //insert newM;
        //System.debug('info Music' + newM.Id);
    //}
    public static List<String> generateStringArray(Integer n){
     	List<String> myArray = new List<String>();
        for(Integer i=0;i<n;i++){
            myArray.add('Test '+i);
            System.debug(myArray[i]);
        }
        return myArray;
    }
    public static List<Music__c> getMusics(){
		List<Music__c> musics = new List<Music__c>();
        musics = [SELECT Name , Author__c FROM Music__c];
        return musics;
    }
    public static Music__c getMusic(Id id){
        return [SELECT Name, Author__c FROM Music__c WHERE Id=:id Limit 1];
    }
}