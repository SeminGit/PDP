import getContactsApex from '@salesforce/apex/ContactService.getContacts';
import getScootersApex from '@salesforce/apex/ScooterService.getScooters';
import getAttachmentsByParentIdApex from '@salesforce/apex/AttachmentService.getAttachmentsByParentId'
import isEmailReservedApex from '@salesforce/apex/ContactService.isEmailReserved';
import registryUserApex from '@salesforce/apex/ContactService.registryUser';
import loginUserApex from '@salesforce/apex/ContactService.loginUser';
import getCartProductsApex from '@salesforce/apex/OpportunityService.getCartProducts';
import deleteCartProductByIdApex from '@salesforce/apex/OpportunityLineItemService.deleteOpportunityLineItemById';
import addProductToCartApex from '@salesforce/apex/OpportunityLineItemService.addOpportunityLineItemByProductId'
import getProductsApex from '@salesforce/apex/ProductService.getProducts';
import {Validation} from "c/validation";
import {Utility} from "c/utility";


class ApexService {


    static getProducts(filters) {
        console.log('getProducts input' + filters);
        return getProductsApex({filters: filters}).then(
            result => {
                let tempObj = {},
                    list = [];
                result.forEach(temp => {
                    for (let key in temp.product) {
                        tempObj[key] = temp.product[key];
                        console.log(tempObj);
                    }
                    tempObj['price'] = temp.price;
                    list.push(tempObj);
                });
                console.log(list);
                return result;
            }).catch(error => {
            console.log(error);
        });
    }

    static getCartItems(userId) {
        return getCartProductsApex({contactId: userId}).then(
            result => {
                console.log('items:' + result);
                return result;
            }
        ).catch(error => {
            console.log(error);
        });
    }

    static addItemToCart(itemId, userId) {

        console.log('inputs' + itemId + ' ' + userId);

        return addProductToCartApex({productId: itemId, contactId: userId}).then(
            result => {
                console.log('new Item created:' + result);
                return result;
            }
        ).catch(error => {
            console.log(error);
        });
    }

    static deleteCartProductById(productId) {
        return deleteCartProductByIdApex({id: productId}).then(
            result => {
                return result;
            }
        ).catch(error => {
            console.log(error);
        })
    }

    static getContacts(fields, filters) {
        return getContactsApex({
            fields: fields,
            filters: filters
        }).then(
            result => {
                return result;
            }).catch(error => {
            console.log(error)
        })
    }

    static getScooters(fields, filters) {
        return getScootersApex({
            fields: fields,
            filters: filters
        }).then(
            result => {
                return result;
            }).catch(error => {
            console.log(error)
        })
    }

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
        if (attachments === null || attachments === undefined) return [this.createImageRequestURL('00P5g0000011zR5EAI')];
        attachments.forEach(attachmentId => {
            imageURLs.push(this.createImageRequestURL(attachmentId));
        });
        return imageURLs;
    }

    static async getFirstAttachedImageURL(parentId) {
        let result = await this.getAttachedImageURLs(parentId);
        if (result)
            return result[0];
    }

    static createImageRequestURL(attachmentId) {
        return 'https://asd-e-dev-ed.lightning.force.com/servlet/servlet.FileDownload?file=' + attachmentId;
    }

    static async isEmailReserved(email) {
        return isEmailReservedApex({email: email}).then(result => {
            return result;
        }).catch(error => {
            console.log(error);
        });
    }

    static async registryUser(user) {
        return registryUserApex({user: user})
            .then(result => {
                return result;
            }).catch(error => {
                console.log(error);
            });
    }

    static async loginUser(email, password) {
        return loginUserApex({email: email, password: password})
            .then(result => {
                return result;
            }).catch(error => {
                console.log(error);
            });
    }
}

export {ApexService}