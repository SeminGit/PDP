/**
 * Created by user on 11/23/20.
 */

class DOMService {

    // [1] Utilities
    static CLASS_NAMES = {
        HIDE: 'hide'
    }

    //
    static getElementByDataId(parent, elementId) {
        return parent.template.querySelector('[data-id=' + elementId + ']');
    }

    static getHTMLElementByDataId(parent, elementId) {
        if(!parent || !elementId) return;
        return parent.querySelector('[data-id=' + elementId + ']');
    }

    static getAllElements(parent, elementName) {
        if(!(parent && elementName)) return;
        return parent.template.querySelectorAll(elementName);
    }

    static getElementByName(parent, name) {
        if(!parent || !name) return;
        return parent.querySelector(name);
    }

    static addClass(parent, elementName, className) {
        const element = this.getElementByDataId(parent, elementName);
        if (element === null) return;
        element.classList.add(className);
    }

    static removeClass(parent, elementName, className) {
        if(!parent || !elementName || !className) return;
        const element = this.getElementByDataId(parent, elementName);
        if (element === null) return;
        element.classList.remove(className);
    }

    static setClass(parent, elementName, value) {
        if(!parent || !elementName || !value) return;
        const element = this.getElementByDataId(parent, elementName);
        if (element === null) return;
        element.className = value;
    }

    // Visibility Control. Parent CSS MUST have import from visibility !!!
    static hideElement(parent, elementName) {
        if(!parent || !elementName) return;
        this.addClass(parent, elementName, this.CLASS_NAMES.HIDE);
    }

    static showElement(parent, elementName) {
        if(!parent || !elementName) return;
        this.removeClass(parent, elementName, this.CLASS_NAMES.HIDE);
    }

    static disableButton(parent, buttonId) {
        DOMService.getElementByDataId(parent, buttonId).setAttribute('disabled', 'disabled');
    }

    static enableButton(parent, buttonId) {
        DOMService.getElementByDataId(parent, buttonId).removeAttribute('disabled');
    }

    //
}

export {DOMService}