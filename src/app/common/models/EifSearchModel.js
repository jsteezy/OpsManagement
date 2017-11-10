import BaseModel from "./BaseModel";

export default class EifSearchModel extends BaseModel {
    constructor() {
        super();
        this.title = "";
        this.requester = [];
        this.requesterId = 0;
        this.firstName = "";
        this.lastName = "";
        this.destinations = [];
        this.staffResponsibleForGuest = [];
        this.staffResponsibleForGuestId = 0;
        this.tarId = "";
    }
}