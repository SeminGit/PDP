import {LightningElement, api, track} from 'lwc';
import {getMessagingChannelByMemberIds} from '@salesforce/apex/MessagingChannelService.getMessagingChannelByMemberIds';

export default class Chat extends LightningElement {

    @api
    channelId;

    //@wire(getMessagingChannelByMemberIds,
}