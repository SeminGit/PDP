import {EventService} from "c/eventService";

import {LightningElement, api} from 'lwc';
import {DOMService} from "c/domService";
import PageManager from "c/pageManager";

export default class ScooterInfoPage extends LightningElement {

    ELEMENT_NAMES = {
        DESCRIPTION: 'DESCRIPTION',
        DESCRIPTION_BUTTON: 'DESCRIPTION_BUTTON',
        DESCRIPTION_BODY: 'DESCRIPTION_BODY',
        GALLERY: 'GALLERY',
        GALLERY_BUTTON: 'GALLERY_BUTTON',
        GALLERY_BODY: 'GALLERY_BODY',
        CHARACTERISTICS: 'CHARACTERISTICS',
        CHARACTERISTICS_BUTTON: 'CHARACTERISTICS_BUTTON',
        CHARACTERISTICS_BODY: 'CHARACTERISTICS_BODY',
        PAGE_MANAGER: 'PAGE_MANAGER'
    }
    @api
    item;

    @api
    price;

    get Name(){
        if(this.item && this.item.Name){
            return this.item.Name;
        }
    }

    get itemGetter() {
        if (this.item != null || !this.item)
            return this.item;
    }

    get itemPrice() {
        if(this.price){
            return this.price;
        }
    }

    connectedCallback() {
        this.addEventListener(EventService.EVENT_TYPES.NAVIGATION, this.handleNavigation);
    }

    renderedCallback() {
        this.handleNavigation(EventService.createEvent(
            EventService.EVENT_TYPES.NAVIGATION, {navigateTo: this.ELEMENT_NAMES.DESCRIPTION}, false, false)
        );
    }

    handleNavigation(event) {
        const pageManager = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER),
            navigateToElement = DOMService.getElementByDataId(this, event.detail.navigateTo);
        pageManager.handleNavigation(navigateToElement.getAttribute(PageManager.SEARCH_ATTRIBUTE));
    }
    @api
    navigateTo(navigateToName){
        const pageManager = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER),
            navigateToElement = DOMService.getElementByDataId(this, navigateToName);
        pageManager.handleNavigation(navigateToElement.getAttribute(PageManager.SEARCH_ATTRIBUTE));
    }

    handleButtonNavigation(event) {
        const pageManager = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER),
            navigateToElement = DOMService.getElementByDataId(this, event.target.name);
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.GALLERY_BODY).loadImages(this.item.Id);
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.DESCRIPTION_BODY).loadImage(this.item.Id);
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.CHARACTERISTICS_BODY).loadImage(this.item.Id);
        pageManager.handleNavigation(navigateToElement.getAttribute(PageManager.SEARCH_ATTRIBUTE));
    }



    @api
    loadItem(item) {
        this.item = item;
        //DOMService.getElementByDataId(this, 'scooterDesc').loadItem(item);
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.GALLERY).loadImages(item.Id);
    }

}