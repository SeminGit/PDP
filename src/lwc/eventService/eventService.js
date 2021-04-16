import {FilterWrapper} from "c/filterWrapper";

class EventService {
    // [1] Utility
    static EVENT_TYPES = {
        TOAST: 'showToast',
        USER: 'user',
        SCOOTER_SELECTED: 'SCOOTER_SELECTED',
        SCOOTER_ADD_TO_CART: 'SCOOTER_ADD_TO_CART',
        SPINNER: 'spinner',
        NAVIGATION: 'navigation',
        LOGIN: 'LOGIN',
        CART: 'CART',
        DELETE: 'DELETE',
        FILTER: 'FILTER',
        FILTER_CHANGED: 'FILTER_CHANGED'
    }

    static createEvent(type, detail, isBubbles, isComposed) {
        return new CustomEvent(type, {detail: detail, bubbles: isBubbles, composed: isComposed});
    }

    static createDefaultEvent(type, detail) {
        return new CustomEvent(type, {detail: detail});
    }

    static createBubbledEvent(type, detail) {
        return new CustomEvent(type, {detail: detail, bubbles: true});
    }

    static createComposedEvent(type, detail) {
        return new CustomEvent(type, {detail: detail, bubbles: true, composed: true});
    }

    //

    // [2] Event Listeners
    static addEventListener(parent, eventType, listener) {
        parent.addEventListener(eventType, listener);
    }

    //

    // [3] Event Fires
    static fireEvent(parent, eventName, detail) {
        parent.dispatchEvent(new CustomEvent(eventName, detail));
    }

    static fireBubbledEvent(parent, eventName, detail) {
        parent.dispatchEvent(this.createBubbledEvent(eventName, detail));
    }

    static fireAppEvent(parent, eventName, detail) {
        parent.dispatchEvent(this.createComposedEvent(eventName, detail));
    }

    static fireToastEvent(parent, detail) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.TOAST, detail));
    }

    static fireUserEvent(parent, user) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.USER, {user: user}));
        // parent.dispatchEvent(this.fireNavigationEvent(this.EVENT_TYPES.NAVIGATION, {navigateTo: 'home'}));
    }

    static fireLoginEvent(parent) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.LOGIN, null));
        // parent.dispatchEvent(this.fireNavigationEvent(this.EVENT_TYPES.NAVIGATION, {navigateTo: 'home'}));
    }

    static fireCartEvent(parent) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.CART, null));
    }

    static fireNavigationEvent(parent, navigateTo) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.NAVIGATION,
            {
                navigateTo: navigateTo
            }
        ));
    }

    static fireDeleteByIdEvent(parent, itemId) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.DELETE, {itemId: itemId}));
    }

    static fireSpinnerChangeStateEvent(parent, isActive) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.SPINNER, {
            isActive: isActive
        }));
    }

    static fireToastEvent(parent, variant, message, autoClose) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.TOAST, {
            detail: {
                variant: variant,
                message: message,
                autoClose: autoClose
            }
        }));
    }

    static fireScooterSelectedEvent(parent, scooter, price) {
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.SCOOTER_SELECTED, {
            scooter: scooter,
            price: price
        }));
    }

    static fireAddScooterToCartEvent(parent, scooter) {
        parent.dispatchEvent(new CustomEvent('SCOOTER_ADD_TO_CART', {
            detail: {scooter: scooter},
            bubbles: true,
            composed: true
        }));
        // parent.dispatchEvent(this.createComposedEvent(this, this.EVENT_TYPES.SCOOTER_ADD_TO_CART, {scooter:scooter}));
    }

    static fireFilterEvent(parent, filters) {
        if (!parent || !filters) return null;
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.FILTER, {filters: filters}));
    }

    static fireFilterChangedEvent(parent, filter){
        if(!(parent && filter)) return;
        parent.dispatchEvent(this.createComposedEvent(this.EVENT_TYPES.FILTER_CHANGED, {filter:filter}));
    }

//
}

export {EventService}