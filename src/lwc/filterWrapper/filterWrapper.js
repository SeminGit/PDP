/**
 * Created by user on 11/26/20.
 */

class FilterWrapper {

    fieldName;
    filterOperator;
    fieldValue;
    whereOperator;
    type;

    constructor(fieldName, filterOperator, fieldValue,type ) {
        this.fieldName = fieldName;
        this.filterOperator = filterOperator;
        this.fieldValue = fieldValue;
        this.type = type;
    }

    get name() {
        if(!(this.fieldName && this.filterOperator && this.whereOperator && this.type)) return null;
        return this.fieldName + this.filterOperator + this.type;
    }

}

export {FilterWrapper}