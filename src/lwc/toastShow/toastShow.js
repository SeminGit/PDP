/**
 * Created by user on 11/22/20.
 */

import {LightningElement, api} from 'lwc';

export default class ToastShow extends LightningElement {

    @api title;
    @api message;
    @api variant;
    @api autoCloseTime = 3000;
    @api autoClose = false;
    @api autoCloseErrorWarning = false;

    constructor() {
        super();
    }

    titleChange(event) {
        this.title = event.target.value;
    }

    messageChange(event) {
        this.message = event.target.value;
    }

    variantChange(event) {
        this.variant = event.target.value;
    }

    showNotification() {

        if (ShowToastEvent) {

            const evt = new ShowToastEvent({
                title: this.title,
                message: this.message,
                variant: this.variant,
            });

            this.dispatchEvent(evt);

        }
    }

    @api
    showCustomNotice() {

        const toastModel = this.template.querySelector('[data-id="toastModel"]');
        toastModel.className = 'slds-show';
        //delay
        if (this.autoClose != false)
            this.delayTimeout = setTimeout(() => {
                const toastModel = this.template.querySelector('[data-id="toastModel"]');
                toastModel.className = 'hide';
            }, this.autoCloseTime);
    }

    @api
    showToast(variant, message, autoClose) {

        this.variant = variant;
        this.message = message;
        this.autoClose = autoClose;

        this.showCustomNotice();

    }

    @api
    showToastOnEvent(event) {
        try {
            this.showToast(
                event.variant,
                event.message,
                event.autoClose
            );
        } catch (exception) {
            console.log("Wrong parameters for toast event!");
        }

    }

    closeModel() {
        const toastModel = this.template.querySelector('[data-id="toastModel"]');
        toastModel.className = 'hide';
    }

    get mainDivClass() {
        return 'slds-notify slds-notify_toast slds-theme_' + this.variant;
    }

    get messageDivClass() {
        return 'slds-icon_container slds-icon-utility-' + this.variant + ' slds-icon-utility-success slds-m-right_small slds-no-flex slds-align-top';
    }

    get iconName() {
        return 'utility:' + this.variant;
    }

}