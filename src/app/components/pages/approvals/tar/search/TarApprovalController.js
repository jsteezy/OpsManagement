import BaseController from "../../../../common/BaseController";
import GridOptions from "../../../../../common/enums/gridOptions";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";

export default class TarApprovalController extends BaseController {
    constructor(tarApprovalService, $injector) {
        super($injector);

        super.router = this.$router;
        
        this.tarApprovalService = tarApprovalService;

        this.setBudgetOptions();
        this.setSecurityOptions();

        this.initFilters();

        this.registerEvents();
    }

    $routerOnActivate(next, current) {
        super.permissions = [
            super.appPermissions.budgetApprovers,
            super.appPermissions.gssApprovers,
            super.appPermissions.superBudgetApprovers
        ];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate();
        };

        return super.initializePage(init);
    }

    activate() {
        return super.initializePageData(this.loadBudgetList(), this.loadSecurityList());
    }

    loadBudgetList() {
        let budgetPromise = this.getBudgetTars();

        return budgetPromise.then(( data ) => {
            this.budgetOptions.data = data;
            this.budgetOptions.isGridReady = true;
        })

    }

    loadSecurityList(){
        return this.tarApprovalService.getSecurityList(this.securityFilters).then((data) => {
            this.securityOptions.data = data;
            this.securityOptions.isGridReady = true;
        })
    }

    budgetSearch() {
        super.isRequestProcessing = true;

        return this.loadBudgetList().then(
            () => {
                super.isRequestProcessing = false;
            },
            () => {
                this.budgetOptions.data = [];
                super.isRequestProcessing = false;
            }
        )
    }

    budgetReset() {
        this.budgetFilters.reset();
    }

    securitySearch() {
        super.isRequestProcessing = true;

        return this.loadSecurityList().then(
            () => {
                super.isRequestProcessing = false;
            },
            () => {
                this.securityOptions.data = [];
                super.isRequestProcessing = false;
            }
        )
    }

    securityReset() {
        this.securityFilters.reset();
    }

    setBudgetOptions() {
        this.budgetOptions = this.getBudgetGridOptions();
        this.budgetOptions.appScopeProvider = this;
    }

    setSecurityOptions() {
        this.securityOptions = GridOptions.options.securityApproval;
        this.securityOptions.appScopeProvider = this;
    }

    openTar(row) {
        this.$router.navigate(["TarApprovalWizard", { id: row.entity.id }])
    }

    initFilters() {
        this.budgetFilters = this.getBudgetFilters();

        this.securityFilters = this.tarApprovalService.securityApproverFilters;
    }

    registerEvents() {
        let gridSelectedListener = (data) => {
            this.selectedDrafts = data[0];
        }

        super.setListener(EventsTypes.gridSelectedRows, gridSelectedListener)
    }

    getBudgetTars() {
        return super.isSuperBudgetApprover() ?
            this.tarApprovalService.getAllBudgetList(this.budgetFilters) :
            this.tarApprovalService.getBudgetList(this.budgetFilters);

    }

    getBudgetFilters() {
        return super.isSuperBudgetApprover() ?
            this.tarApprovalService.superBudgetApproverFilters :
            this.tarApprovalService.budgetApproverFilters;
    }

    getBudgetGridOptions() {
        return super.isSuperBudgetApprover() ?
            GridOptions.options.superBudgetApproval :
            GridOptions.options.budgetApproval
    }
}

TarApprovalController.$inject = ["tarApprovalService", "$injector"];