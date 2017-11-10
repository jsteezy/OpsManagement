import ProfileCommonModel from "./ProfileCommonModel";

export default class TarWizardModel extends ProfileCommonModel {
    constructor() {
        super();
        
        this.uploadedAttachments = [];
        this.uploadAttachments = [];

        this.title = "";
        this.requester = [];
        this.requesterId = 0;
        this.traveller = [];
        this.travellerId = 0;
        this.selectedEmergencyContacts = [];
        this.additionalStaffMember = [];
        this.additionalStaffMemberId = 0;
        this.visaRequired = "";
        this.visaNumber = "";
        this.readPDI = "";
        this.usaidFunds = "";
        this.appropriateVaccination = "";
        this.appropriateEmergencyContacts = "";
        this.londonOfficeLocation = "";
        this.travelAdvances = [];
        this.purposeOfTravel = "";
        this.approvedByDirector = "";
        this.destinations = [];
        this.requiresGssApproval = false;
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

        super.excludeProperties(this.getExcludedProperties());
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
    
    getExcludedProperties() {
        return ["officeLocation",
            "emergencyContacts",
            "expensesCodes",
            "uploadAttachments",
            "uploadedAttachments",
            "traveller",
            "requester",
            "lineManager",
            "additionalStaffMember",
            "travelCoordinator",
            "budgetApprover",
            "otherEstimatedCostsTotal",
            "totalBudgetCodesPercentage",
            "formSubmitConfirmation"];
    }
    
    get peoplePickerProperties() {
        return ["requester", 
            "traveller",
            "lineManager",
            "travelCoordinator",
            "budgetApprover",
            "additionalStaffMember"];
    }
}
