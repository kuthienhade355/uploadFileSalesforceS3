@isTest
public class TaskUtil2Test {
    @isTest static void testTaskPriorityInvalid(){
        String pri = TaskUtil2.getTaskPriority('NY');
        System.assertEquals('normal', pri);
    }
    
    @isTest static void testTaskPriority(){
        String pri = TaskUtil2.getTaskPriority('NYC');
        System.assertEquals(null,pri);
    }
    
    @isTest static void testTaskHighPriority(){
        String pri = TaskUtil2.getTaskPriority('CA');
        System.assertEquals('high',pri);
    }
   
    
}