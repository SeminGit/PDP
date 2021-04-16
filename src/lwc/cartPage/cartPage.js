import {LightningElement, api, track} from 'lwc';
import {ApexService} from "c/apexService";
import {EventService} from "c/eventService";

export default class CartPage extends LightningElement {

    @api
    userId;

    @track
    items = [];

    connectedCallback() {
        EventService.addEventListener(this, EventService.EVENT_TYPES.DELETE, this.handleItemDelete);
    }

    get totalPrice() {
        let result = 0;
        if (this.items) {
            this.items.forEach(item => {
                result += item.UnitPrice * item.Quantity;
            });
        }
        return result;
    }

    handleItemDelete(event) {
        this.deleteItemById(event.detail.itemId).then(
            (result) => {
                console.log('delete result' + result);
                this.loadItems(this.userId);
            }
        ).catch(
            error => {
                console.log(error);
            }
        );

    }

    @api
    loadItems(userId) {
        console.log('cartObj userId: ' + userId);
        this.userId = userId;

        ApexService.getCartItems(userId).then(
            result => {
                if (result) {
                    console.log('retrieved OPI:' + result);
                    this.items = result;
                }
            }
        )
    }
    @api
    deleteItemById(itemId) {
        return ApexService.deleteCartProductById(itemId).then(
            result => {
                console.log('delete result: ' + result);
                return result;
            }
        ).catch(
            error => {
                console.log(error);
            });
    }
    @api
    addItemById(itemId, userId){
        ApexService.addItemToCart(itemId, userId).then(
            result =>{
                if(result != null && this.items){
                    this.items.push(result);
                }
            }
        )
    }

}