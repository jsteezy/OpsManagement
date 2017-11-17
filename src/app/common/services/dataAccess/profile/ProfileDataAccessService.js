import BaseDataAccessService from "../BaseDataAccessService";
import dataAccessConfig from "./profileDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import mapper from "../../../helpers/ObjectMapper";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class ProfileDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }

    get(id) {
        let listName = "Response Codes";

        let replacements = {
            "{ID}": id,
            "{LIST_NAME}": listName
        };

        let requestUrl = helper.replaceData(dataAccessConfig.getProfile, replacements);

        let url = this.queryBuilder
            .queryValue(requestUrl)
            .selectAll()
            .comma()
            .queryValue(dataAccessConfig.expandUsers)
            .build();

        return this.$http.get(url);
    }

    save(data) {
        let listName = "Response Codes";

        let replacements = {
            "{LIST_NAME}": listName
        };

        let requestUrl = helper.replaceData(dataAccessConfig.addProfile, replacements);

        data = mapper.toJson(data);

        data = super.appendListItemTypeToRequestData(data, listName);

        data = JSON.stringify(data);

        let config = {};

        super.addDigestProperty(config);

        return this.$http.post(requestUrl, data, config);
    }

    update(data) {
        let listName = "Response Codes";

        let replacements = {
            "{ID}": data.id,
            "{LIST_NAME}": listName
        };

        let requestUrl = helper.replaceData(dataAccessConfig.updateProfile, replacements);

        let config = {
            headers: {
                "X-HTTP-Method": "MERGE",
                "If-Match": data.etag
            }
        };

        super.addDigestProperty(config);

        data = mapper.toJson(data);

        data = super.appendListItemTypeToRequestData(data, listName);

        data = JSON.stringify(data);

        return this.$http.post(requestUrl, data, config);
    }
}

ProfileDataAccessService.$inject = ["$http"];