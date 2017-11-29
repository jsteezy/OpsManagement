import BaseController from "../../common/BaseController";

export default class ResponseController extends BaseController {
    constructor($injector,
        responseService,
        toastService) {
        super($injector);

        super.router = this.$router;

        this.title = "Create";

        this.responseService = responseService;

        this.toastService = toastService;
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate();
        };

        return super.initializePage(init);
    }

    activate() {
        super.model = this.responseService.buildModel(undefined);
        
        let pageData = this.responseService.loadPageData().then((data) => {
            this.countries = data[0];
            this.regions = data[1];
        });

        return super.initializePageData(pageData);
    }


    storeResponse(form) {
        super.IsSubmittedFormValid(form).then(() => {

            super.isRequestProcessing = true;
            console.log(super.model);

            let storeResponsePromise = this.responseService.store(super.pageMode, super.model);

            storeResponsePromise.then(
                () => {
                    this.toastService.showToast('Response code created', 'app');

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        });
    }
}

ResponseController.$inject = [
    "$injector",
    "responseService",
    "toastService"
];