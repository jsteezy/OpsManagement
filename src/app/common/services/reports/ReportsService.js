import DateUtils from "../../helpers/DateUtils";
import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ReportsModel from "../../models/ReportsModel";

export default class ReportsService {
    constructor(user, reportsCodeDataAccessService, commonDataService) {
        this.user = user;
        this.reportsCodeDataAccessService = reportsCodeDataAccessService;
        this.commonDataService = commonDataService;
    }

    buildModel(data, userId) {
        let model = new ReportsModel();

        if (data) {
            ObjectMapper.toObject(data, model);
            //model.startDate = DateUtils.getFromString(model.startDate)
        }

        model.userId = this.getCurrentUserId(userId);
        model.userEmail = this.getCurrentUserEmail(model);

        return model;
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadRegions()]);
    }


    store(pageMode, model) {
        return this.reportsCodeDataAccessService[pageMode.serviceAction](model);
    }

    getAllReports() {
        return this.reportsCodeDataAccessService.getAllReports();
    }

    getReport(reportId) {
        return this.reportsCodeDataAccessService.getReport(reportId);
    }

    getCurrentUserId(userId) {
        return userId ? userId : this.user.id;
    }

    getCurrentUserEmail(model) {
        return !StringHelpers.isNullOrEmpty(model.userEmail) ? model.userEmail : this.user.email;
    }
}

ReportsService.$inject = ["user", "reportsCodeDataAccessService", "commonDataService"];