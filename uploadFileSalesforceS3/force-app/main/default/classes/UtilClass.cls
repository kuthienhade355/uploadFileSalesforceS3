public class UtilClass {
    
    
    public static String getContent() {
        try{
        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm(); //Get url org 
        String url = baseUrl + '/services/data';
        Http h = new Http();       // Instantiate a new http object
        HttpRequest req = new HttpRequest();   // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        req.setEndpoint(url);
        String username = 'torres851995@resourceful-moose-487666.com';
        String password = 'Quanvipro12345';
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setMethod('GET');
        req.setHeader('Authorization', authorizationHeader);
        HttpResponse res = h.send(req);         // Send the request, and return a response
        system.debug('body' + res.getBody());
        //dom.Document doc = res.getBodyDocument();
        //dom.XmlNode location = doc.getRootElement().getChildElement('result',null).getChildElement('geometry',null).getChildElement('location',null);         
        //system.debug('location->'+location);
        
        // returns "[{"Account":{"SFFieldNames":["Industry","Type"]}},{"Addresses":{"SFFieldNames":["Coordinates__c"]}}]"
        List<Object> results = (List<Object>)JSON.deserializeUntyped(res.getBody());
        List<WrapperEmailDetail.wrapperObject> jsonTicket = (List<WrapperEmailDetail.wrapperObject>)JSON.deserialize(res.getBody(), List<WrapperEmailDetail.wrapperObject>.class);
        List<String> versions = new List<String>();
        integer i = -1;
        for(WrapperEmailDetail.wrapperObject result : jsonTicket){
            i++;
            versions.add(result.version);
        }
        system.debug('i'+i);
        system.debug('versions'+versions[i]);
        system.debug('jsonTicket'+jsonTicket[i].version);
        return jsonTicket[i].version;
        }catch(Exception e){
            return e.getMessage();
        }
       
    }

	public static double callApiClass(String nameClass){
        ApexClass apexClass = [SELECT name,APIversion From ApexClass Where name =: nameClass];
        system.debug('apexClass' + apexClass.APIversion);
    	return apexClass.ApiVersion;
    }
    
    public static void baseUrl(){
        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
		System.debug('baseUrl =' + baseUrl);
    }
}