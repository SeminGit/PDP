/**
 * Created by user on 11/27/20.
 */

import {LightningElement, api} from 'lwc';
import { Utility} from "c/utility";
import {DOMService} from "c/domService";

export default class ScooterCharactiristics extends LightningElement {

    @api
    item;

    ELEMENT_NAMES = {
        GALLERY: 'GALLERY',
        INFO: 'INFO'
    }

    get itemGetter() {
        if(this.item === null || this.item === undefined) return null;
        return Utility.createMapFromObjectFields(this.item);
    }
    @api
    loadImage(imageId){
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.GALLERY).loadFirstImage(imageId);
    }

}