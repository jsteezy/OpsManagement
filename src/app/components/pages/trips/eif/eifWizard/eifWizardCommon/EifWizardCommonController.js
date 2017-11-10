import EventsTypes from "../../../../../../common/enums/eventsTypes.json";
import AttachmentsOptions from "../../../../../../common/enums/attachmentsOptions";
import BaseComponentController from "../../../../../common/BaseComponentController";
import MaskOptions from "../../../../../../common/enums/maskOptions.json";

export default class EifWizardCommonController extends BaseComponentController {
    constructor() {
        super();

        this.attachmentsOptions = AttachmentsOptions.empty;
        this.registerEvents();

        this.setMaskOptions();
    }

    registerEvents() {
        let initCommonEifFeatures = (data) => {
            this.attachmentsOptions = AttachmentsOptions.eifDraftOptions(data[0].id);
        }

        super.setListener(EventsTypes.initCommonEifFeatures, initCommonEifFeatures);
    }

    isFieldErrorVisible(fieldName) {
        return this.form && (this.form.submitted || this.form[fieldName].$touched);
    }

    setMaskOptions() {
        this.maskOptions = MaskOptions;
    }
}