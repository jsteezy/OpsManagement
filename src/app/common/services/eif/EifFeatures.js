import Answers from "../../enums/answers.json";
import questionOptions from "../../enums/questionsOptions";
import listOptions from "../../enums/listOptions";
import peoplePickerOptions from "../../enums/peoplePickerOptions";

export default class EifFeatures {
    constructor() {
        this.overrideQuestionsOptions();
        this.overrideListOptions();
        this.overridePeoplePickerOptions();
    }

    isReadyToSubmit(model){
        return this.hasReadTravelProcedures(model) &&
               this.hasReadTravelPolicy(model) &&
               this.hasReadDepartureShare(model) &&
               this.hasReadSafeGuardingPolicy(model);
    }

    hasReadTravelProcedures(model) {
        return model.informationRead.travelProcedures && model.informationRead.travelProcedures == Answers.yes;
    }

    hasReadTravelPolicy(model) {
        return model.informationRead.travelPolicy && model.informationRead.travelPolicy == Answers.yes;
    }

    hasReadDepartureShare(model) {
        return model.informationRead.departureShare && model.informationRead.departureShare == Answers.yes;
    }

    hasReadSafeGuardingPolicy(model) {
        return model.informationRead.safeGuardingPolicy && model.informationRead.safeGuardingPolicy == Answers.yes;
    }

    overrideQuestionsOptions() {
        this._questionsOptions = questionOptions.options;

        this._questionsOptions.travelProceduresOptions.flex = 30;
        this._questionsOptions.departureProceduresOptions.flex = 30;
        this._questionsOptions.sciFundsOptions.flex = 30;
        this._questionsOptions.travelPolicyOptions.flex = 30;
        this._questionsOptions.departureShareOptions.flex = 30;
        this._questionsOptions.safeGuardingPolicyOptions.flex = 30;
    }

    overrideListOptions() {
        this._listOptions = listOptions.options;
    }

    overridePeoplePickerOptions() {
        this._pickerOptions = peoplePickerOptions.options;
    }

    get pickerOptions() {
        return this._pickerOptions;
    }

    get listOptions() {
        return this._listOptions;
    }

    get questionsOptions() {
        return this._questionsOptions;
    }

    static get instance(){
        return new EifFeatures();
    }
}