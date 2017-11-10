import Answers from "../../enums/answers.json";
import questionOptions from "../../enums/questionsOptions";
import listOptions from "../../enums/listOptions";
import peoplePickerOptions from "../../enums/peoplePickerOptions";
import BaseTarService from "./BaseTarService";

export default class TarFeatures extends BaseTarService {
    constructor() {
        super();

        this.overrideQuestionsOptions();
        this.overrideListOptions();
        this.overridePeoplePickerOptions();
    }

    initPageFeatures(model) {
        this.setBudgetCodesTotalPercentage(model);
        this.setEstimatedTotalCosts(model);
    }

    setEstimatedTotalCosts(model) {
        model.otherEstimatedCostsTotal = super.calculateTotalCosts(model);
    }

    setBudgetCodesTotalPercentage(model) {
        model.totalBudgetCodesPercentage = super.calculateTotalPercentage(model);
    }

    isReadyToSubmit(model) {
        return model.formSubmitConfirmation &&
            this.hasGssTraining(model) &&
            this.hasReadTravelProcedures(model) &&
            this.hasReadDepartureProcedures(model);
    }

    hasGssTraining(model) {
        return model.gSSTraining == Answers.yes
    }

    hasReadTravelProcedures(model) {
        return model.informationRead.travelProcedures && model.informationRead.travelProcedures == Answers.yes;
    }

    hasReadDepartureProcedures(model) {
        return model.informationRead.departureProcedures && model.informationRead.departureProcedures == Answers.yes;
    }

    overrideQuestionsOptions() {
        this._questionsOptions = questionOptions.options;

        this._questionsOptions.travelProceduresOptions.flex = 30;
        this._questionsOptions.departureProceduresOptions.flex = 30;
    }

    overrideListOptions() {
        this._listOptions = listOptions.options;
    }

    overridePeoplePickerOptions() {
        this._pickerOptions = peoplePickerOptions.options;

        this._pickerOptions.emergencyPickerOptions.query = {
            methodName: "queryEmergencyContactsForTraveller"
        }
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

    static get instance() {
        return new TarFeatures();
    }
}