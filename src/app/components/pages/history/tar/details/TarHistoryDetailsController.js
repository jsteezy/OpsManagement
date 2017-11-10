import BaseModalController from "../../../../common/BaseModalController";
import peoplePickerOptions from "../../../../../common/enums/peoplePickerOptions";
import listOptions from "../../../../../common/enums/listOptions";
import AttachmentsOptions from "../../../../../common/enums/attachmentsOptions";

export default class TarHistoryDetailsController extends BaseModalController {
    constructor( tarDetailsService, $injector ) {
        super($injector);

        this.tarDetailsService = tarDetailsService;

        this.activate();

        this.overrideListOptions();
        this.overridePeoplePickerOptions();
    }

    activate() {
        super.model = this.tarModel;
        this.workflowModel = this.tarDetailsService.buildWorkflowModel(super.model);
        
        this.attachmentsOptions = AttachmentsOptions.tarRequestsOptions(super.model.id);
    }

    overridePeoplePickerOptions() {
        this.pickerOptions = peoplePickerOptions.options;

        this.pickerOptions.emergencyPickerOptions.query = {
            methodName: "queryEmergencyContactsForTraveller"
        }
        this.pickerOptions.emergencyPickerOptions.readonly = true;
        this.pickerOptions.travellerPickerOptions.readonly = true;
        this.pickerOptions.lineManagerPickerOptions.readonly = true;
        this.pickerOptions.additionalStaffMemberOptions.readonly = true;
        this.pickerOptions.travelCoordinatorPickerOptions.readonly = true;
        this.pickerOptions.budgetApproverPickerOptions.readonly = true;
    }

    overrideListOptions() {
        this.listOptions = listOptions.options;

        this.listOptions.destinationsListOptions.readOnly = true;
        this.listOptions.travelAdvanceListOptions.readOnly = true;
        this.listOptions.estimatedCostsListOptions.readOnly = true;
        this.listOptions.budgetCodesListOptions.readOnly = true;
    }
}

TarHistoryDetailsController.$inject = ["tarDetailsService", "$injector"];