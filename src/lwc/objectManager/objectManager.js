import {LightningElement, api, track} from 'lwc';
import {ApexService} from "c/apexService";
import {FilterWrapper} from "c/filterWrapper";
import {Constants} from 'c/constants';
import {DOMService} from "c/domService";

export default class ObjectManager extends LightningElement {

    ELEMENT_NAMES = {
        LIST_BODY: 'LIST_BODY'
    }
    @api
    objectAPI = 'Product2';
    @api
    filters = null;
    @api
    fields = ['Name', 'Id', '', 'Description'];

    @api
    async handleSlotChange() {
        const body = DOMService.getHTMLElementByDataId(this, this.LIST_BODY),
            list = await ApexService.getProducts(null);
        body.loadItems(list);
    }
}