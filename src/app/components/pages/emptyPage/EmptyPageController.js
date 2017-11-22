import BaseController from "../../common/BaseController";

export default class EmptyPageController extends BaseController {
    constructor($injector) {
        super($injector);

        super.router = this.$router.parent ? this.$router.parent : this.$router;
    }

    $routerOnActivate(next, current) {
        super.permissions = [
            super.appPermissions.omtMembers,
            super.appPermissions.approvers,
            super.appPermissions.editors,
            super.appPermissions.admin
        ];

        let init = () => {
            super.$routerOnActivate(next, current);
        };

        return super.initializePage(init);
    }
}

EmptyPageController.$inject = ["$injector"]