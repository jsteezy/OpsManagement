import DateUtils from "../../helpers/DateUtils";
import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ResponseModel from "../../models/ResponseModel";

export default class ResponseService {
    constructor(user, responseCodeDataAccessService, commonDataService) {
        this.user = user;
        this.responseCodeDataAccessService = responseCodeDataAccessService;
        this.commonDataService = commonDataService;
    }

    buildModel(data, userId) {
        let model = new ResponseModel();

        if (data) {
            ObjectMapper.toObject(data, model);
            model.startDate = DateUtils.getFromString(model.startDate)
        }

        model.userId = this.getCurrentUserId(userId);
        model.userEmail = this.getCurrentUserEmail(model);

        return model;
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadRegions()]);
    }


    store(pageMode, model) {
        return this.responseCodeDataAccessService[pageMode.serviceAction](model);
    }

    getAllResponses() {
        return this.responseCodeDataAccessService.getAllResponses();
    }

    getCurrentUserId(userId) {
        return userId ? userId : this.user.id;
    }

    getCurrentUserEmail(model) {
        return !StringHelpers.isNullOrEmpty(model.userEmail) ? model.userEmail : this.user.email;
    }
}

ResponseService.$inject = ["user", "responseCodeDataAccessService", "commonDataService"];