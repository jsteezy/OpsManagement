import BaseController from "../../common/BaseController";
//import GridOptions from "../../../common/enums/gridOptions";

export default class AddReportController extends BaseController {
    constructor($window, $injector, responseService, reportsService) {
        super($injector);

        super.router = this.$router;
        this.responseService = responseService;
        this.reportsService = reportsService;
        this.$window = $window;

        //this.setResponseGridOptions();
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
                        console.log(super.model, "model");
                        
                        return super.model;
                        return Promise.resolve(true);
                    },
            () => {
                super.isRequestProcessing = false;
                return Promise.resolve(false);
            });    
    }

    // setResponseGridOptions() {
    //     this.responseCodeOptions = GridOptions.options.responseCodeOptions;
    //     this.responseCodeOptions.appScopeProvider = this;
    //     this.responseCodeOptions.isGridReady = true;
    //     this.responseCodeOptions.data = [];
    // }
}

AddReportController.$inject = ["$window", "$injector", "responseService", "reportsService"];