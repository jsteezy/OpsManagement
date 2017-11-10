import ObjectMapper from "../../helpers/ObjectMapper";
import TarDetailsModel from "../../models/TarDetailsModel";
import BaseTarService from "./BaseTarService";
import workflowStatus from "../../../common/enums/status.json";

export default class TarDetailsService extends BaseTarService {
    constructor(tarDataAccessService, cache) {
        super(cache);

        this.tarDataAccessService = tarDataAccessService;
    }

    buildModel(id) {
        let model = new TarDetailsModel();

        return this.tarDataAccessService.getTar(id)
            .then(
            (data) => {
                if (data) {
                    ObjectMapper.toObject(data, model);

                    super.cacheCurrentTravellerId(model.travellerId);

                    model.initPeoplePickers();
                }

                return model;
            },
            (errorData) => {
                return Promise.reject(errorData);
            })
    }

    buildWorkflowModel(model) {
        let tarApprovalCompleted = workflowStatus.Pending;
        if (workflowStatus[model.budgetApprovalStatus] === workflowStatus.Approved) {
            let gssApprovalStatus = workflowStatus[model.gSSApprovalStatus];

            if (!model.requiresGssApproval) {
                tarApprovalCompleted = workflowStatus.Completed;
            } else {
                tarApprovalCompleted = gssApprovalStatus;
            }
        } else {
            tarApprovalCompleted = workflowStatus[model.budgetApprovalStatus];
        }

        let workflowStartStatus = workflowStatus.None;
        if (workflowStatus[model.budgetApprovalStatus] !== workflowStatus.None ||
            workflowStatus[model.budgetApprovalStatus] !== workflowStatus.Pending) {
            
            workflowStartStatus = workflowStatus.Approved;
        }

        return [
            {
                name: "WF_PENDING",
                status: workflowStartStatus
            },
            {
                name: "WF_BUDGET_APPROVAL",
                status: workflowStatus[model.budgetApprovalStatus]
            },
            {
                name: "WF_GSS_APPROVAL",
                status: workflowStatus[model.gSSApprovalStatus]
            },
            {
                name: "WF_COMPLETED",
                status: tarApprovalCompleted
            }
        ];
    }
}

TarDetailsService.$inject = ["tarDataAccessService", "cache"];