import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ReportsModel from "../../models/ReportsModel";
import DateUtils from "../../helpers/DateUtils";


export default class ReportsService {
    constructor(user, reportsDataAccessService, commonDataService, responseService) {
        this.user = user;
        this.reportsDataAccessService = reportsDataAccessService;
        this.commonDataService = commonDataService;
        this.responseService = responseService;
    }

    buildModel(data) {
        let model = new ReportsModel();

        if (data) {
            ObjectMapper.toObject(data, model);
            model.sitrepDate = DateUtils.getFromString(model.sitrepDate);
            model.nextSitrepDate = DateUtils.getFromString(model.nextSitrepDate);
            model.seedFundsTargetDate = DateUtils.getFromString(model.seedFundsTargetDate);          
        }
        return model;
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadRegions()]);
    }


    store(model) {
        return this.reportsDataAccessService.save(model);
    }

    getAllReports(responseId) {
        return this.reportsDataAccessService.getAllReports(responseId);
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