global class FullCalendarDemo{

    public User_Calendar__c userCalendar {get;set;}

    //public FullCalendarDemo(){
    //  Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
    //  //if(cookie!=null){
    //  //    this.userCalendar = getCustomUser(cookie.getValue()); 
    //  //}
    //}
    
    public String getUserName(){
      Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
      String urlID = cookie.getValue();
      User_Calendar__c userCalendar = [SELECT LoginUserCalendar__r.NameAccount__c
                                               FROM User_Calendar__c
                                               WHERE LoginUserCalendar__c=:urlID Limit 1];
      return userCalendar.LoginUserCalendar__r.NameAccount__c; 
    }

    public PageReference init(){
      Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
      PageReference p = new PageReference('/apex/login');
      if(cookie!=null){
          return null;
      }
      p.setRedirect(true);
      return p;
    }

    public String getCount() {
        Cookie counter = ApexPages.currentPage().getCookies().get('urlID');
        String urlID = counter.getValue();
        return urlID;
    }

    @RemoteAction
    global static List<User_Calendar__c> getEvents(String numberId) {
        //String userId = UserInfo.getUserId() ;
        System.debug('Hello');
        List<User_Calendar__c> userCalendar = [SELECT Id, Name, LoginUserCalendar__r.Name,
                                               Event__c, Event__r.Name,Event__r.Name__c, Event__r.Start_Time__c, Event__r.End_Time__c ,
                                               Event__r.Begin_Time__c, Event__r.Over_Time__c,Event__r.Description__c,Event__r.HourActive__c,Event__r.Hour__c
                                               FROM User_Calendar__c
                                               WHERE LoginUserCalendar__c=:numberId];
        if(userCalendar.size()>0){
            return userCalendar;
        } else{
            //Date myDate = Date.today();
            //Calendar_Event__c calendarEvent = new Calendar_Event__c();
            //calendarEvent.Start_Time__c = myDate;
            //calendarEvent.End_Time__c = myDate;
            //insert calendarEvent;
            //List<User_Calendar__c> userCalendar1 = new List<User_Calendar__c>();
            //userCalendar1.add(new User_Calendar__c(LoginUserCalendar__c = numberId,Event__c=calendarEvent.Id));
            //insert userCalendar1;
            //return userCalendar1;
            return null;
        }
    }
    
    @RemoteAction
    global static List<User_Calendar__c> createOrUpdateEvents(String calendarEvent,String numberId) {
        //Geting Calendar_Event__c object from received Json String
        Calendar_Event__c eventObject = ((Calendar_Event__c) JSON.deserialize(calendarEvent, Calendar_Event__c.class));
        //you need to put proper regex to validate recordId
        Boolean isOldRecord = eventObject.Id != null;
        upsert eventObject;
        //If its new record, create User Calendar record as well
        if(!isOldRecord){
            User_Calendar__c userCalendar = new User_Calendar__c(Event__c=eventObject.Id, LoginUserCalendar__c=numberId);
            insert userCalendar;
        }
        return getEvents(numberId);
        //return null;
    }

    public static String getAccounts() {
        Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
        String urlID = cookie.getValue();
        List<User_Calendar__c> userCalendars = [SELECT Id, Name, LoginUserCalendar__r.Name,LoginUserCalendar__r.NameAccount__c,
                                               Event__c, Event__r.Name, Event__r.Start_Time__c, Event__r.End_Time__c ,Event__r.Name__c,
                                               Event__r.Begin_Time__c, Event__r.Over_Time__c,Event__r.Description__c,Event__r.HourActive__c,Event__r.Hour__c
                                               FROM User_Calendar__c WHERE
                                               LoginUserCalendar__c=:urlID ];
        
       return JSON.serialize(userCalendars);                                
    }

    @RemoteAction
    global static List<User_Calendar__c> getAccount1s(String urlID) {
        List<User_Calendar__c> userCalendars = [SELECT Id, Name, LoginUserCalendar__r.Name,LoginUserCalendar__r.NameAccount__c,
                                               Event__c, Event__r.Name, Event__r.Start_Time__c, Event__r.End_Time__c ,Event__r.Name__c,
                                               Event__r.Begin_Time__c, Event__r.Over_Time__c,Event__r.Description__c,Event__r.HourActive__c,Event__r.Hour__c
                                               FROM User_Calendar__c WHERE
                                               LoginUserCalendar__c=:urlID ];
        return userCalendars;
    }


    //public PageReference getLoginAccount() {
    //    Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
    //    String urlID = cookie.getValue();
    //    PageReference page = new PageReference('/apex/DetailUser');
    //    Cookie c = new Cookie('urlId',urlID,null,-1,false);
    //    page.setCookies(new Cookie[] {c});
    //    page.setRedirect(true);
    //    return page;
    //}
}