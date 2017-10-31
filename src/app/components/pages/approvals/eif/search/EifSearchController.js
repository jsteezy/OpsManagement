import BaseController from "../../../../common/BaseController";
import GridOptions from "../../../../../common/enums/gridOptions";
import GridHelpers from "../../../../../common/helpers/GridHelpers";

export default class EifSearchAllController extends BaseController {
    constructor(eifSearchService, $injector) {
        super($injector);

        super.router = this.$router;
        
        this.eifSearchService = eifSearchService;

        this.setAllEifsOptions();

        this.initFilters();
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.gssApprovers];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate();
        };

        return super.initializePage(init);
    }

    activate() {
        return super.initializePageData(this.loadAllEifs());
    }

    loadAllEifs(){
        return this.eifSearchService.getAllRequests(this.eifFilters).then(( data ) => {
            this.eifSearchAllOptions.data = data;
            this.eifSearchAllOptions.isGridReady = true;
        })
    }

    openEif( row ) {
        if (GridHelpers.eifRowHasOneTarAssociated(row)) {
            super.redirectTo(["EifWithFundsDetails", { eifId: row.entity.title, tarId: row.entity.tarId }]);
        } else {
            super.redirectTo(["EifDetails", { id: row.entity.title }]);
        }
    }

    openTar( row ) {
        super.redirectTo(["TarDetails", { id: row.entity.tarId }]);
    }

    search() {
        super.isRequestProcessing = true;

        return this.loadAllEifs().then(
            () => {
                super.isRequestProcessing = false;
            },
            () => {
                this.eifSearchAllOptions.data = [];
                super.isRequestProcessing = false;
            }
        )
    }

    reset() {
        this.eifFilters.reset();
    }

    setAllEifsOptions() {
        this.eifSearchAllOptions = GridOptions.options.eifSearchAllOptions;
        this.eifSearchAllOptions.appScopeProvider = this;
    }

    initFilters() {
        this.eifFilters = this.eifSearchService.eifFilters;
    }
}

EifSearchAllController.$inject = ["eifSearchService", "$injector"];