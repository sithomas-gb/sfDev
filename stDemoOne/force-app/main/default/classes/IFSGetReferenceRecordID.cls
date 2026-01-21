global with sharing class IFSGetReferenceRecordID implements Callable {

    // Dispatch actual methods
   public Object call(String action, Map<String, Object> args) {
       
       Map<String, Object> input = (Map<String, Object>)args.get('input');
       Map<String, Object> output = (Map<String, Object>)args.get('output');
       Map<String, Object> options = (Map<String, Object>)args.get('options');

       return invokeMethod(action, input, output, options);
   }
    
    private Object invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options) 
    {
        Boolean result = true; 
        try
        {
            if(methodName.equals('getReferenceRecordId'))
            {
                Id IFSId = (Id) inputMap.get('IFSId');
                String ReferenceRecordId = getReferenceRecordId(IFSId);
                
                outMap.put('ReferenceRecordId', ReferenceRecordId);
            }
        }
        catch(System.Exception e)
        {
            result = false;
        }
        
        return result;
    }
    
    private String getReferenceRecordId(Id IFSId) {
      IntakeFormSection ifs = [SELECT ReferenceRecordId FROM IntakeFormSection WHERE Id = :IFSId LIMIT 1];

    String ReferenceRecordId = (String) ifs.get('ReferenceRecordId');
        
        return ReferenceRecordId;
    }
}