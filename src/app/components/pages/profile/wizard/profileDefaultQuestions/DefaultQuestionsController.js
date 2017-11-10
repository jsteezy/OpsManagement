import questionOptions from "../../../../../common/enums/questionsOptions";

export default class DefaultQuestionsController {
    constructor(profileService) {
        this.profileService = profileService;

        this.processSecurityTrainingDate();

        this.overrideQuestionsOptions();
    }

    hasMedicalCard() {
        return this.profileService.hasMedicalCard(this.model);
    }

    hasSecurityTraining() {
        return this.profileService.hasSecurityTraining(this.model);
    }

    processSecurityTrainingDate() {
        this.profileService.processSecurityTrainingDate(this.model);
    }

    isSecurityTrainingValid() {
        return this.profileService.isSecurityTrainingValid(this.model);
    }


    overrideQuestionsOptions() {
        this.questionsOptions = questionOptions.options;

        this.questionsOptions.photoIdOptions.flex = 20;

        this.questionsOptions.securityTrainingOptions.flex = 20;

        this.questionsOptions.medicalCardOptions.flex = 20;

        if (this.areRequired) {
            this.questionsOptions.photoIdOptions.required = true;
            this.questionsOptions.securityTrainingOptions.required = true;
            this.questionsOptions.medicalCardOptions.required = true;
        }
    }
}

DefaultQuestionsController.$inject = ["profileService"];