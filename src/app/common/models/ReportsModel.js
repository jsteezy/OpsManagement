import BaseModel from "./BaseModel";
import DateUtils from "../helpers/DateUtils";
import ApprovalStatuses from "../enums/approvalStatuses.json";

export default class ReportsModel extends BaseModel {
    constructor() {
        super();

        this.userId = null;        
        this.userEmail = null;
        this.responseId = null;
        this.status = ApprovalStatuses.none;
        this.lastModifiedUserName = null;
        //General info
        this.sitrepDate = DateUtils.today;
        this.nextSitrepDate = DateUtils.today;
        this.opsBackstop = null;

        this.category = null;
        this.phase = null;
        //this.SCIImplemented = false;
        this.sitrepNumber = null;
        this.generalContextInternal = null;
        this.generalContextExternal = null;
        this.responseUpdateInternal = null;
        this.responseUpdateExternal = null;
        this.challengesInternal = null;

        // //Non SCI responses
        this.nonSciResponses = false;

        //Reach figures
        this.affectedPopulation = null;
        this.strategyTarget = null;
        this.totalReachSinceStart = null;
        this.totalReachSinceLastSitrep = null;
        this.childrenReachedSinceStart = null;
        this.childrenReachedSinceLastSitrep = null;

        this.strategyTargetChildren = null;

        // //Income
        this.responseStrategyTarget = null;
        this.seedFundsTarget = null;
        this.seedFundsTargetDate = DateUtils.today;

        this.crisisModifiers = null;

        //Deliverables
        this.assessment = null;
        this.outline = null;
        this.strategy = null;
        this.plan = null;
        this.operationsControlReview = null;
        this.realTimeReview = null;
        this.representationOnHCTBool = false;
        this.educationClusterBool = false;
        this.staffingEducationClusterBool = false;

        // //Sectors
        this.childProtectionBackstop = null;
        this.childProtectionSummary = null;
        this.educationBackstop = null;
        this.educationSummary = null;
        this.fSLBackstop = null;
        this.fSLSummary = null;
        this.wASHBackstop = null;
        this.wASHSummary = null;
        this.shelterBackstop = null;
        this.shelterSummary = null;
        this.healthBackstop = null;
        this.healthSummary = null;
        this.eHUDeployed = false;
        this.eHUDeployedDate = null;
        this.outputTracker = null;
        this.nutritionSummary = null;

        //HR
        this.nationalStaffNumber = null;
        this.internationalStaffNumber = null;

        this.deploymentTrackerLink = null;

        //Saftey and security
        this.securityContext = null;
        this.securityChallenges = null;
        this.securityManagement = null;

        //Child safegaurding
        this.staffChildSafegaurding = null;
        this.safegaurdingFocalPoint = null;
        this.safegaurdingRisks = null;

        //Advanced Media and Comms
        this.commsPack = null;
        this.mediaCoverage = null;
        this.spokespeople = null;

        this.advocacyActions = null;

        //Emergency supply chain    
        this.prepositionedStock = false;
        this.forThisResponse = false;
        this.plannedProcurement = null;
        this.procurementSpend = null;

        //Non SCI responses
        this.securedIncome = null;
        this.newAwards = null;
        this.responsePipeline = null;
        this.responsePipelineAppeal = null;
        this.seedFundsSecured = null;
        this.seedFundsSecuredYearly = null;
        this.cSF = null;
        this.responseTotalSpend = null;
        this.totalSpendAgainstCSF = null;
        this.totalSpendThroughPartners = null;
        this.totalSpendThroughCTP = null;
        this.totalSpendEducation = null;
    }
}