import Answers from "../../../../../../common/enums/answers.json";
import EventsTypes from "../../../../../../common/enums/eventsTypes.json";
import AttachmentsOptions from "../../../../../../common/enums/attachmentsOptions";
import TarFeatures from "../../../../../../common/services/tar/TarFeatures";
import BaseComponentController from "../../../../../common/BaseComponentController";

export default class TarWizardCommonController extends BaseComponentController {
    constructor(tarWizardService, cache) {
        super();

        this.tarWizardService = tarWizardService;
        this.cache = cache;

        this.features = TarFeatures.instance;

        this.attachmentsOptions = AttachmentsOptions.empty;

        this.registerEvents();
    }

    isTravelAdvanceAvailable() {
        return this.model.londonOfficeLocation == Answers.yes;
    }

    hasVisa() {
        return this.model.visaRequired == Answers.yes;
    }

    registerEvents() {
        let listModelBeforeChange = () => {
            const cache = this.cache.getById("listModel");

            cache.put("destinations", this.model.destinations);
            cache.put("expensesCodes", this.model.expensesCodes);
        };

        super.setListener(EventsTypes.listModelBeforeChange, listModelBeforeChange);

        let listModelAfterChange = () => {
            this.features.setBudgetCodesTotalPercentage(this.model);
            this.features.setEstimatedTotalCosts(this.model);
        }

        super.setListener(EventsTypes.listModelAfterChange, listModelAfterChange);

        let initCommonTarFeatures = (data) => {
            this.features.initPageFeatures(data[0]);
            this.attachmentsOptions = AttachmentsOptions.tarDraftOptions(data[0].id);
        }
        
        super.setListener(EventsTypes.initCommonTarFeatures, initCommonTarFeatures);
    }

    isFieldErrorVisible(fieldName) {
        return this.form && (this.form.submitted || this.form[fieldName].$touched);
    }
}

TarWizardCommonController.$inject = ["tarWizardService", "cache"];