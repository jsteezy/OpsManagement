import BaseModalController from "../../../../../common/BaseModalController";
import TravelAdvanceModel from "./../../../../../../common/models/TravelAdvanceModel";
import PageModes from "../../../../../../common/enums/pageModes.json";
import ObjectMapper from "../../../../../../common/helpers/ObjectMapper";

export default class TravelAdvanceController extends BaseModalController {
    constructor(currencyDataAccessService, $injector) {
        super($injector);

        this.currencyDataAccessService = currencyDataAccessService;

        this.activate();
    }

    activate() {
        super.model = new TravelAdvanceModel();
        super.pageMode = PageModes.add;

        if (this.travelAdvance) {
            super.model = this.travelAdvance;
            super.pageMode = PageModes.edit;
        }

        this.currencyDataAccessService.getAll().then((data) => {
            this.currencies = ObjectMapper.toAnonymous(data);
        });
    }

    storeDestination(form) {
        super.IsSubmittedFormValid(form).then(()=> {
            super.sendResponse(super.model);
        })
    }
}

TravelAdvanceController.$inject = ["currencyDataAccessService", "$injector"];