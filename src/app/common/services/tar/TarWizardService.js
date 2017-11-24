import ModelHelpers from "../../helpers/ModelHelpers";
import TripRequestHelpers from "../helpers/TripRequestHelpers";
import DateUtils from "../../helpers/DateUtils";
import Language from "../LanguageCache";
import ObjectMapper from "../../helpers/ObjectMapper";
import TarWizardModel from "../../models/TarWizardModel";
import TarCommonModel from "../../models/ProfileCommonModel";
import BaseTarService from "./BaseTarService";

export default class TarWizardService extends BaseTarService {
    constructor(user, tarDataAccessService, profileDataAccessService, tarAttachmentsService, commonDataService, cache) {
        super(cache);

        this.user = user;

        this.tarDataAccessService = tarDataAccessService;
        this.profileDataAccessService = profileDataAccessService;
        this.tarAttachmentsService = tarAttachmentsService;
        this.commonDataService = commonDataService;
    }

    buildModel(data) {
        let model = this.buildBasicModel();

        let travellerId = this.getTravellerId(data);

        return this.loadProfileForTraveller(travellerId, model)
            .then(() => {
                if (data) {
                    ObjectMapper.toObject(data, model);
                    model.gSSTrainingDate = DateUtils.getDateOrEmpty(model.gSSTrainingDate, Language.language);
                }

                //this.setDefaultTraveller(model);
                //this.setDefaultPeoplePickers(model);

                return model;
            });
    }

    buildBasicModel(data) {
        let model = new TarWizardModel();

        model.requesterId = this.user.id;
        model.travellerId = this.user.id;

        if (data) {
            ObjectMapper.toObject(data, model);
            model.gSSTrainingDate = DateUtils.getDateOrEmpty(model.gSSTrainingDate, Language.language);

            //this.setDefaultPeoplePickers(model);
        }

        return model;
    }

    loadProfileForTraveller(travellerId, model) {
        super.cacheCurrentTravellerId(travellerId);

        return this.profileDataAccessService.get(travellerId)
            .then(
                (data) => {
                    ObjectMapper.toObject(data, model, ["id", "etag"]);
                    model.gSSTrainingDate = DateUtils.getDateOrEmpty(model.gSSTrainingDate, Language.language);

                    return model;
                },
                () => {
                    return model //Promise.reject("Profile not found, please fill you profile");
                });
    }

    loadDraft(identifier) {
        return this.tarDataAccessService.getDraft(identifier)
            .then(
                (data) => {
                    return this.buildModel(data);
                },
                (errorData) => {
                    return Promise.reject(errorData)
                });
    }


    loadBasicDraft(identifier) {
        return this.tarDataAccessService.getDraft(identifier)
            .then(
                (data) => {
                    return this.buildBasicModel(data);
                },
                (errorData) => {
                    return Promise.reject(errorData)
                });
    }

    loadPageData() {
        return Promise.all();
    }

    getTravellerId(data) {
        let model = ObjectMapper.toAnonymous(data);

        return model.travellerId !== undefined && model.travellerId !== "" ? model.travellerId : this.user.id;
    }


    storeRequest(model) {
        model.title = TripRequestHelpers.getTarId(model);

        model.destinations.forEach(x => {
            if (x.country.travelRestrictions) {
                model.requiresGssApproval = true;
            }
        });

        let destinationsDetails = super.getDestinationsDetails(model.destinations);
        model.departureDate = destinationsDetails.departureDate;

        if (destinationsDetails.returnDate) {
            model.returnDate = destinationsDetails.returnDate;
        }

        return this.tarDataAccessService.saveAsTar(model)
            .then(
                (data) => {
                    return this.tarAttachmentsService.storeRequestAttachments(data.Id, model)
                },
                (errorData) => {
                    return Promise.reject(errorData);
                })
            .then(
                () => {
                    let promises = [ModelHelpers.getTitle(model)];

                    if (model.id && model.id != "") {
                        promises.push(this.deleteDraft(model));
                    }

                    return promises;
                },
                (errorData) => {
                    return Promise.reject(errorData);
                });
    }

    storeDraft(pageMode, model) {
        model.title = TripRequestHelpers.getTarDraftId(model);

        return this.tarDataAccessService[pageMode.tarDraftServiceAction](model)
            .then(
                (data) => {
                    const modelId = ModelHelpers.getId(model, data);

                    return Promise.all([
                        ModelHelpers.getTitle(model, data),
                        this.tarAttachmentsService.storeDraftAttachments(modelId, model)
                    ]);
                },
                (errorData) => {
                    return Promise.reject(errorData);
                });
    }

    deleteDraft(model) {
        return this.tarDataAccessService.deleteDraft(model.id);
    }

    clearProfileItems(model) {
        let commonModel = new TarCommonModel();

        let id = model.id;
        let etag = model.etag;

        ObjectMapper.toObject(commonModel, model);

        model.selectedEmergencyContacts = [];

        model.id = id;
        model.etag = etag;
    }

    setDefaultPeoplePickers(model) {
        model.initPeoplePickers();
    }

    setDefaultTraveller(model) {
        if (!model.travellerId || model.traveller.length == 0) {
            model.travellerId = this.user.id;
            model.traveller.push({
                Id: this.user.id,
                Title: this.user.title
            })

            super.cacheCurrentTravellerId(model.travellerId);
        }
    }
}

TarWizardService.$inject = [
    "user",
    "tarDataAccessService",
    "profileDataAccessService",
    "tarAttachmentsService",
    "commonDataService",
    "cache"
];