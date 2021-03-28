@IsTest
public with sharing class UtilitiesTest {
    private static final String EMPTY_PARAM_ERROR_MESSAGE = 'One of the method parameters is NULL or Empty';

    @IsTest
    static void testGetFieldValuesFromList_Positive() {
        List<Account> objectsToGetFrom = new List<Account>{
                new Account(Name = 'testName1'),
                new Account(Name = 'testName2')
        };
        String fieldName = 'Name';
        List<String> expectedResult = new List<String>{
                'testName1', 'testName2'
        };
        List<String> result = new List<String>();

        Test.startTest();
            result = Utilities.getFieldValuesFromList(objectsToGetFrom, fieldName);
        Test.stopTest();

        System.assertEquals(expectedResult, result);
    }

    @IsTest
    static void testGetFieldValuesFromList_EmptyParams() {
        List<Account> objectsToGetFrom = new List<Account>{
                new Account(Name='testName')
        };
        String fieldName = 'Name';

        System.assert(Utilities.getFieldValuesFromList(null, fieldName).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getFieldValuesFromList(new List<Account>(), fieldName).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getFieldValuesFromList(objectsToGetFrom, '').isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getFieldValuesFromList(objectsToGetFrom, null).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
    }

    @IsTest
    static void testGetFieldValuesFromList_NoField() {
        List<Account> objectsToGetFrom = new List<Account>{
                new Account(),
                new Account(Name = 'testName2')
        };
        String fieldName = 'Name';
        List<String> expectedResult = new List<String>{
                'testName2'
        };
        List<String> result = new List<String>();

        Test.startTest();
            result = Utilities.getFieldValuesFromList(objectsToGetFrom, fieldName);
        Test.stopTest();

        System.assertEquals(expectedResult, result);
    }

    @IsTest
    static void testgetMapFieldToFieldFromList_Positive() {
        List<Account> objectsToGetFrom = new List<Account>{
                new Account(Name = 'testName1', Description = 'testDescription1'),
                new Account(Name = 'testName2', Description = 'testDescription2')
        };
        String keyFieldName = 'Name';
        String valueFieldName = 'Description';
        Map<String, String> result;
        Map<String, String> expectedResult = new Map<String, String>{
                'testName1' => 'testDescription1',
                'testName2' => 'testDescription2'
        };

        Test.startTest();
            result = Utilities.getMapFieldToFieldFromList(objectsToGetFrom, keyFieldName, valueFieldName);
        Test.stopTest();

        System.assertEquals(expectedResult, result);
    }

    @IsTest
    static void testgetMapFieldToFieldFromList_EmptyParams() {
        List<Account> objectsToGetFrom = new List<Account>{
                new Account(Name='testName', Description = 'testDescription')
        };
        String keyFieldName = 'Name';
        String valueFieldName = 'Description';

        System.assert(Utilities.getMapFieldToFieldFromList(null, keyFieldName, valueFieldName).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getMapFieldToFieldFromList(new List<Account>(), keyFieldName, valueFieldName).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getMapFieldToFieldFromList(objectsToGetFrom, '', valueFieldName).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getMapFieldToFieldFromList(objectsToGetFrom, null, valueFieldName).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getMapFieldToFieldFromList(objectsToGetFrom, keyFieldName, '').isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
        System.assert(Utilities.getMapFieldToFieldFromList(objectsToGetFrom, keyFieldName, null).isEmpty(), EMPTY_PARAM_ERROR_MESSAGE);
    }

    @IsTest
    static void testgetMapFieldToFieldFromList_NoKeyField() {
        List<Account> objectsToGetFrom = new List<Account>{
                new Account(Description = 'testDescription')
        };
        String keyFieldName = 'Name';
        String valueFieldName = 'Description';
        Map<String, String> result;

        Test.startTest();
            result = Utilities.getMapFieldToFieldFromList(objectsToGetFrom, keyFieldName, valueFieldName);
        Test.stopTest();

        System.assert(result.isEmpty());
    }

    @IsTest
    static void testgetMapFieldToFieldFromList_NoValueField() {
        List<Account> objectsToGetFrom = new List<Account>{
                new Account(Name = 'testName')
        };
        String keyFieldName = 'Name';
        String valueFieldName = 'Description';
        Map<String, String> result;

        Test.startTest();
            result = Utilities.getMapFieldToFieldFromList(objectsToGetFrom, keyFieldName, valueFieldName);
        Test.stopTest();

        System.assert(result.isEmpty());
    }
}
