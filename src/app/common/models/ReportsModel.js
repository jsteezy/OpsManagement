import BaseModel from "./BaseModel";
import DateUtils from "../helpers/DateUtils";
import ApprovalStatuses from "../enums/approvalStatuses.json";

export default class ReportsModel extends BaseModel {
    constructor() {
        super();

        //this.editor = "";
        this.responseId = "";
        this.status = ApprovalStatuses.none;
        //General info
        // this.regionalResponse = false;
        // this.parentRegionalResponse = "";
        this.sitrepDate = DateUtils.today;
        this.nextSitrepDate = DateUtils.today;
        // this.recentContextDevelopment = "";
        this.opsBackstop = "";

        this.category = "";
        this.phase = "";
        this.SCIImplemented = false;
        this.sitrepNumber = "";
        this.generalContextInternal = "";
        this.generalContextExternal = "";   
        this.responseUpdateInternal = "";
        this.responseUpdateExternal = "";
        this.challengesInternal = "";
                
        // //Non SCI responses
       // this.nonSciResponses = false;

        //Reach figures
        this.affectedPopulation = "";
        this.strategyTarget = "";
        this.totalReachSinceStart = "";
        this.totalReachSinceLastSitrep = "";
        this.childrenReachedSinceStart = "";
        this.childrenReachedSinceLastSitrep = "";

        this.strategyTargetChildren = "";

        // //Income
        this.responseStrategyTarget = "";
        this.seedFundsTarget = "";
        this.seedFundsTargetDate = DateUtils.today;

        this.crisisModifiers = "";

        //Deliverables
        this.assessmentBool = false;
        //this.assessment = "";
        this.outlineBool = false;
        //this.outline = "";
        this.strategyBool = false;
        //this.strategy = "";
        this.planBool = false;
        //this.plan = "";
        this.operationsControlReviewBool = false;
        //this.operationsControlReview = "";
        this.realTimeReviewBool = false;
        //this.realTimeReview = "";
        this.representationOnHCTBool = false;
        this.educationClusterBool = false;
        this.staffingEducationClusterBool = false;

        // //Sectors
        //this.childProtectionBool = false;
        this.childProtectionBackstop = "";
        this.childProtectionSummary = "";
        //this.educationBool = false;
        this.educationBackstop = "";
        this.educationSummary = "";
        //this.FSLBool = false;
        this.FSLBackstop = "";
        this.FSLSummary = "";
        //this.WASHBool = false;
        this.WASHBackstop = "";
        this.WASHSummary = "";
        //this.shelterBool = false;
        this.shelterBackstop = "";
        this.shelterSummary = "";
        //this.healthBool = false;
        this.healthBackstop = "";
        this.healthSummary = "";




        //this.EHUUpdatesBool = false;
        //this.EHUUpdates = "";
        this.EHUDeployed = false;
        this.EHUDeployedDate = DateUtils.today;
        this.outputTracker = "";
        this.nutritionSummary = "";

        //HR
        this.nationalStaffNumber = "";
        this.internationalStaffNumber = "";

        this.deploymentTrackerLink = "";

        //Saftey and security
        //this.securityLevel = "";
        //this.incidentSummary = "";
        //this.securityEvents = "";
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

        this.advocacyActions = "";        

        // //Emergency supply chain    
        this.prepositionedStock = false;
        this.forThisResponse = false;
        this.plannedProcurement = "";
        this.procurementSpend = "";
    }
}