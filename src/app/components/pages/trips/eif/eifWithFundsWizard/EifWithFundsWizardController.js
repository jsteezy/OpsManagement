import BaseController from "../../../../common/BaseController";
import EifFeatures from "../../../../../common/services/eif/EifFeatures";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";
import PageModes from "../../../../../common/enums/pageModes.json";
import TarValidator from "../../../../../common/services/tar/TarValidator";
import questionsOptions from "../../../../../common/enums/questionsOptions.js";

export default class EifWithFundsWizardController extends BaseController {
    constructor(
        $injector,
        eifWizardService,
        toastService ) {

        super($injector);

        super.router = this.$router;

        this.eifWizardService = eifWizardService;

        this.features = EifFeatures.instance;
        this.tarValidator = TarValidator.instance;
        
        this.toastService = toastService;

        this.title = "EIF_REQUEST";

        this.countries = [];
        this.currencies = [];
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate(next.params);
        };

        return super.initializePage(init);
    }

    activate(params) {
        super.model = this.eifWizardService.buildModel();
        super.pageMode = PageModes.add;

        super.emit(EventsTypes.hideQuestion, questionsOptions.options.photoIdOptions.name);

        let pageData = this.eifWizardService.loadPageData().then((data) => {
            this.countries = data[0];
            this.currencies = data[1];
        });

        return super.initializePageData(pageData, this.loadDraft(params.eifId, params.tarId));
    }

    loadDraft(eifIdentifier, tarIdentifier) {
        if (!eifIdentifier || !tarIdentifier) return Promise.resolve(true);

        super.pageMode = PageModes.edit;

        return this.eifWizardService.loadDraft(eifIdentifier, tarIdentifier)
            .then(
            (data) => {
                super.model = data;

                super.emit(EventsTypes.initCommonEifFeatures, super.model.eif);
                super.emit(EventsTypes.initCommonTarFeatures, super.model.tar);
            },
            (errorData) => {
                super.serverRequestErrors = errorData;
            });
    }

    storeAsRequest(form) {
        super.IsSubmittedFormValid(form).then(() => {
            if (!this.tarValidator.isValid(super.model.tar)) {
                this.toastService.showToast(this.tarValidator.errors);
                return;
            }

            super.isRequestProcessing = true;

            this.eifWizardService.storeRequest(super.model)
                .then(() => {
                    super.redirectTo(["EifSearch"]);
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        });
    }

    storeAsDraft() {
        super.isRequestProcessing = true;

        this.eifWizardService.storeDraft(super.pageMode, super.model)
            .then(
            () => {
                super.redirectTo(["EifSearch"]);
            },
            (errorData) => {
                super.serverRequestErrors = errorData;
            });
    }

    isReadyToSubmit() {
        return super.model.eif.formSubmitConfirmation &&
            this.features.isReadyToSubmit(super.model.eif);
    }
}

EifWithFundsWizardController.$inject = [
    "$injector",
    "eifWithFundsWizardService",
    "toastService"];