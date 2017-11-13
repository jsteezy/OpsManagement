import BaseController from "../../../../common/BaseController";
import TarWizardModel from "./../../../../../common/models/TarWizardModel";
import TarValidator from "../../../../../common/services/tar/TarValidator";
import TarFeatures from "../../../../../common/services/tar/TarFeatures";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";
import PageModes from "../../../../../common/enums/pageModes.json";


export default class TarWizardController extends BaseController {
    constructor(
        $injector,
        tarWizardService,
        toastService) {

        super($injector);

        super.router = this.$router;

        this.tarWizardService = tarWizardService;
        this.tarValidator = TarValidator.instance;
        this.features = TarFeatures.instance;

        this.toastService = toastService;

        this.currencies = [];

        this.registerEvents();
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate(next.params.id);
        };

        return super.initializePage(init);
    }

    activate(tarIdentifier) {
        super.model = new TarWizardModel();
        super.pageMode = PageModes.add;

        let pageData = this.tarWizardService.loadPageData().then((data) => {
            this.currencies = data[0];
        });

        return super.initializePageData(pageData, this.loadModel(tarIdentifier));
    }

    loadModel(tarIdentifier) {
        return tarIdentifier ?
            this.loadExistingDraft(tarIdentifier) :
            this.loadEmptyModel();
    }

    loadEmptyModel() {
        return this.tarWizardService.buildModel()
            .then(
                (data) => {
                    super.model = data;
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
    }

    loadExistingDraft(tarIdentifier) {
        super.pageMode = PageModes.edit;

        return this.tarWizardService.loadDraft(tarIdentifier)
            .then(
                (data) => {
                    super.model = data;

                    super.emit(EventsTypes.initCommonTarFeatures, super.model);
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
    }

    reloadProfileForTraveller(value) {
        super.startSpinner();

        this.tarWizardService.clearProfileItems(super.model);
        this.tarWizardService.loadProfileForTraveller(value.Id, super.model)
            .then(
                () => {
                    super.stopSpinner();
                },
                (errorData) => {
                    super.stopSpinner();
                    super.serverRequestErrors = errorData;
                });
    }

    storeAsRequest(form) {
        super.IsSubmittedFormValid(form).then(() => {
            if (!this.tarValidator.isValid(super.model)) {
                this.toastService.showToast(this.tarValidator.errors);
                return;
            }

            super.isRequestProcessing = true;

            this.tarWizardService.storeRequest(super.model)
                .then(
                    () => {
                        super.redirectToHome();
                    },
                    (errorData) => {
                        super.serverRequestErrors = errorData;
                    })
        });
    }

    storeAsDraft() {
        super.isRequestProcessing = true;

        this.tarWizardService.storeDraft(super.pageMode, super.model)
            .then(
                () => {
                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
    }

    isReadyToSubmit() {
        return this.features.isReadyToSubmit(super.model);
    }

    registerEvents() {
        let peoplePickerListener = (data) => {
            if (data[0] == this.features.pickerOptions.travellerPickerOptions.name) {
                this.reloadProfileForTraveller(data[1]);
            }
        }

        super.setListener(EventsTypes.peoplePickerChange, peoplePickerListener)
    }
}

TarWizardController.$inject = [
    "$injector",
    "tarWizardService",
    "toastService"
];