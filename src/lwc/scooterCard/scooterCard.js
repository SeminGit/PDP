import {LightningElement, api} from 'lwc';
import {DOMService} from 'c/domService';
import {ApexService} from "c/apexService";
import {EventService} from "c/eventService";

export default class ScooterCard extends LightningElement {

    ELEMENT_NAMES = {
        IMAGE: 'IMAGE',
        NAME: 'NAME',
        PRICE: 'PRICE'
    }
    @api
    item;

    @api
    price;

    get Id() {
        if (this.item && this.item.Id)
            return this.item.Id;
    }

    get Name() {
        if (this.item && this.item.Name)
            return this.item.Name;
    }

    get Price() {
        if (this.price)
            return this.price;
    }

    @api
    imageId = '00P5g0000011zQCEAY';

    renderedCallback() {
        this.loadImage(this.Id);
    }

    @api
    async loadImage(attachmentParentId) {
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.IMAGE).displayImage(
            await ApexService.getFirstAttachedImageURL(attachmentParentId)
        );
    }

    @api
    async loadImages(attachmentParentId) {
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.IMAGE).displayImages(
            await ApexService.getAttachedImageURLs(attachmentParentId)
        );
    }

    handleClick() {
        EventService.fireScooterSelectedEvent(this, this.item, this.price);
       // EventService.fireAddScooterToCartEvent(this,this.item);
    }

}