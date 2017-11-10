import BaseController from "../../../common/BaseController";
import GridOptions from "../../../../common/enums/gridOptions";

export default class TarHistoryController extends BaseController {
    constructor( $injector, tarHistoryService, modalService ) {
        super($injector);

        super.router = this.$router;

        this.title = "TAR_HISTORY_TITLE";

        this.tarHistoryService = tarHistoryService;
        this.modalService = modalService;

        this.setHistoryGridOptions();

        this.initFilters();
    }

    $routerOnActivate( next, current ) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate();
        };

        return super.initializePage(init);
    }

    activate() {
        return super.initializePageData(this.search());
    }

    search() {
        super.isRequestProcessing = true;

        return this.tarHistoryService.getTars(this.tarHistoryFilters)
            .then(
                ( data ) => {
                    this.tarHistoryOptions.data = data;

                    super.isRequestProcessing = false;

                    return Promise.resolve(true);
                },
                () => {
                    super.isRequestProcessing = false;
                    this.tarHistoryOptions.data = [];

                    return Promise.resolve(false);
                });
    }

    reset() {
        this.tarHistoryFilters.reset();
    }

    openTar( row ) {
        let tar = this.tarHistoryOptions.data.find(x => x.id == row.entity.id);

        this.modalService.showWizardModal(
                `<tar-history-details ng-model="ctrl.entityModel"></tar-history-details>`,
                null,
                this.tarHistoryService.getDetailsModel(tar.detailsViewData));
    }

    setHistoryGridOptions() {
        this.tarHistoryOptions = GridOptions.options.tarHistoryOptions;
        this.tarHistoryOptions.appScopeProvider = this;
        this.tarHistoryOptions.isGridReady = true;
        this.tarHistoryOptions.data = [];
    }

    initFilters() {
        this.tarHistoryFilters = this.tarHistoryService.historyFilters;
    }
}

TarHistoryController.$inject = [
    "$injector",
    "tarHistoryService",
    "modalService"
];