import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ResponseModel from "../../models/ResponseModel";

export default class ResponseService {
    constructor(user, responseCodeDataAccessService, commonDataService) {
        this.user = user;
        this.responseCodeDataAccessService = responseCodeDataAccessService;
        this.commonDataService = commonDataService;
    }

    buildModel(data) {
        let model = new ResponseModel();

        if (data) {
            ObjectMapper.toObject(data, model);
        }

        return model;
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadRegions()]);
    }

    store(pageMode, model) {
        //model.userEmail = this.user.email;
        //model.userId = this.user.id;
        return this.responseCodeDataAccessService.save(model);
    }

    getAllResponses() {
        return this.responseCodeDataAccessService.getAllResponses();
    }

    getResponse(id) {
        return this.responseCodeDataAccessService.getResponse(id);
    }
    getCurrentUserId(userId) {
        return userId ? userId : this.user.id;
    }

    getCurrentUserEmail(model) {
        return !StringHelpers.isNullOrEmpty(model.userEmail) ? model.userEmail : this.user.email;
    }
}

ResponseService.$inject = ["user", "responseCodeDataAccessService", "commonDataService"];