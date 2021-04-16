import {LightningElement, api, track} from 'lwc';
import {DOMService} from "c/domService";
import {EventService} from "c/eventService";

export default class ScooterDescription extends LightningElement {

    ELEMENT_NAMES = {
        GALLERY: 'GALLERY'
    }

    @api
    item;

    @api
    price;


    get Name() {
        if (this.item)
            return this.item.Name;
        return 'Name';
    }

    get Description() {
        if (this.item)
            return this.item.Description;
        return 'Description';
    }

    get Price() {
        if (this.price)
            return this.price;
        return '1000';
    }

    get imageId() {
        if(this.item && this.item.Id){
            return this.item.Id;
        }
    }

    renderedCallback() {
        if(this.item && this.item.Id){
            const galery = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.GALLERY).loadFirstImage(this.imageId);
        }
    }

    @api
    loadItem(item) {
        this.item = item;
    }

    @api
    loadImage(imageId) {
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.GALLERY).loadFirstImage(imageId);
    }

    handleAddToCartClick() {
        EventService.fireAddScooterToCartEvent(this, this.item);
    }

}