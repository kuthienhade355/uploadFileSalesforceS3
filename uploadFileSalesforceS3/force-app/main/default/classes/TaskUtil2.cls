public class TaskUtil2 {
    public static String getTaskPriority(String leadState){
        if(String.isBlank(leadState)||leadState.length()>2){
            return null;
        }
        String taskPriority;
        if(leadState == 'CA'){
            return 'high';
        }else{
            return 'normal';
        }
    }
}