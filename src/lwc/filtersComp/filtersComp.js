import {LightningElement, track, api} from 'lwc';
import {EventService} from "c/eventService";
import {FilterService} from "c/filterService";
import {Constants} from "c/constants";
import {DOMService} from "c/domService";

export default class FiltersComp extends LightningElement {

    ELEMENT_NAMES = {
        BODY: 'BODY',
        SUBMIT_BUTTON: 'SUBMIT_BUTTON',
        SHOW_HIDE_BUTTON: 'SHOW_HIDE_BUTTON',
        NAME_FILTER: 'NAME_FILTER',
        PRICE_FILTER: 'PRICE_FILTER',
        MAX_TRAVEL_FITLER: 'MAX_TRAVEL_FILTER',
        CHARGE_TIME_FILTER: 'CHARGE_TIME_FILTER',
        FILTER_CMP: 'c-filter'
    }

    isVisible = false;

    filters = new FilterService();

    renderedCallback() {
        EventService.addEventListener(this, EventService.EVENT_TYPES.FILTER_CHANGED, this.handleFilterChange);
    }

    handleFilterChange(event) {
        console.log('Filter changed catch, filter: %s', event.detail.filter);
        this.filters.upsert(event.detail.filter);
        EventService.fireFilterEvent(this, this.filters.filters);
    }

    handleChange(event) {

    }

    handleSubmitButtonClick() {
        let filters = [];
        if (this.filters.name) {
            filters.push(
                FilterService.createStringFilter(
                    Constants.PRODUCT_FIELD_API_NAMES.NAME,
                    Constants.FILTER_OPERATORS.TEXT.START_WITH,
                    this.filters.name,
                    null));
        }
        /*filters.push(
          FilterService.createNumberFilter(
              Constants.PRODUCT_FIELD_API_NAMES.MAX_TRAVEL_DISCTANCE,
              Constants.FILTER_OPERATORS.ARITHMETIC.MORE_THAN,
              this.filters.travelDistance)
        );*/
        EventService.fireFilterEvent(this, filters);
    }

    changeViewStateHandler() {
        this.isVisible = !this.isVisible;
        if (this.isVisible === false) {
            DOMService.setClass(this, this.ELEMENT_NAMES.SHOW_HIDE_BUTTON, 'control-button-hidden');
            DOMService.hideElement(this, this.ELEMENT_NAMES.BODY);
        } else {
            DOMService.setClass(this, this.ELEMENT_NAMES.SHOW_HIDE_BUTTON, 'control-button-shown');
            DOMService.showElement(this, this.ELEMENT_NAMES.BODY);
        }
    }

}