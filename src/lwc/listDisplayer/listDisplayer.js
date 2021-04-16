/**
 * Created by user on 11/25/20.
 */
import getScooters from '@salesforce/apex/ScooterService.getScooters';
import {LightningElement, track, api} from 'lwc';

export default class ListDisplayer extends LightningElement {


    @track
    items;

    @api
    loadItems(items) {
        this.items = items;
    }

}