/**
 * Created by user on 11/22/20.
 */

import {LightningElement, track} from 'lwc';
import {Validation} from "c/validation";
import {ApexService} from "c/apexService";
import {DOMService} from "c/domService";
import {EventService} from "c/eventService"

export default class RegistryForm extends LightningElement {
    @track
    ELEMENT_NAMES = {
        FIRSTNAME: 'firstName',
        LASTNAME: 'lastName',
        EMAIL: 'email',
        PASSWORD: 'password',
        PASSWORD_REPEAT: 'passwordRepeat'
    }
    @track
    user = {
        email: '',
        password: '',
        firstName: '',
        lastName: ''
    }
    passwordRepeat = '';

    handleChange(event) {
        const value = event.target.value,
            name = event.target.name;
        switch (name) {
            case this.ELEMENT_NAMES.EMAIL:
                this.user.email = value;
                break;
            case this.ELEMENT_NAMES.FIRSTNAME:
                this.user.firstName = value;
                break;
            case this.ELEMENT_NAMES.LASTNAME:
                this.user.lastName = value;
                break;
            case this.ELEMENT_NAMES.PASSWORD:
                this.user.password = value;
                break;
            case this.ELEMENT_NAMES.PASSWORD_REPEAT:
                this.passwordRepeat = value;
                break;
        }
    }

    isInputValid() {
        const email = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.EMAIL),
            firstName = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.FIRSTNAME),
            lastName = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.LASTNAME),
            password = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PASSWORD),
            passwordRepeat = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PASSWORD_REPEAT);
        Validation.validateScope(
            [
                {
                    value: email,
                    type: Validation.VALIDATION_TYPE.EMAIL
                },
                {
                    value: firstName,
                    type: Validation.VALIDATION_TYPE.EMPTY_STRING,
                },
                {
                    value: lastName,
                    type: Validation.VALIDATION_TYPE.EMPTY_STRING,
                },
                {
                    value: password,
                    type: Validation.VALIDATION_TYPE.EMPTY_STRING,
                },
                {
                    value: passwordRepeat,
                    type: Validation.VALIDATION_TYPE.EMPTY_STRING,
                },
                {
                    value: {first:password, second:passwordRepeat},
                    type: Validation.VALIDATION_TYPE.EQUAL
                }
            ]
        );
        return true;
    }


    async handleRegistry() {
        if (this.isInputValid()) {
            if (!await ApexService.isEmailReserved(this.user.email)) {
                try {
                    const userId = await ApexService.registryUser(this.user);
                    if (userId !== null) {
                        EventService.fireToastEvent(this, 'success', 'Registration has passed successfully', true);
                        EventService.fireUserEvent(this, userId, true, true);
                    }
                } catch (exp) {
                    EventService.fireToastEvent(this, 'error', 'Something wrong happened on the server side', false);
                }
            } else {
                EventService.fireToastEvent(this, 'warning', 'This email is already in use', true);
            }
        }
    }

}