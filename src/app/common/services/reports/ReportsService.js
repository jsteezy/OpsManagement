import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ReportsModel from "../../models/ReportsModel";

export default class ReportsService {
    constructor(user, reportsDataAccessService, commonDataService) {
        this.user = user;
        this.reportsDataAccessService = reportsDataAccessService;
        this.commonDataService = commonDataService;
    }

    buildModel(data, responseId) {
        let model = new ReportsModel();
        this.responseService.getResponse(responseId)
        
        if (data) {
            ObjectMapper.toObject(data, model);
        }
        model.responseId = responseId;

        return model;
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadRegions()]);
    }


    store(pageMode, model) {
        return this.reportsDataAccessService[pageMode.serviceAction](model);
    }

    getAllReports() {
        return this.reportsDataAccessService.getAllReports();
    }

    getReport(reportId) {
        return this.reportsDataAccessService.getReport(reportId);
    }

    getCurrentUserId(userId) {
        return userId ? userId : this.user.id;
    }

    getCurrentUserEmail(model) {
        return !StringHelpers.isNullOrEmpty(model.userEmail) ? model.userEmail : this.user.email;
    }
}

ReportsService.$inject = ["user", "reportsDataAccessService", "commonDataService"];