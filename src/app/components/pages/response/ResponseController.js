import BaseController from "../../common/BaseController";
import ResponseStatus from "../../../common/enums/responseStatus.json";

export default class ResponseController extends BaseController {
    constructor($injector,
        responseService,
        toastService) {
        super($injector);

        super.router = this.$router;

        this.title = "Create";
        this.responseService = responseService;
        this.responseStatus = ResponseStatus
        this.toastService = toastService;
    }

    $routerOnActivate(next, current) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate(next.params.id);
        };

        return super.initializePage(init);
    }

    activate(responseCodeId) {
        if(responseCodeId != null)
        {
            this.getResponse(responseCodeId);
        }
        else
        {
            super.model = this.responseService.buildModel(undefined);
        }
        let pageData = this.responseService.loadPageData().then((data) => {
            this.countries = data[0];
            this.regions = data[1];
        });

        return super.initializePageData(super.model, pageData);
    }

    getResponse(responseCodeId) {
        super.isRequestProcessing = true;

        this.responseService.getResponse(responseCodeId)
        .then(
            (data) => {
                super.isRequestProcessing = false;
                super.model = this.responseService.buildModel(data);

                return this.responseService.buildModel(data);
            },
                () => {
                    super.isRequestProcessing = false;
                    return Promise.resolve(false);
                });
    }


    storeResponse(form) {
        super.IsSubmittedFormValid(form).then(() => {

            super.isRequestProcessing = true;
            if(super.model.id != ""){
                //update existing
                let storeResponsePromise = this.responseService.update(super.model);

                storeResponsePromise.then(
                    () => {
                        this.toastService.showToast('Response code updated', 'app');    
                        super.redirectToHome();
                    },
                    (errorData) => {
                        super.serverRequestErrors = errorData;
                    });
            } else {
                //create new
                let storeResponsePromise = this.responseService.store(super.model);

                storeResponsePromise.then(
                    () => {
                        this.toastService.showToast('Response code created', 'app');    
                        super.redirectToHome();
                    },
                    (errorData) => {
                        super.serverRequestErrors = errorData;
                    });
            }
        });
    }
}

ResponseController.$inject = [
    "$injector",
    "responseService",
    "toastService"
];