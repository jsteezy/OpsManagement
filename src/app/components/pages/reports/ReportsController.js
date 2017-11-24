import BaseController from "../../common/BaseController";
import GridOptions from "../../../common/enums/gridOptions";

export default class ReportsController extends BaseController {
    constructor($window, $injector, responseService) {
        super($injector);

        super.router = this.$router;
        this.responseService = responseService;
        
        this.$window = $window;

        this.setResponseGridOptions();
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
        return super.initializePageData(this.loadResponse(responseId));
    }

    loadResponse(id) {
        return this.tarDetailsService.buildModel(id)
            .then(
            (data) => {
                super.model = data;

                // super.emit(EventsTypes.initCommonTarDetails, super.model);
                // super.emit(EventsTypes.approvalDetailsLoaded, super.model);
            },
            (errorData) => {
                super.serverRequestErrors = errorData;
            });
    }

    // $routerOnActivate(next, current) {

    //     super.permissions = [super.appPermissions.everyone];

    //     let init = () => {
    //         if (super.$routerOnActivate(next, current)) {
    //             this.activate();
    //         }
    //     };

    //     return super.initializePage(init);
    // }

    // activate() {        
    //     return super.initializePageData(this.getReports(responseId));
    // }

    // getReports() {
    //     super.isRequestProcessing = true;

    //     return this.reportService.getAllReports(responseId)
    //         .then(
    //             (data) => {
    //                 this.responseCodeOptions.data = data;
    //                 console.log(this.responseCodeOptions);
                    

    //                 super.isRequestProcessing = false;

    //                 return Promise.resolve(true);
    //             },
    //             () => {
    //                 super.isRequestProcessing = false;
    //                 this.responseCodeOptions.data = [];

    //                 return Promise.resolve(false);
    //             });
    // }

    setResponseGridOptions() {
        this.responseCodeOptions = GridOptions.options.responseCodeOptions;
        this.responseCodeOptions.appScopeProvider = this;
        this.responseCodeOptions.isGridReady = true;
        this.responseCodeOptions.data = [];
    }

    // initFilters() {
    //     this.tarHistoryFilters = this.tarHistoryService.historyFilters;
    // }
}

ReportsController.$inject = ["$window", "$injector", "responseService"];