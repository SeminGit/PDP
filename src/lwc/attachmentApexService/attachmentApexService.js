import getAttachmentsByParentIdApex from '@salesforce/apex/AttachmentService.getAttachmentsByParentId'
import {DOMService} from "c/domService";

class AttachmentApexService {

    static getAttachmentsByParentId(parentId) {
        return getAttachmentsByParentIdApex({parentId: parentId}).then(result => {
            return result;
        }).catch(error => {
            console.log(error);
        });
    }

     static async getAttachedImageURLs(parentId) {
        let imageURLs = [],
            attachments = (await this.getAttachmentsByParentId(parentId));
        if(attachments === null || attachments === undefined) return [this.createImageRequestURL('00P5g0000011zQCEAY')];
        attachments.forEach(attachmentId => {
            imageURLs.push(this.createImageRequestURL(attachmentId));
        });
        return imageURLs;
    }
    static async getFirstAttachedImageURL(parentId){
        let result = await this.getAttachedImageURLs(parentId);
        if(result)
            return result[0];
    }
    static createImageRequestURL(attachmentId) {
        return 'https://asd-e-dev-ed.lightning.force.com/servlet/servlet.FileDownload?file=' + attachmentId;
    }

}

export {AttachmentApexService}