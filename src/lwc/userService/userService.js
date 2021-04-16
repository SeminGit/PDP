/**
 * Created by user on 11/23/20.
 */

import isEmailReservedApex from '@salesforce/apex/ContactService.isEmailReserved';
import registryUserMethod from '@salesforce/apex/ContactService.registryUser';
import loginUserMethod from '@salesforce/apex/ContactService.loginUser';


class UserService {

    static isEmailReserved(email) {
        return isEmailReservedApex({email: email}).then(result => {
            return result;
        }).catch(error => {
            console.log(error);
        });
    }

    static registryUser(user) {
        return registryUserMethod({user: user})
            .then(result => {
                return result;
            }).catch(error => {
                console.log(error);
            });
    }

    static loginUser(email, password) {
        return loginUserMethod({email:email, password: password})
            .then(result => {
                return result;
            }).catch(error => {
                console.log(error);
            });
    }
}

export {UserService}