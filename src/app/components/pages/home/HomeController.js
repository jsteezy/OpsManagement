import BaseController from "../../common/BaseController";

export default class HomeController extends BaseController {
    constructor($window, $injector, responseService) {
        super($injector);

        super.router = this.$router;
        this.responseService = responseService;
        
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
        return super.initializePageData(this.getAllResponses());
    }

    getAllResponses() {
        super.isRequestProcessing = true;

        console.log(this.responseService);

        return this.responseService.getAllResponses()
            .then(
                (data) => {
                    console.log(data);
                    this.responseCodeOptions.data = data;

                    super.isRequestProcessing = false;

                    return Promise.resolve(true);
                },
                () => {
                    super.isRequestProcessing = false;
                    this.responseCodeOptions.data = [];

                    return Promise.resolve(false);
                });
    }
}

HomeController.$inject = ["$window", "$injector", "responseService"];