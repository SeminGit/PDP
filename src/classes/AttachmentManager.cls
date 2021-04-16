/**
 * Created by user on 11/25/20.
 */

public without sharing class AttachmentManager {

    @AuraEnabled
    public static List<Id> getAttachmentsByParentId(String parentId){
        if(parentId == null || parentId == ''){
            System.debug('Empty input');
            return null;
        }
        List<Attachment> attachmentsToReturn = [SELECT Id FROM Attachment WHERE ParentId =: parentId];
        if(attachmentsToReturn == null || attachmentsToReturn.size() == 0) return null;
        return Utility.getListIdsFromSOBjectCollection(attachmentsToReturn);
    }

}