import DateUtils from "../helpers/DateUtils";

export default class DestinationModel {
    constructor() {
        this.country = null;
        this.departureDate = DateUtils.today;
        this.returnDate = DateUtils.today;
        this.isOneWay = false;
    }
}
