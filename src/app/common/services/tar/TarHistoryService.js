import TarHistoryFilters from "../../gridFilters/TarHistory";
import ObjectMapper from "../../helpers/ObjectMapper";
import TarSearchModel from "../../models/TarSearchModel";
import TarDetailsModel from "../../models/TarDetailsModel";
import BaseTarService from "./BaseTarService";

export default class TarHistoryService extends BaseTarService {
    constructor( user, tarHistoryDataAccessService ) {
        super();

        this.user = user;
        this.tarHistoryDataAccessService = tarHistoryDataAccessService;
    }

    getTars(filters) {
        return Promise.all(this.tarHistoryDataAccessService.getTars(this.user.id, filters)).then((data) => {
            let tars = data[0].concat(data[1]);

            return this.getData(tars);
        })
    }

    getData( data ) {
        
        return data.map(( tar ) => {
            let tarModel = ObjectMapper.toObject(tar, new TarSearchModel());

            let destinationsDetails = super.getDestinationsDetails(tarModel.destinations);

            return {
                id: tarModel.id,
                title: tarModel.title,
                requester: tarModel.requester[0] ? tarModel.requester[0].Title : "",
                traveller: tarModel.traveller[0] ? tarModel.traveller[0].Title : "",
                destinations: destinationsDetails.destinations,
                directors: destinationsDetails.directors,
                departureDate: destinationsDetails.departureDate,
                returnDate: destinationsDetails.returnDate,
                budgetApprover: tarModel.budgetApprover[0].Title,
                budgetApprovalStatus: tarModel.budgetApprovalStatus,
                budgetApprovalTimestamp: tarModel.budgetApprovalTimestamp,
                gSSApprovalStatus: tarModel.gSSApprovalStatus,
                gSSApprovalTimestamp: tarModel.gSSApprovalTimestamp,
                detailsViewData: tar
            };
        });
    }

    getDetailsModel( tar ) {
        if (!tar) return new TarDetailsModel();

        let tarModel = ObjectMapper.toObject(tar, new TarDetailsModel());
        tarModel.initPeoplePickers();

        return tarModel;
    }

    get historyFilters() {
        return new TarHistoryFilters();
    }
}

TarHistoryService.$inject = ["user", "tarHistoryDataAccessService"]
