import BaseModalController from "../../../../../common/BaseModalController";

export default class EmergencyContactViewController extends BaseModalController {
    constructor($injector) {
        super($injector);

        super.model = this.contact;
    }
}

EmergencyContactViewController.$inject = ["$injector"];