import ProfileCommonModel from "./ProfileCommonModel";
import DateUtils from "../helpers/DateUtils";

export default class TarWizardModel extends ProfileCommonModel {
    constructor() {
        super();

        //General info
        this.regionalResponse = false;
        this.parentRegionalResponse = "";
        this.sitrepDate = DateUtils.today;
        this.nextSitrepDate = DateUtils.today;
        this.generalContext = "";
        this.recentContextDevelopment = "";
        this.responseUpdate = "";
        this.opsBackstop = "";

        //Non SCI responses
        this.nonSciResponses = false;

        //Reach figures
        this.affectedPopulation = "";
        this.strategyTarget = "";
        this.totalReachSinceStart = "";
        this.totalReachSinceLastSitrep = "";
        this.childrenReachedSinceStart = "";
        this.childrenReachedSinceLastSitrep = "";

        //Income
        this.responseStrategyTarget = "";
        this.seedFundsTarget = "";
        this.seedFundsTargetDate = "";

        //Deliverables
        this.assessmentBool = false;
        this.assessment = "";
        this.outlineBool = false;
        this.outline = "";
        this.strategyBool = false;
        this.strategy = "";
        this.planBool = false;
        this.plan = "";
        this.operationsControlReviewBool = false;
        this.operationsControlReview = "";
        this.realTimeReviewBool = false;
        this.realTimeReview = "";
        this.representationOnHCT = false;
        this.educationCluster = false;
        this.staffingEducationCluster = false;

        //Sectors
        this.childProtectionBool = false;
        this.childProtectionBackstop = "";
        this.childProtectionSummary = "";
        this.educationBool = false;
        this.educationBackstop = "";
        this.educationSummary = "";
        this.FSLBool = false;
        this.FSLBackstop = "";
        this.FSLSummary = "";
        this.WASHBool = false;
        this.WASHBackstop = "";
        this.WASHSummary = "";
        this.shelterBool = false;
        this.shelterBackstop = "";
        this.shelterSummary = "";
        this.healthBool = false;
        this.healthBackstop = "";
        this.healthSummary = "";
        this.EHUUpdatesBool = false;
        this.EHUUpdates = "";
        this.EHUPresent = false;

        //HR
        this.nationalStaffNumber = "";
        this.internationalStaffNumber = "";

        //Saftey and security
        this.securityLevel = "";
        this.incidentSummary = "";
        this.securityEvents = "";
        this.securityContext = "";
        this.securityChallenges = "";
        this.securityManagement = "";

        //Child safegaurding
        this.staffChildSafegaurding = "";
        this.safegaurdingFocalPoint = "";
        this.safegaurdingRisks = "";

        //Advanced Media and Comms
        this.commsPack = "";
        this.mediaCoverage = "";
        this.spokespeople = "";

        //Emergency supply chain    
        this.prepositionedStock = false;
        this.forThisResponse = false;
        this.plannedProcurement = "";
        this.procurementSpend = "";

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