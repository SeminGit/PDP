/**
 * Created by user on 11/23/20.
 */

class Validation {

    static VALIDATION_TYPE = {
        EMAIL: 'EMAIL',
        PASSWORD: 'PASSWORD',
        EMPTY_STRING: 'EMPTY_STRING',
        PHONE: 'PHONE',
        POSTAL_CODE: 'POSTAL_CODE',
        EQUAL: 'EQUAL'
    }
    static VALIDATION_ERROR_MESSAGES = {
        EMAIL: 'Email must match template like "example@mail.com"',
        PHONE: 'Phone must mach the template like "111 22 1234"',
        POSTAL_CODE: 'Postal Code must mach the template like "11111 22222 1234"',
        EMPTY_STRING: 'The field must be not empty!',
        EQUAL: 'Rows must mach each other!'
    }

    static isEmailValid(value) {
        if (!value) return;
        const emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return emailRegex.test(value);
    }

    static isPhoneValid(value) {
        const phoneRegex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im;
        return phoneRegex.test(value);
    }

    static isPostalCodeValid(value) {
        const postalCodeRegex = /^\d{5}$|^\d{5}-\d{4}$/;
        postalCodeRegex.test(value);
    }

    static areStringsEqual(firstValue, secondValue) {
        return firstValue === secondValue;
    }

    static isEmpty(string) {

        if (string == null || string === '' || string === undefined) {
            return true;
        }
        return false;
    }

    static validateElement(element, type) {
        if (!element || !type) return null;

        const value = element.value;
        let result = false;

        switch (type) {
            case this.VALIDATION_TYPE.EMAIL:
                result = this.isEmailValid(value);
                break;
            case this.VALIDATION_TYPE.EMPTY_STRING:
                result = !this.isEmpty(value);
                break;
            case this.VALIDATION_TYPE.PHONE:
                result = this.isPhoneValid(value);
                break;
            case this.VALIDATION_TYPE.POSTAL_CODE:
                result = this.isPostalCodeValid(value);
                break;
            case this.VALIDATION_TYPE.EQUAL:
                result = this.areStringsEqual(element.first, element.second);
                break;
        }

        console.log(element);

        element.setCustomValidity('');

        if (!result) {
            element.setCustomValidity(this.VALIDATION_ERROR_MESSAGES[type]);
        }

        element.reportValidity();
    }
    static validateScope(elements){
        let allValid = true;

        elements.forEach(el =>{
            if(!this.validateElement(el.value, el.type)){
                allValid = false;
            }
        });

        return allValid;
    }
}

export {Validation}