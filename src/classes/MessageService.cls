public class MessageService {

    @AuraEnabled
    public static List<Message__c> getMessagesByChannelId(Id channelId) {
        if (String.isBlank(channelId)) return null;

        return MessageManager.getMessagesByChannelId(channelId);
    }

}