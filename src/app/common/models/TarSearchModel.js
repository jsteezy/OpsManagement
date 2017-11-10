import BaseModel from "./BaseModel";
import DateUtils from "../helpers/DateUtils";

export default class TarSearchModel extends BaseModel{
    constructor() {
        super();
        this.title = "";
        this.requester = [];
        this.requesterId = 0;
        this.traveller = [];
        this.travellerId = 0;
        this.destinations = [];
        this.budgetApprover = [];
        this.budgetApproverId = 0;
        this.budgetApprovalStatus = "";
        this.budgetApprovalTimestamp = DateUtils.today;
        this.gSSApprovalStatus = "";
        this.gSSApprovalTimestamp = DateUtils.today;
    }
}