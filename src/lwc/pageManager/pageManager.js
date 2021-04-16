import {LightningElement, track, api} from 'lwc';
import {EventService} from 'c/eventService';
import {DOMService} from 'c/domService';
import {ApexService} from "c/apexService";


export default class PageManager extends LightningElement {

    static SEARCH_ATTRIBUTE = 'slot';

    @api
    changePage(pageName) {
        const body = DOMService.getHTMLElementByDataId(this, pageName);
        this.handleNavigation(body.getAttribute(PageManager.SEARCH_ATTRIBUTE));
    }

    currentPage = 'firstSlot';
    @track
    PAGES = {
        FIRSTSLOT: 'firstSlot',
        SECONDSLOT: 'secondSlot',
        THIRDSLOT: 'thirdSlot',
        FOURTHSLOT: 'fourthSlot',
        FIFTHSLOT: 'fifthSlot',
    }

    renderedCallback() {
        for (let key in this.PAGES) {
            DOMService.hideElement(this, this.PAGES[key]);
        }
        DOMService.showElement(this, this.currentPage);
    }

    @api
    handleNavigation(pageName) {
        DOMService.hideElement(this, this.currentPage);
        DOMService.showElement(this, pageName);
        this.currentPage = pageName;
    }
}