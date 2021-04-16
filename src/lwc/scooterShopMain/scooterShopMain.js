import {DOMService} from "c/domService";
import {LightningElement, track, api} from 'lwc';
import {EventService} from "c/eventService"
import {ApexService} from "c/apexService";
import {Validation} from "c/validation";
import PageManager from "c/pageManager";
import {Utility} from "c/utility";

export default class ScooterShopMain extends LightningElement {

    ELEMENT_NAMES = {
        TOAST: 'TOAST',
        SPINNER: 'SPINNER',
        PAGE_MANAGER: 'PAGE_MANAGER',
        HOME_PAGE: 'HOME_PAGE',
        LOGIN_PAGE: 'LOGIN_PAGE',
        LIST_BODY: 'LIST_BODY',
        INFO: 'INFO',
        INFO_PAGE: 'INFO_PAGE',
        MODAL_WINDOW: 'MODAL_WINDOW',
        CART_PAGE: 'CART_PAGE',
        CART: 'CART'
    }

    @track
    user = {};

    get getUserName() {
        if (this.user != null && !this.user) {
            return this.user.Name;
        }
        return null;
    }

    connectedCallback() {
        EventService.addEventListener(this, EventService.EVENT_TYPES.TOAST, this.handleToast);
        EventService.addEventListener(this, EventService.EVENT_TYPES.SPINNER, this.spinnerChanged);
        EventService.addEventListener(this, EventService.EVENT_TYPES.NAVIGATION, this.handleNavigation);
        EventService.addEventListener(this, EventService.EVENT_TYPES.SCOOTER_SELECTED, this.handleScooter);
        EventService.addEventListener(this, EventService.EVENT_TYPES.USER, this.handleUser);
        EventService.addEventListener(this, EventService.EVENT_TYPES.LOGIN, this.handleRegistration);
        EventService.addEventListener(this, EventService.EVENT_TYPES.CART, this.handleCart);
        EventService.addEventListener(this, EventService.EVENT_TYPES.SCOOTER_ADD_TO_CART, this.handleAddScooterToCart);

        const login = Utility.getCookie('login'),
            password = Utility.getCookie('password');
        if (login && password && login !== '' && password !== '')
            ApexService.loginUser(login, password).then(
                result => {
                    if (result) {
                        //alert(result);
                        EventService.fireUserEvent(this, result);
                    }
                }
            ).catch(error => {
                console.log(error);
            });

        //DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER).changePage(this.ELEMENT_NAMES.HOME_PAGE);
         //this.handleNavigation(EventService.createEvent(EventService.EVENT_TYPES.NAVIGATION,{navigateTo: this.ELEMENT_NAMES.HOME_PAGE},false,false));
    }

    handleAddScooterToCart(event){
        console.log('Handle SCOOTER' + event.detail.scooter.Id);
        const cartPage = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.CART);
        cartPage.itemId = this.user.Id;
        cartPage.addItemById(event.detail.scooter.Id, this.user.Id);
    }

    handleCart(event){
        const cartPage = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.CART);
        cartPage.loadItems(this.user.Id);
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER).changePage(this.ELEMENT_NAMES.CART_PAGE);
    }

    handleNavigation(event) {
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER).changePage(event.detail.navigateTo);
    }

    handleScooter(event) {
        const scooterInfo = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.INFO);
        scooterInfo.item = event.detail.scooter;
        scooterInfo.price = event.detail.price;
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER).changePage(this.ELEMENT_NAMES.INFO_PAGE);
    }

    handleRegistration(event) {
        const modalWindow = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.MODAL_WINDOW);
        modalWindow.openModal();
    }

    handleUser(event) {
        this.user = event.detail.user;
        const modalWindow = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.MODAL_WINDOW);
        modalWindow.closeModal();
    }

    handleToast(event) {
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.TOAST).showToastOnEvent(event.detail);
    }

    handleFiltersSubmitted(event){
        const filters = event.detail.filters;
        console.log('appHanlder: ' + filters);
        if(filters){
            const loader = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.LIST_BODY);
            loader.loadData(filters);
        }
    }

    spinnerChanged(event) {
        const spinner = DOMService.getElementByDataId(this, this.ELEMENT_NAMES.SPINNER);
        spinner.changeState(event.detail.isActive);
    }

    async aaa() {
        DOMService.getElementByDataId(this, this.ELEMENT_NAMES.LIST_BODY);

        Utility.removeCookie('login');
        Utility.removeCookie('password');
        //DOMService.getElementByDataId(this, this.ELEMENT_NAMES.PAGE_MANAGER).changePage(this.ELEMENT_NAMES.HOME_PAGE);
    }

}