import Answers from "../../enums/answers.json";
import DateUtils from "../../helpers/DateUtils";
import StringHelpers from "../../helpers/StringHelpers";
import ObjectMapper from "../../helpers/ObjectMapper";
import ProfileModel from "../../models/ProfileModel";

export default class ProfileService {
    constructor(user, profileDataAccessService, commonDataService) {
        this.user = user;
        this.profileDataAccessService = profileDataAccessService;
        this.commonDataService = commonDataService;
    }

    buildModel(data, userId) {
        let model = new ProfileModel();

        if (data) {
            ObjectMapper.toObject(data, model);
            model.gSSTrainingDate = DateUtils.getFromString(model.gSSTrainingDate)

            model.initPeoplePickers();
        }

        model.userId = this.getCurrentUserId(userId);

        model.userEmail = this.getCurrentUserEmail(model);

        return model;
    }

    loadProfile(userId) {
        return this.profileDataAccessService.get(this.getCurrentUserId(userId));
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries(), this.commonDataService.loadRegions()]);
    }

    store(pageMode, model) {
        return this.profileDataAccessService[pageMode.serviceAction](model);
    }

    getCurrentUserId(userId) {
        return userId ? userId : this.user.id;
    }

    getCurrentUserEmail(model) {
        return !StringHelpers.isNullOrEmpty(model.userEmail) ? model.userEmail : this.user.email;
    }

    hasMedicalCard(model) {
        if (!model) return false;

        return model.medicalEmergencyCard == Answers.yes;
    }

    hasSecurityTraining(model) {
        if (!model) return false;

        return model.gSSTraining == Answers.yes;
    }

    processSecurityTrainingDate(model) {
        if (!model) return;

        if (!this.isSecurityTrainingValid(model)) {
            model.gSSTraining = Answers.empty;
        } else {
            model.gSSTraining = Answers.yes;
        }
    }

    isSecurityTrainingValid(model) {
        if (!model) return false;

        const acceptedNumberOfMonths = 48;

        return DateUtils.getNumberOfMonths(model.gSSTrainingDate) <= acceptedNumberOfMonths;
    }
}

ProfileService.$inject = ["user", "profileDataAccessService", "commonDataService"];