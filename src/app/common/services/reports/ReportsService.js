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
            model.sitrepDate = DateUtils.format(model.sitrepDate);
            model.nextSitrepDate = DateUtils.format(model.nextSitrepDate);
            model.seedFundsTargetDate = DateUtils.format(model.seedFundsTargetDate);
            model.eHUDeployedDate = DateUtils.format(model.eHUDeployedDate);
        }
        return model;
    }


    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadRegions()]);
    }


    store(model) {
        model.userEmail = this.user.email;
        model.userId = this.user.id;
        if(model.lastModifiedUserName != "Auto generated draft")
        {
        model.lastModifiedUserName = this.user.title;  
        }      
        return this.reportsDataAccessService.save(model);
    }

    storeNonSci(model) {
        return this.reportsDataAccessService.saveNonSci(model);
    }

    update(model){
        model.userEmail = this.user.email;
        model.userId = this.user.id;
        model.lastModifiedUserName = this.user.title;                
        return this.reportsDataAccessService.update(model);
    }

    updateNonSci(model){
        return this.reportsDataAccessService.updateNonSci(model);
    }

    getAllReports(responseId) {
        return this.reportsDataAccessService.getAllReports(responseId);
    }

    getReport(reportId) {
        return this.reportsDataAccessService.getReport(reportId);
    }

    getNonSci(reportId) {
        return this.reportsDataAccessService.getNonSci(reportId);
    }

    getCurrentUserId(userId) {
        return userId ? userId : this.user.id;
    }

    getCurrentUserEmail(model) {
        return !StringHelpers.isNullOrEmpty(model.userEmail) ? model.userEmail : this.user.email;
    }
}

ReportsService.$inject = ["user", "reportsDataAccessService", "commonDataService", "responseService"];