public inherited sharing class Utilities {

    public static Integer getIntFromString(String value) {
        if (String.isBlank(value)) {
            return null;
        }

        return Integer.valueOf(value);
    }

    public static Boolean canEditFields(String objectType, Set<String> fieldNames) {
        if (String.isBlank(objectType) || fieldNames == null || fieldNames.isEmpty()) {
            throwCustomException(Constants.NULL_OR_EMPTY_PARAM);
        }

        Map<String, SObjectField> nameToField = getSObjectTokenByName(objectType).fields.getMap();

        for (String fieldName : fieldNames) {
            if (nameToField.get(fieldName) == null) {
                throwCustomException(String.format(Constants.NO_FIELD_ON_OBJECT_PATTERN, new String[]{fieldName, objectType}));
            }
            if (!nameToField.get(fieldName).getDescribe().isUpdateable()) {
                return false;
            }
        }

        return true;
    }

    public static DescribeSObjectResult getSObjectTokenByName(String objectType) {
        if (String.isBlank(objectType)) {
            throwCustomException(Constants.NULL_OR_EMPTY_PARAM);
        }

        List<DescribeSObjectResult> foundObjectTypes =  Schema.describeSObjects(new List<String>{
                objectType
        });

        return foundObjectTypes[0];
    }

    public static void throwCustomException(String message) {
        throw new CustomException(message);
    }

    private class CustomException extends Exception {
    }
}