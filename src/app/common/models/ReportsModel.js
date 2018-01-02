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
        //General info
        // this.regionalResponse = false;
        // this.parentRegionalResponse = null;
        this.sitrepDate = DateUtils.today;
        this.nextSitrepDate = DateUtils.today;
        // this.recentContextDevelopment = null;
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
        //this.assessmentBool = false;
        this.assessment = null;
        //this.outlineBool = false;
        this.outline = null;
        //this.strategyBool = false;
        this.strategy = null;
        //this.planBool = false;
        this.plan = null;
        //this.operationsControlReviewBool = false;
        this.operationsControlReview = null;
        //this.realTimeReviewBool = false;
        this.realTimeReview = null;
        this.representationOnHCTBool = false;
        this.educationClusterBool = false;
        this.staffingEducationClusterBool = false;

        // //Sectors
        //this.childProtectionBool = false;
        this.childProtectionBackstop = null;
        this.childProtectionSummary = null;
        //this.educationBool = false;
        this.educationBackstop = null;
        this.educationSummary = null;
        //this.FSLBool = false;
        this.FSLBackstop = null;
        this.FSLSummary = null;
        //this.WASHBool = false;
        this.WASHBackstop = null;
        this.WASHSummary = null;
        //this.shelterBool = false;
        this.shelterBackstop = null;
        this.shelterSummary = null;
        //this.healthBool = false;
        this.healthBackstop = null;
        this.healthSummary = null;
        //this.EHUUpdatesBool = false;
        //this.EHUUpdates = null;
        this.EHUDeployed = false;
        this.EHUDeployedDate = DateUtils.today;
        this.outputTracker = null;
        this.nutritionSummary = null;

        //HR
        this.nationalStaffNumber = null;
        this.internationalStaffNumber = null;

        this.deploymentTrackerLink = null;

        //Saftey and security
        //this.securityLevel = null;
        //this.incidentSummary = null;
        //this.securityEvents = null;
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


    }
}