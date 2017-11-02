import BaseController from "../../common/BaseController";
import ResponseTypes from "../../../common/enums/responseTypes.json";
import Countries from "../../../common/enums/countries.json";

export default class HomeController extends BaseController {
    constructor($window, $injector) {
        super($injector);

        super.router = this.$router;

        this.$window = $window;
        this.countries = Countries;
        this.responseTypes = ResponseTypes;

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

    activate() {}
}

HomeController.$inject = ["$window", "$injector"];