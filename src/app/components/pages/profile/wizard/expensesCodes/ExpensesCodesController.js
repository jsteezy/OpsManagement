import ExpensesCodesModel from "../../../../../common/models/ExpensesCodesModel.js";
import BaseModalController from "../../../../common/BaseModalController";
import pageModes from "../../../../../common/enums/pageModes.json";

export default class ExpensesCodesController extends BaseModalController {
    constructor($injector) {
        super($injector);

        this.activate();
    }

    activate() {
        super.model = new ExpensesCodesModel();
        super.pageMode = pageModes.add;
        
        if (this.expensesCode) {
            super.model = this.expensesCode;
            super.pageMode = pageModes.edit;
        }
    }

    storeCodes(form) {
        super.IsSubmittedFormValid(form).then(() => {
            super.sendResponse(super.model);
        });
    }
}

ExpensesCodesController.$inject = ["$injector"];