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
                //console.log(next.params, "next.params");
                this.activate(next.params.id, next.params.reportId);
            }
        };

        return super.initializePage(init);
    }

    activate(responseId, reportId) {

        return super.initializePageData(this.loadResponseDetails(responseId, reportId));
    }

    loadResponseDetails(responseId, reportId) {
        super.isRequestProcessing = true;
        
        this.responseService.getResponse(responseId)
        .then(
            (responseData) => {
                var responseModel = this.responseService.buildModel(responseData);
                
                if(reportId != null)
                {
                this.reportsService.getReport(reportId)
                .then(
                    (reportData) => {
                        super.model = this.reportsService.buildModel(reportData)      
                        super.model.responseId = responseId;
                },)
            }
            else {
                super.model = this.reportsService.buildModel(responseData)                
            }
                super.isRequestProcessing = false;
                console.log(super.model, "reportModel");

                console.log(responseModel, "responseModel");

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
           // model.responseId 
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