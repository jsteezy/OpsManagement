import BaseTarService from "./BaseTarService";
import ApprovalStatuses from "../../enums/approvalStatuses.json";

export default class TarApprovalWizardService extends BaseTarService {
    constructor(tarApprovalDataAccessService) {
        super();

        this.tarApprovalDataAccessService = tarApprovalDataAccessService;
    }

    approveTar(tarModel, comments) {
        return this.tarApprovalDataAccessService.getTarTask(tarModel.title).then((data) => {
            let task = {
                TaskOutcome: ApprovalStatuses.approved,
                Checkmark: "1",
                Status: ApprovalStatuses.completed,
                PercentComplete: 1,
                Body: comments
            };

            let tarUpdateModel = this.buildTarApprovalModel(tarModel, ApprovalStatuses.approved);

            let updateTarPromise = this.tarApprovalDataAccessService.updateTarStatus(tarModel.id, tarUpdateModel);

            let updateTaskPromise = this.tarApprovalDataAccessService.updateTarTask(data[0].Id, task);

            return Promise.all([updateTarPromise, updateTaskPromise]);
        });
    }

    rejectTar(tarModel, comments) {
        return this.tarApprovalDataAccessService.getTarTask(tarModel.title).then((data) => {
            let task = {
                TaskOutcome: ApprovalStatuses.rejected,
                Checkmark: "0",
                Status: ApprovalStatuses.completed,
                PercentComplete: 1,
                Body: comments
            };

            let tarUpdateModel = this.buildTarApprovalModel(tarModel, ApprovalStatuses.rejected);

            let updateTarPromise = this.tarApprovalDataAccessService.updateTarStatus(tarModel.id, tarUpdateModel);

            let updateTaskPromise = this.tarApprovalDataAccessService.updateTarTask(data[0].Id, task);

            return Promise.all([updateTarPromise, updateTaskPromise]);
        });
    }

    buildTarApprovalModel(tarModel, status) {
        let approvalFields = this.getApprovalProperties(tarModel);
        let tarUpdateModel = {};
        tarUpdateModel[approvalFields.status] = status;
        tarUpdateModel[approvalFields.timestamp] = new Date();

        return tarUpdateModel;
    }

    getApprovalProperties(tarModel) {
        if (tarModel.budgetApprovalStatus === ApprovalStatuses.none ||
            tarModel.budgetApprovalStatus === ApprovalStatuses.pending) {

            return {
                'status': tarModel.budgetApprovalPropertyName,
                'timestamp': tarModel.budgetApprovalTimestampPropertyName
            };
        } else if (tarModel.gSSApprovalStatus === ApprovalStatuses.none ||
            tarModel.gSSApprovalStatus === ApprovalStatuses.pending) {

            return {
                'status': tarModel.gSSApprovalPropertyName,
                'timestamp': tarModel.gSSApprovalTimestampPropertyName
            };
        }

        return null;
    }

    checkIfWaitingForBudgetApproval(tarModel) {
        return tarModel.budgetApprovalStatus === ApprovalStatuses.pending;
    }

    checkIfTarRejected(tarModel) {
        if (tarModel.budgetApprovalStatus === ApprovalStatuses.rejected ||
            tarModel.gSSApprovalStatus === ApprovalStatuses.rejected) {
            return true;
        }

        return false;
    }
}

TarApprovalWizardService.$inject = ["tarApprovalDataAccessService"];