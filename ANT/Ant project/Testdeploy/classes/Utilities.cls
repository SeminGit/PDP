public without sharing class Utilities {
    /**
     * @param objects List of SObjects to get field values from.
     * @param fieldName Name of the field to get value from.
     *
     * @return List of Strings with values from "fieldName" field of each object. Bad parameters return empty List.
     */
    public static List<String> getFieldValuesFromList(List<SObject> objects, String fieldName) {
        List<String> result = new List<String>();

        if (objects == null || objects.isEmpty() || String.isBlank(fieldName)) return result;

        for (SObject obj : objects) {
            if (obj.get(fieldName) != null) {
                result.add(String.valueOf(obj.get(fieldName)));
            }
        }

        return result;
    }
    /**
     * @param objects List of SObjects to get field values from.
     * @param keyFieldName Name of the field that's value will be placed in Key of the Map. No field => skip.
     * @param valueFieldName Name of the field that's values will be placed in Value of the Map. No field => skip.
     *
     * @return Returns a Map of strings, where KEY = value from "keyFieldName" field and VALUE = value from "valueFieldName" field. Bad parameters return empty Map.
     */
    public static Map<String, String> getMapFieldToFieldFromList(List<SObject> objects, String keyFieldName, String valueFieldName) {
        Map<String, String> result = new Map<String, String>();

        if (objects == null || objects.isEmpty() || String.isBlank(keyFieldName) || String.isBlank(valueFieldName)) return result;

        for (SObject obj : objects) {
            if (obj.get(keyFieldName) != null && obj.get(valueFieldName) != null) {
                result.put(String.valueOf(obj.get(keyFieldName)), String.valueOf(obj.get(valueFieldName)));
            }
        }

        return result;
    }
}
