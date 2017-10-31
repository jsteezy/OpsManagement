import BaseController from "../../../../common/BaseController";
import EventsTypes from "../../../../../common/enums/eventsTypes.json";

export default class TarApprovalWizardController extends BaseController {
    constructor(tarApprovalWizardService, $injector, toastService) {
        super($injector);

        super.router = this.$router;
        this.toastService = toastService;

        this.title = "TAR_APPROVE";

        this.tarApprovalWizardService = tarApprovalWizardService;
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.budgetApprovers, super.appPermissions.superBudgetApprovers, super.appPermissions.gssApprovers];

        let init = () => {
            if (super.$routerOnActivate(next, current)) {
                this.activate(next.params.id);
            }
        };

        return super.initializePage(init);
    }

    activate(tarId) {
        this.tarModel = {};
        this.comments = "";

        super.setListener(EventsTypes.approvalDetailsLoaded, (data) => {
            this.tarModel = data[0];

            this.validateTarApproval();
        });

        super.redirectTo(["ApproveDetails", { id: tarId }]);
    }

    validateTarApproval() {
        if (this.tarApprovalWizardService.checkIfWaitingForBudgetApproval(this.tarModel)) {
            if (!super.isSuperBudgetApprover() &&
                (!
                    (super.isBudgetApprover() &&
                    super.currentUser().Id === this.tarModel.budgetApproverId)
                )
            ) {
                super.redirectTo(["AccessDenied"]);
            }
        }

        if (this.tarApprovalWizardService.checkIfTarRejected(this.tarModel)) {
            super.redirectTo(["TarApproval"]);
            this.toastService.showToast("TAR_REJECTED_APPROVAL_ERROR");
            return;
        }

        if (this.tarApprovalWizardService.getApprovalProperties(this.tarModel) == null) {
            super.redirectTo(["TarApproval"]);
            this.toastService.showToast("TAR_COMPLETED_APPROVAL_ERROR");
        }
    }

    approve() {
        super.isRequestProcessing = true;

        let approvalPromise = this.tarApprovalWizardService.approveTar(this.tarModel, this.comments);
        this.handlePromise(approvalPromise);
    }

    reject() {
        if (!this.comments || 0 === this.comments.length) {
            this.toastService.showToast("TAR_REJECT_COMMENTS_ERROR");
            return;
        }

        super.isRequestProcessing = true;

        let rejectionPromise = this.tarApprovalWizardService.rejectTar(this.tarModel, this.comments);
        this.handlePromise(rejectionPromise);
    }

    handlePromise(promise) {
        promise.then(() => {
            super.redirectTo(["TarApproval"]);
        }, (errorData) => {
            if (errorData) {
                super.serverRequestErrors = errorData;
            }
            else {
                this.toastService.showToast("TAR_APPROVAL_ERROR");
            }

            super.isRequestProcessing = false;
        });
    }
}

TarApprovalWizardController.$inject = ["tarApprovalWizardService", "$injector", "toastService"];