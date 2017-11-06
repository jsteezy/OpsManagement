import DateUtils from "../helpers/DateUtils";

export default class ResponseModel {
    constructor() {
        this.country = null;
        this.startDate = DateUtils.today;
        this.region = null;
        this.responseDescription = null;
        this.code = null;
    }
}