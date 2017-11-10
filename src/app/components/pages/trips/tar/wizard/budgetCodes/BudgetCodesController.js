import BaseModalController from "../../../../../common/BaseModalController";
import BudgetCodesModel from "./../../../../../../common/models/BudgetCodesModel";
import PageModes from "../../../../../../common/enums/pageModes.json";
import BottomListOptions from "../../../../../../common/enums/bottomListOptions";
import ObjectMapper from "../../../../../../common/helpers/ObjectMapper";

export default class BudgetCodesController extends BaseModalController {
    constructor($injector, commonDataService, bottomSheetService, cache) {
        super($injector);

        this.commonDataService = commonDataService;

        this.bottomSheetService = bottomSheetService;
        this.cache = cache;

        this.overrideBottomListOptions();

        this.accountCodes = [];

        this.activate();
    }

    activate() {
        super.model = new BudgetCodesModel();
        super.pageMode = PageModes.add;

        this.commonDataService.loadAccountCodes().then((data) =>{
            this.accountCodes = data;
        });

        if (this.budgetCode) {
            super.model = this.budgetCode;
            super.pageMode = PageModes.edit;
        }
    }

    storeBudgetCode(form) {
        super.IsSubmittedFormValid(form).then(() => {
            super.sendResponse(super.model);
        });
    }

    showDefaultCodes() {
        const cache = this.cache.getById("listModel");
        const expensesCodes = cache.get("expensesCodes");

        this.bottomSheetService
            .open(expensesCodes, this.bottomListOptions.expensesCodesListOptions)
            .then((existingCode) => {
                ObjectMapper.toObject(existingCode, super.model);
            });
    }

    overrideBottomListOptions() {
        this.bottomListOptions = BottomListOptions.options;

        this.bottomListOptions.expensesCodesListOptions.parentTag = "budget-codes";
    }
}

BudgetCodesController.$inject = ["$injector", "commonDataService", "bottomSheetService", "cache"];