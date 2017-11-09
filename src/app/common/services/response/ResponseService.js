import DateUtils from "../../helpers/DateUtils";
import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ResponseModel from "../../models/ResponseModel";

export default class ResponseService {
    constructor(user, responseDataAccessService, commonDataService) {
        this.user = user;
        this.responseDataAccessService = responseDataAccessService;
        this.commonDataService = commonDataService;
    }

    buildModel(data, userId) {
        let model = new ResponseModel();

        if (data) {
            ObjectMapper.toObject(data, model);
            model.startDate = DateUtils.getFromString(model.startDate)

            //model.initPeoplePickers();
        }

        model.userId = this.getCurrentUserId(userId);

        //model.userEmail = this.getCurrentUserEmail(model);

        return model;
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries()]);
    }

    store(model) {
        return this.responseDataAccessService.save(model);
    }

    getCurrentUserId(userId) {
        return userId ? userId : this.user.id;
    }

    getCurrentUserEmail(model) {
        return !StringHelpers.isNullOrEmpty(model.userEmail) ? model.userEmail : this.user.email;
    }
}

ResponseService.$inject = ["user", "responseDataAccessService", "commonDataService"];