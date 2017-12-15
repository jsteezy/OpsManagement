import BaseModel from "./BaseModel";

export default class NonSCIModel extends BaseModel {
    constructor() {
        super();

        this.responseId = null;
        this.reportId = null;

        // //Non SCI responses
        this.securedIncome = null;
        this.newAwards = null;
        this.responsePipeline = null;
        this.responsePipelineAppeal = null;
        this.seedFundsSecured = null;
        this.seedFundsSecuredYearly = null;
        this.CSF = null;
        this.responseTotalSpend = null;
        this.totalSpendAgainstCSF = null;
        this.totalSpendThroughPartners = null;
        this.totalSpendThroughCTP = null;
        this.totalSpendEducation = null;
    }
}