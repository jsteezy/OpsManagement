import BaseController from "../../common/BaseController";
import GridOptions from "../../../common/enums/gridOptions";

export default class ReportsController extends BaseController {
    constructor($window, $injector, reportsService) {
        super($injector);

        super.router = this.$router;
        this.reportsService = reportsService;
        
        this.$window = $window;

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

    loadAllReports(id) {
        return this.reportsService.getAllReports()
        .then(
            (data) => {
                this.reportOptions.data = data;
                  

                super.isRequestProcessing = false;

                return Promise.resolve(true);
            },
            () => {
                super.isRequestProcessing = false;
                this.reportOptions.data = [];

                return Promise.resolve(false);
            });
    }

    setReportsGridOptions() {
        this.reportOptions = GridOptions.options.reportOptions;
        this.reportOptions.appScopeProvider = this;
        this.reportOptions.isGridReady = true;
        this.reportOptions.data = [];
    }

    // initFilters() {
    //     this.tarHistoryFilters = this.tarHistoryService.historyFilters;
    // }
}

ReportsController.$inject = ["$window", "$injector", "reportsService"];