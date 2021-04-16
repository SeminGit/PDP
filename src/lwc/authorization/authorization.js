import {LightningElement, track} from 'lwc';
import {DOMService} from 'c/domService';
import {EventService} from 'c/eventService';

export default class Authorization extends LightningElement {
    @track
    ELEMENT_NAMES = {
        LOGIN: 'login',
        REGISTRATION: 'registration'
    }

    connectedCallback() {
        this.template.ariaLabel = 'Sing Up Form';
    }

    handleSingUp(){
        DOMService.hideElement(this, this.ELEMENT_NAMES.LOGIN);
        DOMService.showElement(this, this.ELEMENT_NAMES.REGISTRATION)
    }
    handleCancelReg(){
        DOMService.hideElement(this, this.ELEMENT_NAMES.REGISTRATION);
        DOMService.showElement(this, this.ELEMENT_NAMES.LOGIN);
    }

}