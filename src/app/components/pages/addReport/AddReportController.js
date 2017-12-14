import BaseController from "../../common/BaseController";
import ApprovalStatuses from "../../../common/enums/approvalStatuses.json";
import Phase from "../../../common/enums/phase.json";

export default class AddReportController extends BaseController {
    constructor($window, $injector, responseService, reportsService, toastService) {
        super($injector);

        super.router = this.$router;
        this.responseService = responseService;
        this.reportsService = reportsService;
        this.ApprovalStatuses = ApprovalStatuses;
        this.phase = Phase;

        this.toastService = toastService;
        this.$window = $window;

        this.readOnly = true;
        this.approve = false;
        this.reject = false;
        this.submit = false;
        this.saveDraft = false;
        this.convertToDraft = false;
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            if (super.$routerOnActivate(next, current)) {
                this.activate(next.params.id, next.params.reportId);
            }
        };

        return super.initializePage(init);
    }

    activate(responseId, reportId) {

        return super.initializePageData(this.loadResponseDetails(responseId, reportId));
    }

    loadResponseDetails(responseId, reportId) {
        super.isRequestProcessing = true;

        this.responseService.getResponse(responseId)
            .then(
                (responseData) => {
                    var responseModel = this.responseService.buildModel(responseData);

                    if (reportId != null) {
                        this.reportsService.getReport(reportId)
                            .then(
                                (reportData) => {
                                    super.model = this.reportsService.buildModel(reportData)
                                    super.model.responseId = responseId;

                                    super.model = this.updateBools(super.model);

                                    switch (super.model.status) {
                                        case ApprovalStatuses.draft:
                                            if (this.hasPermissions([super.appPermissions.admin])) {
                                                //admin has all actions, non-read only
                                                this.readOnly = false;
                                                this.approve = false;
                                                this.reject = false;
                                                this.submit = true;
                                                this.saveDraft = true;
                                                this.convertToDraft = false;                                                
                                            } else if (this.hasPermissions([super.appPermissions.approver])) {
                                                //cannot view
                                                this.router.forceNavigate(['AccessDenied']);

                                            } else {
                                                //normal user can edit a draft
                                                this.readOnly = false;
                                                this.approve = false;
                                                this.reject = false;
                                                this.submit = true;
                                                this.saveDraft = true;
                                                this.convertToDraft = false;
                                            }
                                            break;
                                        case ApprovalStatuses.submitted:
                                            if (this.hasPermissions([super.appPermissions.admin])) {
                                                //admin has all actions, non-read only and can change back to draft
                                                this.readOnly = true;
                                                this.approve = false;
                                                this.reject = false;
                                                this.submit = false;
                                                this.saveDraft = false;
                                                this.convertToDraft = true;
                                            } else if (this.hasPermissions([super.appPermissions.approver])) {
                                                //approver can review read only and reject or approve
                                                this.readOnly = true;
                                                this.approve = true;
                                                this.reject = true;
                                                this.submit = false;
                                                this.saveDraft = false;
                                                this.convertToDraft = false;
                                            } else {
                                                //normal user view read only
                                                this.readOnly = true;
                                                this.approve = false;
                                                this.reject = false;
                                                this.submit = false;
                                                this.saveDraft = false;
                                                this.convertToDraft = false;
                                            }
                                            break;
                                        case ApprovalStatuses.approved:
                                            if (super.model.status === ApprovalStatuses.approved) {
                                                //read only for all
                                                this.readOnly = true;
                                                this.approve = false;
                                                this.reject = false;
                                                this.submit = false;
                                                this.saveDraft = false;
                                                this.convertToDraft = false;
                                            }
                                            break;
                                        default:
                                            this.toastService.showToast('The status of this report is unrecognised, please contact a system administrator', 'app');
                                            super.redirectTo(["Reports", {
                                                id: responseId
                                            }])
                                    }
                                }, )
                    } else {
                        super.model = this.reportsService.buildModel(responseData)
                        super.model.responseId = responseId;
                    }

                    //console.log(super.appPermissions, "appPermissions");

                    super.isRequestProcessing = false;
                    return [super.model, responseModel];
                },
                () => {
                    super.isRequestProcessing = false;
                    return Promise.resolve(false);
                });
    }

    updateBools(model) {
        if (model.assessment != null) {
            model.assessmentBool = true;
        }
        if (model.outline != null) {
            model.outlineBool = true;
        }
        if (model.strategy != null) {
            model.strategyBool = true;
        }
        if (model.plan != null) {
            model.planBool = true;
        }
        if (model.operationsControlReview != null) {
            model.operationsControlReviewBool = true;
        }
        if (model.realTimeReview != null) {
            model.realTimeReviewBool = true;
        }

        if (model.childProtectionBackstop != null || model.childProtectionSummary != null) {
            model.childProtectionBool = true;
        }
        if (model.educationBackstop != null || model.educationSummary != null) {
            model.educationBool = true;
        }
        if (model.FSLBackstop != null || model.FSLSummary != null) {
            if (model.FSLBackstop != "" || model.FSLSummary != "") {
                model.FSLBool = true;
            }
        }
        if (model.WASHBackstop != null || model.WASHSummary != null) {
            if (model.WASHBackstop != "" || model.WASHSummary != "") {
                model.WASHBool = true;
            }
        }
        if (model.shelterBackstop != null || model.shelterSummary != null) {
            model.shelterBool = true;
        }
        if (model.healthBackstop != null || model.healthSummary != null) {
            model.healthBool = true;
        }
        if (model.nutritionSummary != null) {
            model.nutritionBool = true;
        }
        return model;

    }

    storeAsDraft(form) {

        super.isRequestProcessing = true;

        var model = this.reportsService.buildModel(super.model);
        model.status = ApprovalStatuses.draft;
        if (model.etag != null) {
            let storeResponsePromise = this.reportsService.update(model);
            storeResponsePromise.then(
                () => {
                    this.toastService.showToast('Report draft updated', 'app');

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });

        } else {
            let storeResponsePromise = this.reportsService.store(model);
            storeResponsePromise.then(
                () => {
                    this.toastService.showToast('Report draft created', 'app');

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        }


    }

    submitReport(form) {

        super.isRequestProcessing = true;

        var model = this.reportsService.buildModel(super.model);
        model.status = ApprovalStatuses.submitted;
        if (model.etag != null) {
            let storeResponsePromise = this.reportsService.update(model);
            storeResponsePromise.then(
                () => {
                    this.toastService.showToast('Report submitted for approval', 'app');

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        } else {
            let storeResponsePromise = this.reportsService.store(model);
            storeResponsePromise.then(
                () => {
                    this.toastService.showToast('Report submitted for approval', 'app');

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        }

    }

    approveReport(form) {
        super.isRequestProcessing = true;
        var model = this.reportsService.buildModel(super.model);
        model.status = ApprovalStatuses.approved;

        let storeResponsePromise = this.reportsService.update(model);
        storeResponsePromise.then(
            () => {
                this.toastService.showToast('Report submitted for approval', 'app');

                super.redirectToHome();
            },
            (errorData) => {
                super.serverRequestErrors = errorData;
            });
    }
}

AddReportController.$inject = ["$window", "$injector", "responseService", "reportsService", "toastService"];