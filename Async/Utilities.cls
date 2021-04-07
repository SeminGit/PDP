public inherited sharing class Utilities {

    public static Integer getIntFromString(String value) {
        if (String.isBlank(value)) {
            return null;
        }

        return Integer.valueOf(value);
    }

    public static void throwCustomException(String message) {
        throw new CustomException(message);
    }

    private class CustomException extends Exception {}
}