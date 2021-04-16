import {LightningElement, api, track} from 'lwc';
import {ApexService} from "c/apexService";
import {FilterWrapper} from "c/filterWrapper";
import {Constants} from 'c/constants';
import {DOMService} from "c/domService";

export default class ProductLoadAndDisplay extends LightningElement {

    ELEMENT_NAMES = {
        LIST_BODY: 'LIST_BODY'
    }

    renderedCallback() {
        this.loadData(null);
    }

    @api
    async loadData(filters) {
        console.log('loader' + filters);
        const body = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.LIST_BODY),
            list = await ApexService.getProducts(filters);
        body.loadItems(list);
    }
}