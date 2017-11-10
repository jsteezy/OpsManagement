import BaseController from "../../../../common/BaseController";
import EifFeatures from "../../../../../common/services/eif/EifFeatures";
import PageModes from "../../../../../common/enums/pageModes.json";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";
import EifValidator from "../../../../../common/services/eif/EifValidator";

export default class EifWizardController extends BaseController {
    constructor(
        $injector,
        peoplePickerService,
        eifWizardService,
        toastService,
        modalService,
        cache) {

        super($injector);

        super.router = this.$router;

        this.$injector = $injector;
        this.peoplePickerService = peoplePickerService;

        this.eifWizardService = eifWizardService;
        this.features = EifFeatures.instance;
        this.eifValidator = EifValidator.instance;

        this.toastService = toastService;
        this.modalService = modalService;

        this.cache = cache;

        this.title = "EIF_REQUEST";

        this.countries = [];
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate(next.params.id);
        };

        return super.initializePage(init);
    }

    activate(eifIdentifier) {
        this.tryToRedirectToFundedEif(eifIdentifier);

        super.model = this.eifWizardService.buildModel();
        super.pageMode = PageModes.add;

        let pageData = this.eifWizardService.loadPageData().then((data) => {
            this.countries = data[0];
        });

        return super.initializePageData(pageData, this.loadDraft(eifIdentifier));
    }

    loadDraft(eifIdentifier) {
        if (!eifIdentifier) return Promise.resolve(true);

        super.pageMode = PageModes.edit;

        return this.eifWizardService.loadDraft(eifIdentifier)
            .then(
            (data) => {
                super.model = data;

                super.emit(EventsTypes.initCommonEifFeatures, super.model);
            },
            (errorData) => {
                super.serverRequestErrors = errorData;
            });
    }

    tryToRedirectToFundedEif(eifIdentifier) {
        if (eifIdentifier) return;

        this.modalService
            .showConfirmDialog("SCI_FUNDS_QUESTION")
            .then(() => {
                super.redirectTo(["EifWithFundsWizardAdd"])
            });
    }

    storeAsRequest(form) {
        super.IsSubmittedFormValid(form).then(() => {
            if (!this.eifValidator.isValid(super.model)) {
                this.toastService.showToast(this.eifValidator.errors);
                return;
            }

            super.isRequestProcessing = true;

            this.eifWizardService.storeRequest(super.model)
                .then(
                () => {
                    super.redirectTo(["EifSearch"]);
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                })
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
        return this.features.isReadyToSubmit(super.model);
    }
}

EifWizardController.$inject = [
    "$injector",
    "peoplePickerService",
    "eifWizardService",
    "toastService",
    "modalService",
    "cache"];