public with sharing class GenericJSONListParser {

        public class JSONParseRequest {
            @InvocableVariable(required=true)
            public String jsonListString;
            
            @InvocableVariable(required=true)
            public String objectType;
        }
    
        @InvocableMethod(label='Parse JSON Data' description='Parse JSON Data for any SObject')
            public static List<List<SObject>> parseJSONData(List<JSONParseRequest> requests) {
            List<List<SObject>> sObjects = new List<List<SObject>>();
            
            for (JSONParseRequest request : requests) {
                String sObjectjsonListString = request.jsonListString;
                String objectType = request.objectType;
                Type sObjectType = Type.forName('List<Schema.' + objectType + '>');
                List<SObject> mySObjectList = (List<SObject>)JSON.deserializeStrict(sObjectjsonListString, sObjectType);
                sObjects.add(mySObjectList);   

            }
        return sObjects;
        }
    }