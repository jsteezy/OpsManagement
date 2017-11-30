import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ReportsModel from "../../models/ReportsModel";

export default class ReportsService {
    constructor(user, reportsDataAccessService, commonDataService, responseService) {
        this.user = user;
        this.reportsDataAccessService = reportsDataAccessService;
        this.commonDataService = commonDataService;
        this.responseService = responseService;
    }

    buildModel(data, responseId) {
        let model = new ReportsModel();
        
        this.responseService.getResponse(responseId)
        .then(
            (data) => {
                ObjectMapper.toObject(data, model);
                return model;
            },
            () => {
                return Promise.resolve(false);
            });     
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

ReportsService.$inject = ["user", "reportsDataAccessService", "commonDataService", "responseService"];