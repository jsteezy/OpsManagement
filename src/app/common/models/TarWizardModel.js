import ProfileCommonModel from "./ProfileCommonModel";
import DateUtils from "../helpers/DateUtils";

export default class TarWizardModel extends ProfileCommonModel {
    constructor() {
        super();

        this.regionalResponse = false;
        this.parentRegionalResponse = "";
        this.sitrepDate = DateUtils.today;
        this.nextSitrepDate = DateUtils.today;
        this.generalContext = "";
        this.recentContextDevelopment = "";
        this.responseUpdate = "";
        this.opsBackstop = "";
        this.nonSciResponses = false;

        this.affectedPopulation = 0;
        this.strategyTarget = "";
        this.totalReachSinceStart = "";
        this.totalReachSinceLastSitrep = "";
        this.childrenReachedSinceStart = 0;
        this.childrenReachedSinceLastSitrep = 0;

        this.responseStratergyTarget = "";
        this.seedFundsTarget = "";
        this.seedFundsTargetDate = DateUtils.today;

        this.assessment = "";
        this.outline = "";
        this.strategy = "";
        this.plan = "";
        this.operationsControlReview = "";
        this.realTimeReview = "";
        this.representationOnHCT = false;
        this.educationCluster = false;
        this.staffingEducationCluster = false;

        this.childProtectionBackstop = "";
        this.childProtectionSummary = "";
        this.educationBackstop = "";
        this.educationSummary = "";
        this.FSLBackstop = "";
        this.FSLSummary = "";
        this.WASHBackstop = "";
        this.WASHSummary = "";
        this.shelterBackstop = "";
        this.shelterSummary = "";
        this.EHUUpdates = "";
        this.EHUPresent = false;

        this.nationalStaffNumber = 0;
        this.internationalStaffNumber = 0;

        this.securityLevel = "";
        this.incidentSummary = "";
        this.securityEvents = "";
        this.securityContext = "";
        this.securityChallenges = "";
        this.securityManagement = "";

        this.staffChildSafegaurding = 0;
        this.safegaurdingFocalPoint = "";
        this.safegaurdingRisks = "";

        this.commsPack = "";
        this.mediaCoverage = "";
        this.spokespeople = "";

        this.prepositionedStock = false;
        this.forThisResponse = false;
        this.plannedProcurement = 0;
        this.procurementSpend = 0;

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
            "formSubmitConfirmation"
        ];
    }

    get peoplePickerProperties() {
        return ["requester",
            "traveller",
            "lineManager",
            "travelCoordinator",
            "budgetApprover",
            "additionalStaffMember"
        ];
    }
}