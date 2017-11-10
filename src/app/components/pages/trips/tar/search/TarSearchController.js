import BaseController from "../../../../common/BaseController";
import GridOptions from "../../../../../common/enums/gridOptions";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";
import ArrayUtils from "../../../../../common/helpers/ArrayUtils";

export default class TarSearchController extends BaseController {
    constructor(tarSearchService, $injector) {
        super($injector);

        super.router = this.$router;
        
        this.tarSearchService = tarSearchService;

        this.setWaitingForApprovalOptions();
        this.setDraftsOptions();

        this.selectedDrafts = [];

        this.initFilters();

        this.registerEvents();
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
        return super.initializePageData(
            this.loadWaitingForApprovalTars(), this.loadDraftTars());
    }

    loadWaitingForApprovalTars() {
        return this.tarSearchService.getTars(this.waitingForApprovalFilters).then((data) => {
            this.tarWaitingForApprovalOptions.data = data;
            this.tarWaitingForApprovalOptions.isGridReady = true;
        });
    }

    loadDraftTars() {
        return this.tarSearchService.getDrafts().then((data) => {
            this.tarDraftsOptions.data = data;
            this.tarDraftsOptions.isGridReady = true;
        });
    }

    openDraft(row) {
        super.redirectTo(["TarWizardDraftEdit", { id: row.entity.title }])
    }

    openTar(row) {
        super.redirectTo(["TarDetails", { id: row.entity.id }])
    }

    waitingForApprovalSearch() {
        super.isRequestProcessing = true;

        this.loadWaitingForApprovalTars().then(
            () => {
                super.isRequestProcessing = false;
            },
            () => {
                this.tarWaitingForApprovalOptions.data = [];
                super.isRequestProcessing = false;
            })

    }

    waitingForApprovalReset() {
        this.waitingForApprovalFilters.reset();
    }

    deleteDrafts() {
        super.isRequestProcessing = true;

        let deleteDraftPromises = this.tarSearchService.deleteDrafts(this.selectedDrafts.map(x => x.id));

        Promise.all(deleteDraftPromises)
            .then(
            () => {
                this.selectedDrafts.forEach((draft) => {
                    ArrayUtils.remove(this.tarDraftsOptions.data, draft);
                });

                super.isRequestProcessing = false;
            },
            (errorData) => {
                super.serverRequestErrors = errorData;
            });
    }

    setWaitingForApprovalOptions() {
        this.tarWaitingForApprovalOptions = GridOptions.options.waitingForApproval;
        this.tarWaitingForApprovalOptions.appScopeProvider = this;
    }

    setDraftsOptions() {
        this.tarDraftsOptions = GridOptions.options.drafts;
        this.tarDraftsOptions.appScopeProvider = this;
    }

    initFilters() {
        this.waitingForApprovalFilters = this.tarSearchService.waitingForApprovalFilters;
    }

    registerEvents(){
        let gridSelectedListener = (data) => {
            this.selectedDrafts = data[0];
        }

        super.setListener(EventsTypes.gridSelectedRows, gridSelectedListener);
    }
}

TarSearchController.$inject = ["tarSearchService", "$injector"];