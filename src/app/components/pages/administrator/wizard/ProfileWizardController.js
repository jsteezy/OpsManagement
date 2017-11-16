import BaseController from "../../../common/BaseController";
import PageModes from "../../../../common/enums/pageModes.json";
import listOptions from "../../../../common/enums/listOptions";
import peoplePickerOptions from "../../../../common/enums/peoplePickerOptions";
import Languages from "../../../../common/enums/languages.json";
import GlobalFeaturesCache from "../../../../common/services/GlobalFeaturesCache";

export default class ProfileWizardController extends BaseController {
    constructor($injector,
        profileService,
        toastService) {
        super($injector);

        super.router = this.$router;

        this.title = "Create response code";

        this.profileService = profileService;

        this.toastService = toastService;

        this.languages = Languages.values;

        this.overrideListOptions();
        this.overridePickerOptions();
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate(next.params.userId);
        };

        return super.initializePage(init);
    }

    activate(userId) {
        super.model = this.profileService.buildModel(undefined, userId);
        super.pageMode = PageModes.add;

        let pageData = this.profileService.loadPageData().then((data) => {
            this.countries = data[0];
        });

        return super.initializePageData(pageData, this.loadExistingProfile(userId));
    }

    loadExistingProfile(userId) {
        return this.profileService.loadProfile(userId).then((data) => {
            super.model = this.profileService.buildModel(data, userId);
            super.pageMode = PageModes.edit;
        });
    }

    storeProfile(form) {
        super.IsSubmittedFormValid(form).then(() => {

            super.isRequestProcessing = true;
            console.log(super.model);

            let storeProfilePromise = this.profileService.store(super.pageMode, super.model);

            storeProfilePromise.then(
                () => {
                    this.toastService.showToast('Response code created', 'app');

                    GlobalFeaturesCache.hasProfile = true;

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        });
    }

    overrideListOptions() {
        this.listOptions = listOptions.options;
    }

    overridePickerOptions() {
        this.pickerOptions = peoplePickerOptions.options;
    }
}

ProfileWizardController.$inject = [
    "$injector",
    "profileService",
    "toastService"
];