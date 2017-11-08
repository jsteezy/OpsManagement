import BaseController from "../../../common/BaseController";
import Regions from "../../../../common/enums/regions.json";
import Countries from "../../../../common/enums/countries.json";
import ResponseModel from "../../models/ResponseModel";

export default class CreateController extends BaseController {
    constructor($window, $injector) {
        super($injector);

        super.router = this.$router;

        this.$window = $window;
        this.countries = Countries;
        this.regions = Regions;
        this.responseModel = ResponseModel;
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

    activate() {}

    storeResponse(form) {
        super.IsSubmittedFormValid(form).then(() => {

            super.isRequestProcessing = true;

            let storeResponsePromise = this.profileService.store(super.pageMode, super.model);

            storeResponsePromise.then(
                () => {
                    this.toastService.showToast('Response created', 'app');

                    super.redirectToHome();
                },
                (errorData) => {
                    super.serverRequestErrors = errorData;
                });
        });
    }

    cancel() {
        super.redirectToHome();
    }
}

CreateController.$inject = ["$window", "$injector"];