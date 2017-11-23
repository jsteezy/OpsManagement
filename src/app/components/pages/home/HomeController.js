import BaseController from "../../common/BaseController";

export default class HomeController extends BaseController {
    constructor($window, $injector) {
        super($injector);

        super.router = this.$router;

        this.$window = $window;
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            if (super.$routerOnActivate(next, current)) {
                this.activate();
            }
        };

        return super.initializePage(init);
    }

    activate() {
        //return super.initializePageData(this.getResponses());
    }

    getResponses() {
        super.isRequestProcessing = true;

        return this.responseCodeDataAccessService.getAllResponses()
            .then(
                (data) => {
                    this.tarHistoryOptions.data = data;

                    super.isRequestProcessing = false;

                    return Promise.resolve(true);
                },
                () => {
                    super.isRequestProcessing = false;
                    this.tarHistoryOptions.data = [];

                    return Promise.resolve(false);
                });
    }
}

HomeController.$inject = ["$window", "$injector"];