import {DOMService} from 'c/domService';
import {ApexService} from "c/apexService";
import {LightningElement, api, track} from 'lwc';

export default class ImageGallery extends LightningElement {

    ELEMENT_NAMES = {
        PREVIOUS: 'PREVIOUS',
        CURRENT_IMAGE: 'CURRENT_IMAGE',
        NEXT: 'NEXT'
    }
    @api
    imageParentId;
    @track
    imagesURLList = [];
    @track
    currentImage = {
        imageURL: '',
        index: 0
    };

    @api
    displayImages(imagesURLList) {
        if (imagesURLList != null && imagesURLList.length > 0) {
            this.imagesURLList = imagesURLList;
            this.currentImage.imageURL = this.imagesURLList[0];
            this.currentImage.index = 0;
        }
        this.checkButtonAvailability();
    }

    @api
    displayImage(imageURL) {
        if (imageURL)
            this.currentImage.imageURL = imageURL;
            this.currentImage.index = 0;
        DOMService.disableButton(this, this.ELEMENT_NAMES.NEXT);
        DOMService.disableButton(this, this.ELEMENT_NAMES.PREVIOUS);
    }

    @api
    loadImages(imageParentId) {
        if (imageParentId != null) {
            ApexService.getAttachedImageURLs(imageParentId).then(
                result => {
                    this.displayImages(result);
                }
            )
        }
    }

    @api
    loadFirstImage(imageParentId) {
        if (imageParentId != null) {
            ApexService.getFirstAttachedImageURL(imageParentId).then(
                result => {
                    this.displayImage(result);
                }
            )
        }
    }

    checkButtonAvailability() {
        DOMService.enableButton(this, this.ELEMENT_NAMES.NEXT);
        DOMService.enableButton(this, this.ELEMENT_NAMES.PREVIOUS);
       // alert('next ava' + this.currentImage.index + this.imagesURLList.length);
     //   alert('perv ava' + this.currentImage.index);
        if (this.currentImage.index === this.imagesURLList.length)
            DOMService.disableButton(this, this.ELEMENT_NAMES.NEXT);
        if (this.currentImage.index === 0)
            DOMService.disableButton(this, this.ELEMENT_NAMES.PREVIOUS);
    }

    nextImage() {
        if (this.imagesURLList.length > (this.currentImage.index + 1)) {
            this.currentImage.imageURL = this.imagesURLList[this.currentImage.index + 1];
            this.currentImage.index += 1;
        }
        this.checkButtonAvailability();
    }

    previousImage() {
        if ((this.currentImage.index - 1) > -1) {
            this.currentImage.imageURL = this.imagesURLList[this.currentImage.index - 1];
            this.currentImage.index -= 1;
        }
        this.checkButtonAvailability();
    }
}