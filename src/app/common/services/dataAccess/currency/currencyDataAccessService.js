import dataAccessConfig from "./currencyDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";

export default class CurrencyDataAccessService {
    constructor($http) {
        this.$http = $http;
    }

    getAll() {
        let itemCountPromise = this.$http.get(dataAccessConfig.getItemCount);

        return itemCountPromise.then((data) => {
            let replacements = {
                "{ITEM_COUNT}": data.ItemCount
            };

            let requestUrl = helper.replaceData(dataAccessConfig.getAll, replacements);

            return this.$http.get(requestUrl);
        });
    }
}