import BaseModalController from "../../../../../common/BaseModalController";
import DestinationModel from "./../../../../../../common/models/DestinationModel";
import DestinationsValidator from "../../../../../../common/services/destinations/DestinationsValidator";
import PageModes from "../../../../../../common/enums/pageModes.json";
import DateUtils from "../../../../../../common/helpers/DateUtils";
import ObjectUtils from "../../../../../../common/helpers/ObjectUtils";

export default class DestinationController extends BaseModalController {
    constructor(commonDataService, $injector, cache, toastService) {
        super($injector);

        this.destinationsValidator = DestinationsValidator.instance;
        this.cache = cache;
        this.toastService = toastService;

        this.overlapDestinations = [];
        this.commonDataService = commonDataService;

        this.activate();
    }

    activate() {
        super.model = new DestinationModel();
        super.pageMode = PageModes.add;

        const cache = this.cache.getById("listModel");

        this.allDestinations = cache.get("destinations");
        if (this.allDestinations == null) {
            this.allDestinations = [];
        }

        if (this.destination) {
            this.allDestinations = this.allDestinations.filter(x => !ObjectUtils.equals(x, this.destination));

            this.setModel();
        }

        this.commonDataService.loadCountries().then((data) => {
            this.countries = data
        });
    }

    setModel() {
        super.model = this.destination;
        
        super.model.departureDate = DateUtils.getFromString(super.model.departureDate);

        if (!super.model.isOneWay) {
            super.model.returnDate = DateUtils.getFromString(super.model.returnDate);
        }

        super.pageMode = PageModes.edit;
    }

    storeDestination(form) {
        super.IsSubmittedFormValid(form).then(() => {
            if (!this.destinationsValidator.isValid(super.model, this.allDestinations)) {
                this.toastService.showToast(this.destinationsValidator.errors);
            }
            else {
                super.sendResponse(super.model);
                
            }
        })
    }

    isRestrictedCountry() {
        return super.model.country && super.model.country.travelRestrictions;
    }

    minReturnDate() {
        return super.model.departureDate;
    }

    setTripForOneWay() {
        super.model.returnDate = super.model.isOneWay ? null : super.model.departureDate;
    }

    get destinationDatesError() {
        return this._destError;
    }

    set destinationDatesError(value) {
        this._destError = value;
    }
}

DestinationController.$inject = ["commonDataService", "$injector", "cache", "toastService"];