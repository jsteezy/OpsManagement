
import DateUtils from "../helpers/DateUtils";
import BaseModel from "./BaseModel";

export default class ResponseModel extends BaseModel {
    constructor() {
        super();

        this.code = "";
        this.description = "";
        this.startDate = DateUtils.today;
        this.region = "";
        this.country = "";
    }
}