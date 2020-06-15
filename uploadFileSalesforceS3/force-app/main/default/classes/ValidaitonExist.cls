public class ValidaitonExist {
    public static boolean hasSObjectField(String fieldName, SObject so){
      return so.getSobjectType().getDescribe().fields.getMap().keySet().contains(fieldName);
    }
}