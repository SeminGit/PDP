import {LightningElement, api} from 'lwc';
import {EventService} from "c/eventService";

export default class MainMenu extends LightningElement {

    @api
    title = null;
    static delegatesFocus = true;

    handleButtonClick(event) {
        const name = event.target.name;
        switch (name) {
            case 'Login':
                EventService.fireLoginEvent(this);
                break;
            case 'Home':
                EventService.fireNavigationEvent(this, 'HOME_PAGE');
                break;
            case 'Cart':
                EventService.fireCartEvent(this);
                break;
        }
    }

}