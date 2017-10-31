import AppHelpers from "../../helpers/AppHelpers";
import config from "../../enums/tarEif.json";

export default class TripRequestHelpers {
    static getTarId(model) {
        let replacements = TripRequestHelpers.Replacements;

        replacements["{TRAVELLER_ID}"] = model.travellerId;

        return AppHelpers.replaceData(config.TARId, replacements)
    }

    static getTarDraftId(model) {
        if (model.title) return model.title;

        let replacements = TripRequestHelpers.Replacements;

        replacements["{REQUESTER_ID}"] = model.requesterId;

        return AppHelpers.replaceData(config.TARDraftId, replacements)
    }

    static getEifId(model) {
        let replacements = TripRequestHelpers.Replacements;

        replacements["{REQUESTER_ID}"] = model.requesterId;

        return AppHelpers.replaceData(config.EIFId, replacements)
    }

    static getDraftEifId(model) {
        return model.title ? model.title : this.getEifId(model);

    }

    static get Replacements() {
        return {
            "{DATE}": AppHelpers.IdFromCurrentDateTime
        }
    }
}