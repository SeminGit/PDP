public without sharing class MessageManager {

    public static List<Message__c> getMessagesByChannelId(Id channelId) {
        return [
                SELECT
                        Id,
                        Name,
                        Text__c,
                        Contact__c,
                        Messaging_Channel__c
                FROM Message__c
                WHERE Messaging_Channel__c =: channelId
        ];
    }

    public static Message__c createMessage(String text, Id messagingChannelId, Id contactId) {
        if (String.isBlank(text) || String.isBlank(messagingChannelId) || String.isBlank(contactId)) return null;

        Message__c m = new Message__c(
                Text__c = text,
                Messaging_Channel__c = messagingChannelId,
                Contact__c = contactId
        );

        insert m;

        return m;
    }

}