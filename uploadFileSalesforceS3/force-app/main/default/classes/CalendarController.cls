public class CalendarController {
    public list <CalendarEvent> events {get;set;}
    //This allows a toggle to show personal events      
    public Boolean includeMyEvents {get;set;}

    //The calendar plugin is expecting dates is a certain format. This string is used to format the dates correctly
    String dtFormat = 'EEE, d MMM yyyy HH:mm:ss z';

    // As Events can be dynamically dragged around the calender variables are used for these selections
    public String eventIdTemp   {get;set;}  //Selected event Id coming from vf page
    public String st    {get;set;}  //Selected event start date
    public String ed    {get;set;} //Selected event end date
    public List <Event> eventList = new List <Event> ();

    public CalendarController() {
       eventList = [Select Id, Subject, isAllDayEvent, StartDateTime, EndDateTime, CreatedDate, LastModifiedDate
                    From Event 
                    Where OwnerId = '005j000000C1f0AAAR' ];
}

//Method to query requested event records and place in calendar    
    public PageReference pageLoad() {
   //     eventList = [SELECT CreatedDate,EndDateTime,IsAllDayEvent,LastModifiedDate,StartDateTime,Subject FROM Event WHERE OwnerId = '005j000000C1f0AAAR'];
        List <CalendarEvent> events = new list <CalendarEvent> ();
            for(Event e : eventList){        
            DateTime startDt = e.StartDateTime;
            DateTime endDt = e.EndDateTime;
            DateTime createdOn = e.CreatedDate; 
            DateTime modifiedOn = e.LastModifiedDate;    
            CalendarEvent newEvent = new CalendarEvent();  
            newEvent.eventId = e.Id; 
            newEvent.eventTitle = e.Subject;
            newEvent.allDay = e.isAllDayEvent;
            newEvent.eventStart = startDt.format(dtFormat);
            newEvent.eventEnd = endDt.format(dtFormat);
            newEvent.url = '/' + e.Id; 
            newEvent.className = 'event-personal';
            events.add(newEvent);
        }
        return null;
    }
//   Parse the date format and set values  
    public void setEvent() {
        List <String> stringParts = ed.split('T');
        List <String> dateParts = stringParts[0].split('-');
        List <String> timeParts = stringParts[1].split(':');  
        DateTime dt1 = DateTime.newInstance(Integer.valueOf(dateParts[0]), Integer.valueOf(dateParts[1]), Integer.valueOf(dateParts[2]), Integer.valueOf(timeParts[0]), Integer.valueOf(timeParts[1]), Integer.valueOf(timeParts[2]));
        stringParts = st.split('T');
        dateParts = stringParts[0].split('-');
        timeParts = stringParts[1].split(':');
        DateTime dt2 =  DateTime.newInstance(Integer.valueOf(dateParts[0]), Integer.valueOf(dateParts[1]), Integer.valueOf(dateParts[2]), Integer.valueOf(timeParts[0]), Integer.valueOf(timeParts[1]), Integer.valueOf(timeParts[2]));
        for(Event e : eventList) {  
            if(e.Id == eventIdTemp) { 
                e.EndDateTime = dt1;
                e.StartDateTime = dt2;
                update e; 
            }
        }
    }
    public class CalendarEvent {

//Variables are set from the CalendarController Class

    public String eventId       {get;set;}
    public String eventTitle    {get;set;}
    public String eventEnd      {get;set;}
    public String eventStart    {get;set;}
    public String eventColor    {get;set;}
    public String url           {get;set;}
    public Boolean allDay       {get;set;}
    public String className     {get;set;}
}
}