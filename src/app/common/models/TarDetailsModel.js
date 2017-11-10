import TarCommonModel from "./ProfileCommonModel";
import TravelTypes from "../enums/travelTypes.json";

export default class TarDetailsModel extends TarCommonModel{
    constructor(){
        super();

        this.uploadedAttachments = [];
        this.uploadAttachments = [];

        this.title = "";
        this.requester = [];
        this.requesterId = 0;
        this.traveller = [];
        this.travellerId = 0;
        this.selectedEmergencyContacts = [];
        this.lineManager = [];
        this.lineManagerId = 0;
        this.additionalStaffMember = [];
        this.additionalStaffMemberId = 0;
        this.typeOfTravel = TravelTypes.domestic;
        this.visaRequired = "";
        this.readPDI = "";
        this.appropriateVaccination = "";
        this.appropriateEmergencyContacts = "";
        this.londonOfficeLocation = "";
        this.requiresTravelAdvance = "";
        this.travelAdvances = [];
        this.purposeOfTravel = "";
        this.approvedByDirector = "";
        this.destinations = [];
        this.budgetSession = {};
        this.otherEstimatedCosts = [];
        this.otherEstimatedCostsTotal = 0;
        this.totalBudgetCodesPercentage = 0;
        this.budgetCodes = [];
        this.additionalInformation = "";
        this.travelCoordinator = [];
        this.travelCoordinatorId = 0;
        this.budgetApprover = [];
        this.budgetApproverId = 0;
        this.informationRead = {};
        this.requiresGssApproval = "";
        this.budgetApprovalStatus = "";
        this.budgetApprovalTimestamp = "";
        this.gSSApprovalStatus = "";
        this.gSSApprovalTimestamp = "";
    }

    initPeoplePickers() {
        this.peoplePickerProperties.forEach((prop) => {
            if (this[prop] === undefined ||
                this[prop].length === 0 ||
                this[prop][0].Title == null) {

                this[prop] = [];
            }
        });
    }

    get peoplePickerProperties() {
        return ["requester",
            "traveller",
            "lineManager",
            "travelCoordinator",
            "budgetApprover",
            "additionalStaffMember"];
    }
    
    get budgetApprovalPropertyName() {
        return "budgetApprovalStatus";
    }
    
    get budgetApprovalTimestampPropertyName() {
        return "budgetApprovalTimestamp";
    }
    
    get gSSApprovalPropertyName() {
        return "gSSApprovalStatus";
    }
    
    get gSSApprovalTimestampPropertyName() {
        return "gSSApprovalTimestamp";
    }
}