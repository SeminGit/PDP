/**
 * Created by user on 11/24/20.
 */

import {LightningElement, api} from 'lwc';
import { EventService } from 'c/eventService';
import {DOMService} from "c/domService"

export default class Spinner extends LightningElement {

    isActive = false;
    @api
    changeState(isActive){
            this.isActive = isActive;
    }

}