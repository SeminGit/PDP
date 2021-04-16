public class MessagingChannelManager {

    public static Messaging_Channel__c getMessagingChannelByMemberIds(Id memberOne, Id memberTwo) {
        if (String.isBlank(memberOne) || String.isBlank(memberTwo)) return null;

        List<Messaging_Channel__c> channelToReturn = [
                SELECT
                        Id,
                        Name,
                        Member_One__c,
                        Member_Two__c
                FROM Messaging_Channel__c
                WHERE Member_Two__c = :memberTwo
                OR Member_One__c =:memberOne
                LIMIT 1
        ];

        if (channelToReturn.isEmpty()) {
            return createMessagingChannel(memberOne, memberTwo);
        }

        return channelToReturn[0];
    }

    public static Messaging_Channel__c createMessagingChannel(Id memberOne, Id memberTwo) {
        if (String.isBlank(memberOne) || String.isBlank(memberTwo)) return null;

        Messaging_Channel__c mc = new Messaging_Channel__c(
                Member_One__c = memberOne,
                Member_Two__c = memberTwo
        );

        insert mc;

        return mc;
    }
}