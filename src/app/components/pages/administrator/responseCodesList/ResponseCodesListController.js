import envConfig from "../../../../config/envConfig.json";
import BaseController from "../../../common/BaseController";

export default class ResponseCodesListController extends BaseController {
    constructor($window, $injector) {
        super($injector);

        super.router = this.$router;

        this.$window = $window;
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.admin];

        let init = () => {
            if (super.$routerOnActivate(next, current)) {
                this.activate();
            }
        };

        return super.initializePage(init);
    }
    
    activate() {
        this.$window.open(envConfig.site_url + "/Lists/ResponseCodes/", "_blank");
    }
}

ResponseCodesListController.$inject = ["$window", "$injector"]
