import BaseController from "../../../common/BaseController";
import Regions from "../../../../common/enums/regions.json";
import Countries from "../../../../common/enums/countries.json";
import ResponseModel from "../../../../common/models/ResponseModel";
import ObjectMapper from "../../../../common/helpers/ObjectMapper";


export default class CreateController extends BaseController {
    constructor($window, $injector, responseService) {
        super($injector);

        super.router = this.$router;


        this.responseService = responseService;
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

            let model = new ResponseModel();

            // console.log(model, "model1");
            ObjectMapper.toObject(form, model);

            //alert(model);


            let storeResponsePromise = this.responseService.store(model);

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

    // if (data) {
    //     ObjectMapper.toObject(data, model);
    //     model.gSSTrainingDate = DateUtils.getFromString(model.gSSTrainingDate)

    //     model.initPeoplePickers();
    // }

    // buildModel(data, userId) {
    //     let model = new ProfileModel();

    //     if (data) {
    //         ObjectMapper.toObject(data, model);
    //         model.gSSTrainingDate = DateUtils.getFromString(model.gSSTrainingDate)

    //         model.initPeoplePickers();
    //     }

    //     model.userId = this.getCurrentUserId(userId);

    //     model.userEmail = this.getCurrentUserEmail(model);

    //     return model;
    // }

    cancel() {
        super.redirectToHome();
    }
}

CreateController.$inject = ["$window", "$injector"];