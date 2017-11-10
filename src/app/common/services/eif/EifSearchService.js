import ObjectMapper from "../../helpers/ObjectMapper";
import BaseTarService from "../tar/BaseTarService";
import EifSearchModel from "../../models/EifSearchModel";
import EifSearchAllFilters from "../../gridFilters/EifSearchAll";

export default class EifSearchService extends BaseTarService {
    constructor(user, eifDataAccessService, tarDataAccessService) {
        super();

        this.user = user;
        this.eifDataAccessService = eifDataAccessService;
        this.tarDataAccessService = tarDataAccessService;
    }

    getAllRequests( filters ) {
        return this.eifDataAccessService.getAll(filters).then(( data ) => {
            return this.getDataForSubmitted(data);
        });
    }

    getDrafts() {
        return this.eifDataAccessService.getEifDraftsForUser(this.user.id);
    }

    getDataForDrafts(data) {
        let optionsData = [];

        data.forEach((draft) => {
            let eifModel = ObjectMapper.toObject(draft, new EifSearchModel());

            let destinationsDetails = super.getDestinationsDetails(eifModel.destinations);

            optionsData.push({
                id: eifModel.id,
                tarId: eifModel.tarId,
                title: eifModel.title,
                requester: eifModel.requester[0] ? eifModel.requester[0].Title : "",
                guestTraveller: this.buildGuestTravellerName(eifModel),
                destinations: destinationsDetails.destinations
            });
        });

        return optionsData;
    }

    getSubmitted() {
        return this.eifDataAccessService.getEifRequestsForUser(this.user.id);
    }

    getDataForSubmitted(data) {
        let optionsData = [];

        data.forEach((request) => {
            let eifModel = ObjectMapper.toObject(request, new EifSearchModel());

            let destinationsDetails = super.getDestinationsDetails(eifModel.destinations);

            optionsData.push({
                id: eifModel.id,
                tarId: eifModel.tarId,
                title: eifModel.title,
                requester: eifModel.requester[0] ? eifModel.requester[0].Title : "",
                staffResponsible: eifModel.staffResponsibleForGuest[0] ? eifModel.staffResponsibleForGuest[0].Title : "",
                guestTraveller: this.buildGuestTravellerName(eifModel),
                destinations: destinationsDetails.destinations,
                restrictedCountries: destinationsDetails.restrictedCountries,
                departureDate: destinationsDetails.departureDate,
                returnDate: destinationsDetails.returnDate
            })
        });
        
        return optionsData;
    }

    buildGuestTravellerName(model) {
        let name = "";

        if (model.firstName) {
            name = model.firstName;
        }

        if (model.lastName) {
            if (name) {
                name += ", " + model.lastName;
            } else {
                name = model.lastName;
            }
        }

        return name;
    }

    deleteEifDraft(id) {
        return this.eifDataAccessService.deleteDraft(id);
    }

    deleteTarDraft(id) {
        return this.tarDataAccessService.getDraft(id).then((data) => {
            if (data.length > 0) {
                return this.tarDataAccessService.deleteDraft(data[0].Id);
            }
        });
    }

    deleteDrafts(drafts) {
        let deleteDraftPromises = [];

        if (drafts.length == 0) return [];

        drafts.forEach((draft) => {
            deleteDraftPromises.push(this.deleteEifDraft(draft.id));
            if (draft.tarId) {
                deleteDraftPromises.push(this.deleteTarDraft(draft.tarId));
            }
        });

        return deleteDraftPromises;
    }

    get eifFilters() {
        return new EifSearchAllFilters();
    }
}

EifSearchService.$inject = ["user", "eifDataAccessService", "tarDataAccessService"];