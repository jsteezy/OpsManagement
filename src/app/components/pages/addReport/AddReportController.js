import BaseController from "../../common/BaseController";

export default class AddReportController extends BaseController {
    constructor($window, $injector, responseService, reportsService, toastService) {
        super($injector);

        super.router = this.$router;
        this.responseService = responseService;
        this.reportsService = reportsService;
        this.toastService = toastService;
        this.$window = $window;
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            if (super.$routerOnActivate(next, current)) {
                this.activate(next.params.id);
            }
        };

        return super.initializePage(init);
    }

    activate(responseId) {

        return super.initializePageData(this.loadResponseDetails(responseId));
    }

    loadResponseDetails(responseId) {
        this.responseService.getResponse(responseId)
        .then(
            (data) => {
                super.model = this.reportsService.buildModel(data)
                super.isRequestProcessing = false;
                super.model = responseId;
                       // console.log(super.model, "model");

                var responseModel = this.responseService.buildModel(data);
                //console.log(responseModel, "responseModel");
                
                        return [super.model, responseModel];
                    },
            () => {
                super.isRequestProcessing = false;
                return Promise.resolve(false);
            });    
    }

    submitReport(form) {
       

            super.isRequestProcessing = true;

            var model = this.reportsService.buildModel(super.model);

            let storeResponsePromise = this.reportsService.store(model);
            console.log(model, "model");
            
            storeResponsePromise.then(
                () => {
                    this.toastService.showToast('Report submitted created', 'app');

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        
    }
}

AddReportController.$inject = ["$window", "$injector", "responseService", "reportsService", "toastService"];