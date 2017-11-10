import ObjectMapper from "../../helpers/ObjectMapper";
import TarSearchModel from "../../models/TarSearchModel";
import BaseTarService from "./BaseTarService";
import TarBudgetApproverFilters from "../../gridFilters/TarBudgetApprover";
import TarSuperBudgetApproverFilters from "../../gridFilters/TarSuperBudgetApprover";
import TarSecurityApproverFilters from "../../gridFilters/TarSecurity";

export default class TarApprovalService extends BaseTarService {
    constructor(user, tarApprovalDataAccessService) {
        super();

        this.user = user;
        this.tarApprovalDataAccessService = tarApprovalDataAccessService;
    }

    getBudgetList(filters) {
        return this.tarApprovalDataAccessService.getForBudget(this.user.id, filters).then((data) => {
            return this.getData(data);
        });
    }

    getAllBudgetList( filters ) {
        return this.tarApprovalDataAccessService.getAllForBudget(filters).then((data) => {
            return this.getData(data);
        });
    }

    getSecurityList(filters) {
        return this.tarApprovalDataAccessService.getForSecurity(this.user.id, filters).then((data) => {
            return this.getData(data);
        })
    }

    getData(data) {
        let optionsData = [];

        data.forEach((tar) => {
            let tarModel = ObjectMapper.toObject(tar, new TarSearchModel());

            let destinationsDetails = super.getDestinationsDetails(tarModel.destinations);

            optionsData.push({
                id: tarModel.title,
                requester: tarModel.requester[0] ? tarModel.requester[0].Title : "",
                traveller: tarModel.traveller[0] ? tarModel.traveller[0].Title : "",
                destinations: destinationsDetails.destinations,
                directors: destinationsDetails.directors,
                departureDate: destinationsDetails.departureDate,
                returnDate: destinationsDetails.returnDate,
                budgetApprover: tarModel.budgetApprover[0] ? tarModel.budgetApprover[0].Title : ""
            });
        });

        return optionsData;
    }

    get budgetApproverFilters() {
        return new TarBudgetApproverFilters();
    }

    get superBudgetApproverFilters() {
        return new TarSuperBudgetApproverFilters();
    }

    get securityApproverFilters() {
        return new TarSecurityApproverFilters();
    }
}

TarApprovalService.$inject = ["user", "tarApprovalDataAccessService"];
