import BaseController from "../../common/BaseController";

export default class AccessDeniedController extends BaseController {
	constructor($injector) {
        super($injector);
	}

    $routerOnActivate(next, current) {
        let init = () => {
            return this.activate();
        };

        return super.initializePage(init);
    }

    activate() {
        return Promise.resolve(true);
    }
}

AccessDeniedController.$inject = ["$injector"];