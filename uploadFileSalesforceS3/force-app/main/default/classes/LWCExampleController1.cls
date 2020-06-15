public inherited sharing class LWCExampleController1 {

    @AuraEnabled
    public static list<Account> readCSVFile(Id idContentDocument){
        list<Account> lstAccsToInsert = new list<Account>();
        if(idContentDocument != null) {
            
            // getting File Data based on document id 
            ContentVersion objVersion = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:idContentDocument];
            // split the file data
            //String blodS = blobToString(objVersion.VersionData,'UTF-8');
            //list<String> lstCSVLines = blodS.split('\n');
            //List<String> lstCSVLines = EncodingUtil.base64Encode(objVersion.VersionData).split('\n');
            //List<String> lstCSVLines = objVersion.VersionData.toString().split('\n');
            Blob csvFileBody = objVersion.VersionData;
            String csvAsString= blobToString(csvFileBody,'UTF-16');
            system.debug('csvAsString' + csvAsString);
            List<String> lstCSVLines= csvAsString.split('\n');
            system.debug('lstCSVLines' + lstCSVLines);
			system.debug('lstCSVLines.size()' + lstCSVLines.size());
            
            for(Integer i = 1; i < lstCSVLines.size(); i++){
                Account objAcc = new Account();
                list<String> csvRowData = lstCSVLines[i].split('\\s+');
                System.debug('csvRowData====> '+csvRowData);
                objAcc.Name = csvRowData[0]; // accName
                objAcc.Industry = csvRowData[1];
                objAcc.Rating = csvRowData[2];
                objAcc.Type = csvRowData[3];
                objAcc.Website = csvRowData[4];
                lstAccsToInsert.add(objAcc);
            }

            try{    
                if(!lstAccsToInsert.isEmpty()) {
                    insert lstAccsToInsert;
                }
            }
            catch (Exception ex) {
                throw new AuraHandledException(ex.getMessage());
            } 
        }
        return lstAccsToInsert;    
    }
    
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
	}
    
    @AuraEnabled
    public static list<Account> getAccountDetail(){
        list<Account> lstAccsToInsert = [SELECT Industry,Name,Rating,Type,Website FROM Account Limit 10000];
        return lstAccsToInsert;
    }
}