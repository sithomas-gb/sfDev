public with sharing class GenericJSONParser {

    public class JSONParseRequest {
        @InvocableVariable(required=true)
        public String jsonString;
        
        @InvocableVariable(required=true)
        public String objectType;
    }

    @InvocableMethod(label='Parse JSON Data' description='Parse JSON Data for any SObject')
        public static List<SObject> parseJSONData(List<JSONParseRequest> requests) {
        List<SObject> sObjects = new List<SObject>();
        
        for (JSONParseRequest request : requests) {
        String sObjectJSONString = request.jsonString;
        String objectType = request.objectType;
        Type sObjectType = Type.forName('Schema.' + objectType);
        SObject mySObject = (SObject)JSON.deserializeStrict(sObjectJSONString, sObjectType);
        sObjects.add(mySObject);
    }
    
    return sObjects;
    }
}