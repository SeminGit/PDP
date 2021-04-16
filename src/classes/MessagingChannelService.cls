public class MessagingChannelService {

    @AuraEnabled
    public static Messaging_Channel__c getMessagingChannelByMemberIds(Id memberOne, Id memberTwo) {
        if (String.isBlank(memberOne) || String.isBlank(memberTwo)) return null;

        return MessagingChannelManager.getMessagingChannelByMemberIds(memberOne, memberTwo);
    }
}