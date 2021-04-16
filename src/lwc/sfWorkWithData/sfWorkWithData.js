import {LightningElement, api, wire, track} from 'lwc';
import {getFieldValue} from "lightning/uiRecordApi"
import ID_FIELD from '@salesforce/schema/Opportunity.Id';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import CONTACT_FIELD from '@salesforce/schema/Opportunity.Contact__c';
import {getRecord} from "lightning/uiRecordApi";
import {getObjectInfo} from "lightning/uiObjectInfoApi";
import {refreshApex} from '@salesforce/apex';
import {getMessagesByChannelId} from '@salesforce/apex/MessageService.getMessagesByChannelId'
import getOppProducts from '@salesforce/apex/OpportunityLineItemService.getOLIByOpportunityId'

export default class SfWorkWithData extends LightningElement {

    @api
    channelId;

    @api
    recordId;
    @api
    objectApiName

    fieldsList = [ID_FIELD, NAME_FIELD, CONTACT_FIELD];

    columns = [
        {label: 'Id', fieldName: 'Id'},
        {label: 'Price', fieldName: 'UnitPrice'},
        {label: 'Name', fieldName: 'Name'}
    ];

    messageColumns = [
        {label: 'From', fieldName: 'Member_One__c'},
        {label: 'To', fieldName: 'Member_Two__c'},
        {label: 'Text', fieldName: 'Text__c'}
    ];

    @wire(getObjectInfo, {objectApiName: '$objectApiName'})
    opportunityInfo;

    @wire(getMessagesByChannelId, {channelId: '$channelId'})
    messages;

    @wire(getRecord, {recordId: '$recordId', fields: '$fieldsList'})
    opportunityRecord;

    @wire(getOppProducts, {opportunityId: '$recordId'})
    opportunityProducts;

    get products() {
        console.log(this.opportunityProducts.data);
        return this.opportunityProducts.data;
    }

    get messagesGetter() {
       let data = this.messages.data,
           result = [];

       for (let m of data) {
           console.log(m);
       }

       return result;
    }

    get oppFields() {
        if (!this.opportunityRecord.data) return null;

        let fieldsToReturn = [];

        this.fieldsList.forEach(field => {
            console.log(field);
           fieldsToReturn.push(
               {
                   label: this.opportunityInfo.data.fields[field.fieldApiName].label,
                   value: getFieldValue(this.opportunityRecord.data, field)
               }
           )
        });

        return fieldsToReturn;
    }
}