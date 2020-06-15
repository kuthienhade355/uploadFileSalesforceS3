@isTest
public class UntilClassTest {
	 @isTest static void testCallApi(){
        String pri = UtilClass.getContent();
        System.assertEquals('45.0',pri);
    }
}