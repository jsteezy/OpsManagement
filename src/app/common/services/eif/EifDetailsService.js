import ObjectMapper from "../../helpers/ObjectMapper";
import DateUtils from "../../helpers/DateUtils";
import Language from "../LanguageCache";
import EifDetailsModel from "../../models/EifDetailsModel";

export default class EifDetailsService {
    constructor( eifDataAccessService ) {
        this.eifDataAccessService = eifDataAccessService;
    }

    buildModel( identifier ) {
        let model = new EifDetailsModel();

        return this.eifDataAccessService.getEif(identifier)
            .then(
                ( data ) => {
                    if (data) {
                        ObjectMapper.toObject(data, model);
                        model.dateOfBirth = DateUtils.getFromString(model.dateOfBirth, Language.language);
                        model.initPeoplePickers();
                    }

                    return model;
                },
                ( errorData ) => {
                    return Promise.reject(errorData)
                });
    }
}

EifDetailsService.$inject = ["eifDataAccessService"]