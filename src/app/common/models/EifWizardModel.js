import BaseModel from "./BaseModel";
import DateUtils from "../helpers/DateUtils";

export default class EifWizardModel extends BaseModel {
    constructor() {
        super();

        this.uploadedAttachments = [];
        this.uploadAttachments = [];

        this.title = "";
        this.requester = [];
        this.requesterId = 0;
        this.staffResponsibleForGuest = [];
        this.staffResponsibleForGuestId = 0;
        this.additionalStaffMember = [];
        this.additionalStaffMemberId = 0;
        this.firstName = "";
        this.lastName = "";
        this.contactNumber = "";
        this.dateOfBirth = DateUtils.today;
        this.passportNumber = "";
        this.passportCountry = "";
        this.countryOfOrigin = "";
        this.visaNumbers = "";
        this.destinations = [];
        this.emergencyContactName = "";
        this.emergencyContactRelationship = "";
        this.emergencyContactEmail = "";
        this.emergencyContactHomePhone = "";
        this.emergencyContactMobilePhone = "";
        this.travelRouteDetails = "";
        this.medicalConditions = "";
        this.bloodType = "";
        this.insurancePolicyNumber = "";
        this.insuranceCompany = "";
        this.insuranceCompanyPhone = "";
        this.insuranceContact = "";
        this.additionalComments = "";
        this.informationRead = {};
        this.tarId = "";

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
        return ["requester",
            "staffResponsibleForGuest",
            "additionalStaffMember",
            "uploadAttachments",
            "uploadedAttachments",
            "formSubmitConfirmation"
        ];
    }

    get peoplePickerProperties() {
        return ["staffResponsibleForGuest",
            "additionalStaffMember"];
    }
}