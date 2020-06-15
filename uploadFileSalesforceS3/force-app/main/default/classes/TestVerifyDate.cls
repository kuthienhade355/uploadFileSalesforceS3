@isTest
private class TestVerifyDate {
    @isTest
    static  void TestVerifyDate1() {
        //check for date2 being in the past
        Date day1 = Date.newInstance(2015, 1, 11);
        Date day2 = Date.newInstance(2015, 1, 10);
        Date date_res1 = VerifyDate.CheckDates(day1,day2);
        system.debug(date_res1+' Run1: Date1: ' + day1+ 'Date2: ' + day2);
    }  
   
    @isTest
    static  void TestVerifyDate2() {
        //check that date2 is within (>=) 30 days of date1
        Date day1 = Date.newInstance(2015, 1, 10);
        Date day2 = Date.newInstance(2015, 1, 15);
       
        Date date_res1 = VerifyDate.CheckDates(day1,day2);
        system.debug(date_res1+' Run1: Date1: ' + day1+ 'Date2: ' + day2);    }
   @isTest
    static  void TestVerifyDate3() {
        //else
        Date day1 = Date.newInstance(2015, 1, 10);
        Date day2 = Date.newInstance(2015, 2, 17);
       
        Date date_res1 = VerifyDate.CheckDates(day1,day2);
        system.debug(date_res1+' Run1: Date1: ' + day1+ 'Date2: ' + day2);
    }
}