/**
 * Created by user on 11/25/20.
 */

public without sharing class AttachmentService {

    @AuraEnabled(Cacheable=true)
    public static List<Id> getAttachmentsByParentId(String parentId){
        return AttachmentManager.getAttachmentsByParentId(parentId);
    }

}