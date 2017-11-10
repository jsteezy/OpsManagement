export default class TarValidator {
    constructor() {
        this._errors = [];
    }

    isValid(model) {
        this._errors = [];
        
        if (model.destinations.length == 0) {
            this._errors.push('DESTINATIONS_ERROR')
        }

        if (model.budgetCodes.length == 0) {
            this._errors.push('BUDGETCODES_ERROR')
        }

        return this._errors.length == 0;
    }

    get errors() {
        return this._errors
    }

    static get instance() {
        return new TarValidator();
    }
}