public class FlowRecordTypeUtils {
    @InvocableMethod (label = 'Get Record Type Name' description = 'Retrieve record type name for the specified record id')
    public static List<String> getRecordTypeName(List<Id> ids) 
    {
        Id recId = ids[0];
        System.debug('recId=' + recId);
        String objName = recId.getSobjectType().getDescribe().getName();

        String queryStr = 'SELECT Id, RecordType.DeveloperName FROM ' + objName + ' WHERE Id = \'' + recId + '\'';
        System.debug(queryStr);

        SObject obj = Database.query(queryStr);
        System.debug('obj = ' + JSON.serialize(obj));

        List<String> retName = new List<String>();
        retName.add((String)obj.getSObject('RecordType').get('DeveloperName'));
        return retName;
    }

    public static void test()
    {
        List<Id> ids = new List<Id>();
        Id testId = Id.valueOf('5003x00002MXEOUAA5');
        ids.add(testId);

        List<String> retList = getRecordTypeName(ids);
        System.debug('Output = ' + JSON.serialize(retList));
    }
}