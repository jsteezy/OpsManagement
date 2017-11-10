import DateUtils from "../../helpers/DateUtils";

export default class DestinationsValidator {
    constructor() {
        this._errors = [];
    }

    isValid( model, allDestinations ) {
        this._errors = [];

        this.overlapDestinations = [];

        if (!this.areDatesValid(model)) {
            this._errors.push("DESTINATION_DATES_ERROR")
        }

        allDestinations.forEach(( dest ) => {
            if (this.destionationIsInSamePeriodWith(model, dest)) {
                this.overlapDestinations.push(dest);
            }
        });

        if (this.overlapDestinations.length > 0) {
            this._errors.push("DESTIONATION_ERROR")
        }

        this.overlapDestinations.forEach(x => {
            this._errors.push(x.country.title)
        })

        return this._errors.length == 0;
    }


    destionationIsInSamePeriodWith( model, dest ) {
        if (model.isOneWay) {
            return DateUtils.isBetween(model.departureDate, dest.departureDate, dest.returnDate)
        }

        if (dest.isOneWay) {
            return DateUtils.isBetween(dest.departureDate, model.departureDate, model.returnDate)
        }

        return DateUtils.isBetween(model.departureDate, dest.departureDate, dest.returnDate) ||
            DateUtils.isBetween(model.returnDate, dest.departureDate, dest.returnDate) ||
            DateUtils.isBetween(dest.departureDate, model.departureDate, model.returnDate) ||
            DateUtils.isBetween(dest.returnDate, model.departureDate, model.returnDate)
    }


    areDatesValid( model ) {
        return !model.isOneWay && model.departureDate <= model.returnDate;
    }

    get errors() {
        return this._errors;
    }

    static get instance() {
        return new DestinationsValidator();
    }
}
