import BaseComponentController from "../../../../../common/BaseComponentController";
import peoplePickerOptions from "../../../../../../common/enums/peoplePickerOptions";
import listOptions from "../../../../../../common/enums/listOptions";
import Answers from "../../../../../../common/enums/listOptions";
import AttachmentsOptions from "../../../../../../common/enums/attachmentsOptions";
import EventsTypes from "../../../../../../common/enums/eventsTypes.json";

export default class TarDetailsCommonController extends BaseComponentController {
    constructor( tarDetailsService ) {
        super();

        this.tarDetailsService = tarDetailsService;

        this.overridePeoplePickerOptions();
        this.overrideListOptions();

        this.attachmentsOptions = AttachmentsOptions.empty;

        this.workflowModel = [];
        this.model = {};

        this.registerEvents();
    }

    initPageFeatures( model ) {
        this.workflowModel = this.tarDetailsService.buildWorkflowModel(model);

        this.setBudgetCodesTotalPercentage(model);
        this.setEstimatedTotalCosts(model);

        this.attachmentsOptions = AttachmentsOptions.tarRequestsOptions(model.id);
    }

    isTravelAdvanceAvailable() {
        return this.model.londonOfficeLocation == Answers.yes;
    }

    setEstimatedTotalCosts( model ) {
        model.otherEstimatedCostsTotal =
            this.tarDetailsService.calculateTotalCosts(model);
    }

    setBudgetCodesTotalPercentage( model ) {
        model.totalBudgetCodesPercentage =
            this.tarDetailsService.calculateTotalPercentage(model);
    }

    registerEvents() {
        let initCommonTarDetails = ( data ) => {
            this.initPageFeatures(data[0]);
        }

        super.setListener(EventsTypes.initCommonTarDetails, initCommonTarDetails);
    }

    overrideListOptions() {
        this.listOptions = listOptions.options;

        this.listOptions.destinationsListOptions.readOnly = true;
        this.listOptions.travelAdvanceListOptions.readOnly = true;
        this.listOptions.estimatedCostsListOptions.readOnly = true;
        this.listOptions.budgetCodesListOptions.readOnly = true;

    }

    overridePeoplePickerOptions() {
        this.pickerOptions = peoplePickerOptions.options;

        this.pickerOptions.travelCoordinatorPickerOptions.readonly = true;
        this.pickerOptions.budgetApproverPickerOptions.readonly = true;
    }
}

TarDetailsCommonController.$inject = ["tarDetailsService"]