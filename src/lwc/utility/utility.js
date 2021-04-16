/**
 * Created by user on 11/27/20.
 */

class Utility {

    static parseObject(fields, object) {
        let list = [],
            a = {};
        object.forEach(temp => {
            a = [];
            fields.forEach(field => {
                if (field !== null || field)
                    a[field] = temp[field];
            })
            list.push(a);
        });
        return list;
    }

    static createMapFromObjectFields(object) {
        let result = [];
        for (const [Key, Value] of Object.entries(object)) {
            result.push({'Key': Key, 'Value': Value});
        }
        return result;
    }

    static getCookie(name) {
        let matches = document.cookie.match(new RegExp(
            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    static createCookie(name, value) {
        document.cookie = name + '=' + value;
    }

    static removeCookie(name) {
        document.cookie = name + '=';
    }

}

export {Utility}