import BaseController from "../../../common/BaseController";
import PageModes from "../../../../common/enums/pageModes.json";
import GlobalFeaturesCache from "../../../../common/services/GlobalFeaturesCache";

export default class ProfileWizardController extends BaseController {
    constructor($injector,
        profileService,
        toastService,
        responseService) {
        super($injector);

        super.router = this.$router;

        this.title = "Create response code";

        this.profileService = profileService;

        this.toastService = toastService;
        
        this.responseService = responseService;
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
            this.regions = data[1];
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

            console.log(this.responseService);
            let storeProfilePromise = this.responseService.store(super.pageMode, super.model);

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
}

ProfileWizardController.$inject = [
    "$injector",
    "profileService",
    "toastService",
    "responseService"
];