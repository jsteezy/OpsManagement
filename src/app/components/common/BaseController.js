import PageModes from "../../common/enums/pageModes.json";
import RouteHelpers from "../../common/helpers/RouteHelpers";
import EventsTypes from "../../common/enums/eventsTypes.json";
import ErrorHelpers from "../../common/helpers/ErrorHelpers";

import BaseComponentController from "./BaseComponentController";

export default class BaseController extends BaseComponentController {
    constructor($injector) {
        super();

        this._router = null;

        this._model = null;
        this._pageMode = null;
        this._isRequestProcessing = false;
        this._permissions = null;
        this._serverErrors = [];

        this.$injector = $injector;
        this._navService = this.getNavService();
    }

    get router() {
        return this._router;
    }

    set router(value) {
        this._router = this._navService.getRouterWrapper(value);
    }

    get isRequestProcessing() {
        return this._isRequestProcessing;
    }

    set isRequestProcessing(value) {
        super.emit(EventsTypes.deleteGridEvent, value);
        super.emit(EventsTypes.filterGridEvent, value)

        this._isRequestProcessing = value;
    }

    get serverErrors() {
        return this._serverErrors;
    }

    set serverErrors(value) {
        this._serverErrors.push(value);
    }

    hasServerErrors() {
        return this.serverErrors.length > 0;
    }

    set model(value) {
        this._model = value;
    }

    get model() {
        return this._model;
    }

    set pageMode(value) {
        this._pageMode = value;
    }

    get pageMode() {
        return this._pageMode;
    }

    set permissions(values) {
        this._permissions = new Set(values);
    }

    get permissions() {
        return this._permissions ? [...this._permissions] : [];
    }

    set serverRequestErrors(value) {
        this.isRequestProcessing = false;

        this.serverErrors = value;

        if (!this.$injector) return;

        let serverErrormessage = ErrorHelpers.getErrorMessage(value);

        let toastService = this.$injector.get("toastService");
        toastService.showServerErrors(serverErrormessage);
    }

    get isPageModeApproval() {
        return this.pageMode == PageModes.approval;
    }

    getNavService() {
        if (this.$injector) {
            return this.$injector.get("navigationService");
        }

        return {};
    }

    $routerOnActivate(next, previous) {
        if (RouteHelpers.isAdd(next)) {
            this.pageMode = PageModes.add;
        }

        if (RouteHelpers.isEdit(next)) {
            this.pageMode = PageModes.edit;
        }

        if (RouteHelpers.isApproval(next)) {
            this.pageMode = PageModes.approval;
        }

        if (RouteHelpers.isDetails(next)) {
            this.pageMode = PageModes.details;
        }

        if (!this.$injector) return;

        const userService = this.$injector.get("userService");

        if (!userService.hasPermissions(this.permissions)) {
            this.router.forceNavigate(['AccessDenied']);

            return false;
        }

        return true;
    }

    isAdmin() {
        return this.hasPermissions([super.appPermissions.admin]);
    }

    isApprover() {
        return this.hasPermissions([super.appPermissions.approver]);
    }

    // isBudgetApprover() {
    //     return this.hasPermissions([super.appPermissions.approvers]);
    // }

    // isSuperBudgetApprover() {
    //     return this.hasPermissions([super.appPermissions.superBudgetApprovers]);
    // }

    isUser() {
        return this.hasPermissions([super.appPermissions.everyone]);
    }

    get currentUser() {
        const userService = this.$injector.get("userService");

        return userService.getCurrentUser();
    }

    hasPermissions(permissions) {
        if (!this.$injector) return;

        const userService = this.$injector.get("userService");

        return userService.hasPermissions(permissions);
    }

    $routerCanDeactivate() {
        this.startSpinner();

        return true;
    }

    initializePage(action) {
        if (typeof action != 'function') {
            throw "Initialize page needs a function as argument"
        }

        let initPageActionPromise = Promise.resolve(action())
            .then(
                () => {
                    if (this.hasServerErrors()) {
                        this.redirectToHome();
                    } else {
                        this.stopSpinner();
                    }
                },
                () => {
                    this.stopSpinner();
                });

        return initPageActionPromise;
    }

    initializePageData(...promises) {
        return Promise.all(promises);
    }

    startSpinner() {
        super.emit(EventsTypes.loading, true);
    }

    stopSpinner() {
        super.emit(EventsTypes.loading, false);
    }

    IsSubmittedFormValid(form) {
        form.submitted = true;

        if (form.$valid) {
            return Promise.resolve();
        }

        if (!this.$injector) return;

        const toastService = this.$injector.get("toastService");
        toastService.showToast("FILL_FORM_WARNING");

        return Promise.reject();
    }

    redirectToHome() {
        this.redirectTo(["Home"])
    }

    redirectTo(route) {
        let $timeout = this.$injector.get("$timeout");

        $timeout(() => {
            this.isRequestProcessing = false;
            this.stopSpinner();

            this.router.forceNavigate(route)
        });
    }

    isFieldErrorVisible(form, fieldName) {
        return form && (form.submitted || form[fieldName].$touched);
    }
}