import {ApexService} from "c/apexService";
import {EventService} from "c/eventService";
import {DOMService} from "c/domService";
import {Validation} from "c/validation";
import {LightningElement, track} from 'lwc';

export default class LoginForm extends LightningElement {

    @track
    ELEMENT_NAMES = {
        EMAIL: 'email',
        PASSWORD: 'password'
    }
    email = '';
    password = '';

    handleChange(event) {
        const name = event.target.name,
            value = event.target.value;
        switch (name) {
            case this.ELEMENT_NAMES.EMAIL:
                this.email = value;
                break;
            case this.ELEMENT_NAMES.PASSWORD:
                this.password = value;
                break;
        }
    }

    isInputValid() {
        const email = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.EMAIL),
            password = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PASSWORD);
        Validation.validateElement(email, Validation.VALIDATION_TYPE.EMAIL);
        Validation.validateElement(password, Validation.VALIDATION_TYPE.EMPTY_STRING);
        return true;
    }

    async handleLogin() {
        if (!this.isInputValid()) return;

        const userId = await ApexService.loginUser(this.email, this.password);

        console.log('userId:  ' + userId);

        if (userId != null) {
            let date = new Date(Date.now() + 86400e3);

            document.cookie = 'login='+this.email+';expires'+date;
            document.cookie = 'password='+this.password+';expires'+date;

            EventService.fireToastEvent(this, 'success', 'You have successfully logged in' + userId, true);
            EventService.fireUserEvent(this, userId, true, true);
        } else {
            console.log('No user found!');
            EventService.fireToastEvent(this, 'error', 'Wrong credentials, please try again!' + userId, true);
        }
    }
}