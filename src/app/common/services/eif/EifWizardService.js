import ModelHelpers from "../../helpers/ModelHelpers";
import DateUtils from "../../helpers/DateUtils"
import Language from "../LanguageCache";
import ObjectMapper from "../../helpers/ObjectMapper";
import TripRequestHelpers from "../helpers/TripRequestHelpers";
import EifWizardModel from "../../models/EifWizardModel";
import BaseTarService from "../tar/BaseTarService";

export default class EifWizardService extends BaseTarService {
    constructor(user, commonDataService, eifDataAccessService, eifAttachmentsService) {
        super();
        
        this.user = user;
        this.commonDataService = commonDataService;
        this.eifDataAccessService = eifDataAccessService;
        this.eifAttachmentsService = eifAttachmentsService;
    }

    buildModel(data) {
        let model = new EifWizardModel();

        model.requesterId = this.user.id;

        if (data) {
            ObjectMapper.toObject(data, model);
            model.dateOfBirth = DateUtils.getFromString(model.dateOfBirth, Language.language);
            model.initPeoplePickers();
        }

        return model;
    }

    loadDraft(identifier) {
        return this.eifDataAccessService.getDraft(identifier)
            .then(
            (data) => {
                return this.buildModel(data);
            },
            (errorData) => {
                return Promise.reject(errorData)
            });
    }

    loadPageData() {
        return Promise.all([this.commonDataService.loadCountries()]);
    }

    storeRequest(model) {
        model.title = TripRequestHelpers.getEifId(model);
        
        let destinationsDetails = super.getDestinationsDetails(model.destinations);
        model.departureDate = destinationsDetails.departureDate;

        if (destinationsDetails.returnDate) {
            model.returnDate = destinationsDetails.returnDate;
        }

        return this.eifDataAccessService.saveAsEif(model)
            .then(
            (data) => {
                return this.eifAttachmentsService.storeRequestAttachments(data.Id, model)
            },
            (errorData) => {
                return Promise.reject(errorData);
            })
            .then(
            () => {
                if (!model.id || model.id == "") {
                    return Promise.resolve(true);
                }

                return this.deleteDraft(model);
            },
            (errorData) => {
                return Promise.reject(errorData);
            });
    }

    storeDraft(pageMode, model) {
        model.title = TripRequestHelpers.getDraftEifId(model);

        return this.eifDataAccessService[pageMode.eifDraftServiceAction](model)
            .then(
            (data) => {
                const modelId = ModelHelpers.getId(model, data);
                return this.eifAttachmentsService.storeDraftAttachments(modelId, model);
            },
            (errorData) => {
                return Promise.reject(errorData);
            });
    }

    deleteDraft(model) {
        return this.eifDataAccessService.deleteDraft(model.id);
    }
}

EifWizardService.$inject = ["user", "commonDataService", "eifDataAccessService", "eifAttachmentsService"]