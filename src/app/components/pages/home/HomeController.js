import BaseController from "../../common/BaseController";
import GridOptions from "../../../common/enums/gridOptions";

export default class HomeController extends BaseController {
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
            if (super.$routerOnActivate(next, current)) {
                this.activate();
            }
        };

        return super.initializePage(init);
    }

    activate() {
        return super.initializePageData(this.getAllResponses());
    }

    openResponse(responseId) {
        super.redirectTo(["Reports", { id: responseId }])
    }


    getAllResponses() {
        super.isRequestProcessing = true;

        return this.responseService.getAllResponses()
            .then(
                (data) => {
                    this.responseCodeOptions.data = data;
                    
                    // var data = this.responseCodeOptions.data;
                    // this.tableParams = new NgTableParams({}, { dataset: data});
                    
                    super.isRequestProcessing = false;

                    return Promise.resolve(true);
                },
                () => {
                    super.isRequestProcessing = false;
                    this.responseCodeOptions.data = [];

                    return Promise.resolve(false);
                });
    }

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

HomeController.$inject = ["$window", "$injector", "responseService"];