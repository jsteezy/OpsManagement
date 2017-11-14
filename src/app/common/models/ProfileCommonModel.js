import BaseModel from "./BaseModel";
import DateUtils from "../helpers/DateUtils";

export default class ProfileCommonModel extends BaseModel {
    constructor() {
        super();

        this.code = "";
        this.description = "";
        this.startDate = DateUtils.today;
        this.region = "";
        this.country = "";
    }
}