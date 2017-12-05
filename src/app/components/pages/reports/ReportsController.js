import BaseController from "../../common/BaseController";
import GridOptions from "../../../common/enums/gridOptions";

export default class ReportsController extends BaseController {
    constructor($window, $injector, reportsService, responseService) {
        super($injector);

        super.router = this.$router;
        this.responseService = responseService;
        this.reportsService = reportsService;
        
        this.$window = $window;
        this.setResponseGridOptions();        
        this.setReportsGridOptions();
        //this.initFilters();        
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];
        
        let init = () => {
            super.$routerOnActivate(next, current);

            return this.activate(next.params.id);
        };

        return super.initializePage(init);
    }

    activate(responseId) {
        return super.initializePageData(this.loadAllReports(responseId));
    }

    loadAllReports(responseId) {
        this.responseService.getResponse(responseId)
        .then(
            (data) => {
                var responseModel = this.responseService.buildModel(data);
                return this.reportsService.getAllReports(responseId)
                .then(
                    (data) => {
                        this.reportOptions.data = data;
                        this.reportOptions.responseId = responseId;
                        console.log(responseModel, "responseModel");
                        super.isRequestProcessing = false;
                        return [this.reportOptions.data, responseModel];
                        
                        //return Promise.resolve(true);
                    },
                    () => {
                        super.isRequestProcessing = false;
                        this.reportOptions.data = [];
                        this.reportOptions.responseId = responseId;
        
                        return Promise.resolve(false);
                    });
            },
            () => {
                super.isRequestProcessing = false;
                this.reportOptions.data = [];
                this.reportOptions.responseId = responseId;

                return Promise.resolve(false);
            });     
    }

    // createReport(responseId) {
    //     return this.reportsService.buildModel(undefined, responseId)
    //     .then(
    //         (data) => {
    //             super.model = data;
                
    //         },
    //         (errorData) => {
    //             super.serverRequestErrors = errorData;
    //         });
    // }

    // createReport(responseId) {
    //     super.redirectTo(["AddReport", { id: responseId }])
    // }

    // editReport(responseId, reportId) {
    //     super.redirectTo(["EditReport", { id: responseId, reportId: reportId  }])
    // }

    openReport(responseId, reportId) {
        super.redirectTo(["AddReport", { id: responseId, reportId: reportId  }])
    }

    createReport(responseId) {
        super.redirectTo(["CreateReport", { id: responseId}])
    }

    // loadEmptyModel() {
    //     return this.tarWizardService.buildModel()
    //         .then(
    //             (data) => {
    //                 super.model = data;
    //             },
    //             (errorData) => {
    //                 super.serverRequestErrors = errorData;
    //             });
    // }

    setResponseGridOptions() {
        this.responseCodeOptions = GridOptions.options.responseCodeOptions;
        this.responseCodeOptions.appScopeProvider = this;
        this.responseCodeOptions.isGridReady = true;
        this.responseCodeOptions.data = [];
    }

    setReportsGridOptions() {
        this.reportOptions = GridOptions.options.reportOptions;
        this.reportOptions.appScopeProvider = this;
        this.reportOptions.isGridReady = true;
        this.reportOptions.data = [];
    }
}

ReportsController.$inject = ["$window", "$injector", "reportsService", "responseService"];