import {LightningElement, api, track} from 'lwc';
import {EventService} from "c/eventService";

export default class CartCard extends LightningElement {

    @api
    item;

    get Name(){
        if(this.item){
            return this.item.Name;
        }
    }
    get UnitPrice(){
        if(this.item){
            return this.item.UnitPrice;
        }
    }
    handleDeleteClick(){
        EventService.fireDeleteByIdEvent(this, this.item.Id);
    }

}