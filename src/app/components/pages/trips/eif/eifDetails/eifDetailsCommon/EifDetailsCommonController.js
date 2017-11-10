import EventsTypes from "../../../../../../common/enums/eventsTypes.json";
import AttachmentsOptions from "../../../../../../common/enums/attachmentsOptions";
import BaseComponentController from "../../../../../common/BaseComponentController";

export default class EifDetailsCommonController extends BaseComponentController {
    constructor() {
        super();

        this.attachmentsOptions = AttachmentsOptions.empty;
        this.registerEvents();
    }

    registerEvents() {
        let initCommonEifDetails = (data) => {
            this.attachmentsOptions = AttachmentsOptions.eifRequestOptions(data[0].id);
        }

        super.setListener(EventsTypes.initCommonEifDetails, initCommonEifDetails);
    }
}