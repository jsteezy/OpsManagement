import BaseController from "../../../../common/BaseController";
import GridOptions from "../../../../../common/enums/gridOptions";
import GridHelpers from "../../../../../common/helpers/GridHelpers";
import ArrayUtils from "../../../../../common/helpers/ArrayUtils";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";

export default class EifSearchController extends BaseController {
    constructor($injector, eifSearchService) {
        super($injector);

        super.router = this.$router;

        this.eifSearchService = eifSearchService;

        this.selectedDrafts = [];

        this.setDraftsOptions();

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
        return super.initializePageData(this.loadDraftEifs(), this.loadSubmittedEifs());
    }

    loadDraftEifs() {
        return this.eifSearchService.getDrafts().then((data) => {
            this.eifDraftsOptions.data = this.eifSearchService.getDataForDrafts(data);
            this.eifDraftsOptions.isGridReady = true;
        });
    }

    loadSubmittedEifs() {
        return this.eifSearchService.getSubmitted().then((data) => {
            this.eifSubmittedOptions.data = this.eifSearchService.getDataForSubmitted(data);
            this.eifSubmittedOptions.isGridReady = true;
        });
    }

    setDraftsOptions() {
        this.eifDraftsOptions = GridOptions.options.eifDrafts;
        this.eifDraftsOptions.appScopeProvider = this;

        this.eifSubmittedOptions = GridOptions.options.eifSubmitted;
        this.eifSubmittedOptions.appScopeProvider = this;
    }

    openDraft(row) {
        if (GridHelpers.eifRowHasOneTarAssociated(row)) {
            super.redirectTo(["EifWithFundsWizardEdit", { eifId: row.entity.title, tarId: row.entity.tarId }]);
        } else {
            super.redirectTo(["EifWizardDraftEdit", { id: row.entity.title }]);
        }
    }

    openEif(row) {
        if (GridHelpers.eifRowHasOneTarAssociated(row)) {
            super.redirectTo(["EifWithFundsDetails", { eifId: row.entity.title, tarId: row.entity.tarId }]);
        } else {
            super.redirectTo(["EifDetails", { id: row.entity.title }]);
        }
    }

    openTarDraft(row) {
        super.redirectTo(["TarWizardDraftEdit", { id: row.entity.tarId }]);
    }

    openTar(row) {
        super.redirectTo(["TarDetails", { id: row.entity.tarId }]);
    }

    deleteDrafts() {
        super.isRequestProcessing = true;

        let deleteDraftPromises = this.eifSearchService.deleteDrafts(this.selectedDrafts.map((item) => { return { "id": item.id, "tarId": item.tarId } }));

        Promise.all(deleteDraftPromises).then(() => {
            this.selectedDrafts.forEach((draft) => {
                ArrayUtils.remove(this.eifDraftsOptions.data, draft);
            });

            super.isRequestProcessing = false;
        }, (errorData) => {
            super.serverRequestErrors = errorData;
        });
    }

    registerEvents() {
        let gridSelectedListener = (data) => {
            this.selectedDrafts = data[0];
        }

        super.setListener(EventsTypes.gridSelectedRows, gridSelectedListener);
    }
}

EifSearchController.$inject = ["$injector", "eifSearchService"];