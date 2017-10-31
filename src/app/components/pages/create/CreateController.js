import BaseController from "../../common/BaseController";

export default class CreateController extends BaseController {
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
        this.$window.open("https://onenet.savethechildren.net/tools/travel/Pages/default.aspx");
    }
}

CreateController.$inject = ["$window", "$injector"];