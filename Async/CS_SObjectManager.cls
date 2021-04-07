/**
 * Created by user on 4/6/21.
 */

public inherited sharing class CS_SObjectManager {

    public static SObject getSObjectWithCondition(String sojbectName, Set<String> fieldsToSelect, String condition) {
        if (String.isBlank(sojbectName)) {
            throw new CS_SOjbectManagerException(Constants.NULL_OR_BLANK_PARAM);
        }

        Set<String> fieldsToQuery = (fieldsToSelect == null || fieldsToSelect.isEmpty()) ? new Set<String>{
                'Id'
        } : fieldsToSelect;
        String conditionToQuery = String.isBlank(condition) ? '' : ' ' + Constants.Q_WHERE + ' ' + condition;

        List<SObject> selectedSObject = Database.query(
                Utility.getQueryString(sojbectName, fieldsToQuery) + conditionToQuery
        );

        return selectedSObject.isEmpty() ? null : selectedSObject[0];
    }

    private class CS_SOjbectManagerException extends Exception { }
}