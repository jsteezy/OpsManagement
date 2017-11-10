import ObjectMapper from "../../helpers/ObjectMapper";
import TarSearchModel from "../../models/TarSearchModel";
import TarWaitingForApproval from "../../gridFilters/TarWaitingForApproval";
import BaseTarService from "./BaseTarService";

export default class TarSearchService extends BaseTarService {
    constructor(user, tarDataAccessService) {
        super();

        this.user = user;
        this.tarDataAccessService = tarDataAccessService;
    }

    getTars(filters) {
        return this.tarDataAccessService.getTarsForUser(this.user.id, filters).then((data) => {
            return this.getDataForWaitingApproval(data);
        });
    }

    getDrafts() {
        return this.tarDataAccessService.getTarDraftsForUser(this.user.id).then(( data ) => {
            return this.getDataForDrafts(data);
        })
    }

    getDataForWaitingApproval(data) {
        return data.map(tar => {

            let tarModel = ObjectMapper.toObject(tar, new TarSearchModel());

            let destinationsDetails = super.getDestinationsDetails(tarModel.destinations);

            return {
                "id": tarModel.title,
                "requester": tarModel.requester[0] ? tarModel.requester[0].Title : "",
                "traveller": tarModel.traveller[0] ? tarModel.traveller[0].Title : "",
                "destinations": destinationsDetails.destinations,
                "directors": destinationsDetails.directors,
                "departureDate": destinationsDetails.departureDate,
                "returnDate": destinationsDetails.returnDate,
                "budgetApprover": tarModel.budgetApprover[0].Title,
                "budgetApprovalStatus": tarModel.budgetApprovalStatus,
                "budgetApprovalTimestamp": tarModel.budgetApprovalTimestamp,
                "gSSApprovalStatus": tarModel.gSSApprovalStatus,
                "gSSApprovalTimestamp": tarModel.gSSApprovalTimestamp
            };
        });
    }

    getDataForDrafts(data) {
        let optionsData = [];

        data.forEach((draft) => {
            let tarModel = ObjectMapper.toObject(draft, new TarSearchModel());

            let destinationsDetails = super.getDestinationsDetails(tarModel.destinations);

            optionsData.push({
                id: tarModel.id,
                title: tarModel.title,
                requester: tarModel.requester[0] ? tarModel.requester[0].Title : "",
                traveller: tarModel.traveller[0] ? tarModel.traveller[0].Title : "",
                destinations: destinationsDetails.destinations
            });
        });

        return optionsData;
    }

    deleteDraft(id) {
        return this.tarDataAccessService.deleteDraft(id);
    }

    deleteDrafts(draftIds) {
        let deleteDraftPromises = [];

        if (draftIds.length == 0) return [];

        draftIds.forEach((id) => {
            deleteDraftPromises.push(this.tarDataAccessService.deleteDraft(id));
        });

        return deleteDraftPromises;
    }

    get waitingForApprovalFilters() {
        return new TarWaitingForApproval();
    }
}

TarSearchService.$inject = ["user", "tarDataAccessService"];
