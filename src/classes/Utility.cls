public without sharing class Utility {
    class NullOrBlankParamException extends Exception { }

    public static Set<Id> getSetIdsFromSOBjectCollection(List<SObject> collection){
        Set<Id> idsToReturn = new Set<Id>();

        for(SObject obj : collection){
            idsToReturn.add(obj.Id);
        }

        return idsToReturn;
    }

    public static List<Id> getListIdsFromSOBjectCollection(List<SObject> collection){
        List<Id> idsToReturn = new List<Id>();

        for(SObject obj : collection){
            idsToReturn.add(obj.Id);
        }

        return idsToReturn;
    }

    public static Set<Id> getSetIdsFromSOBjectCollection(Set<SObject> collection){
        Set<Id> idsToReturn = new Set<Id>();

        for(SObject obj : collection){
            idsToReturn.add(obj.Id);
        }

        return idsToReturn;
    }

    public static List<Id> getListIdsFromSOBjectCollection(Set<SObject> collection){
        List<Id> idsToReturn = new List<Id>();

        for(SObject obj : collection){
            idsToReturn.add(obj.Id);
        }

        return idsToReturn;
    }

    public static Set<String> getFieldsUserHasAccessTo(Set<String> fields, String objectName){
        Set<String> fieldsToReturn = new Set<String>();
        Schema.SObjectType type = Schema.getGlobalDescribe().get(objectName);
        Map<String, Schema.SObjectField> fieldsMap = type.getDescribe().fields.getMap();

        for(String key : fieldsMap.keySet()){
            Schema.SObjectField value = fieldsMap.get(key);

            if(value.getDescribe().isAccessible() && fields.contains(value.getDescribe().name)){
                fieldsToReturn.add(value.getDescribe().name);
            }
        }

        return null;
    }

    public static void throwNullOrBlankParamException(){
        throw new NullOrBlankParamException(Constants.NULL_OR_BLANK_PARAM);
    }

    public static String getQueryString(String objectName, Set<String> fields) {
        if (String.isBlank(objectName) || fields == null || fields.isEmpty()) return '';

        return Constants.Q_SELECT + ' ' + String.join(new List<String> (fields), ',') + ' ' + Constants.Q_FROM + ' ' + objectName;
    }

    public static String wrapToQuotes(String stringToWrap) {
        if (String.isBlank(stringToWrap)) {
            return '';
        }

        return '\'' + stringToWrap + '\'';
    }
}