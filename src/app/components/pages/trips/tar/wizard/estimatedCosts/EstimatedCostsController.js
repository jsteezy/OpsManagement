import BaseModalController from "../../../../../common/BaseModalController";
import EstimatedCostsModel from "./../../../../../../common/models/EstimatedCostsModel";
import PageModes from "../../../../../../common/enums/pageModes.json";

export default class EstimatedCostsController extends BaseModalController {
    constructor($injector) {
        super($injector);

        this.activate();
    }

    activate() {
        super.model = new EstimatedCostsModel();
        super.pageMode = PageModes.add;

        if (this.estimatedCost) {
            super.model = this.estimatedCost;
            super.pageMode = PageModes.edit;
        }
    }

    store(form) {
        super.IsSubmittedFormValid(form).then(()=> {
            super.sendResponse(super.model)
        })
    }

    calculateTotal(){
        super.model.totalCosts = super.model.estimatedBoard + super.model.otherCosts;
    }
}

EstimatedCostsController.$inject = ["$injector"];