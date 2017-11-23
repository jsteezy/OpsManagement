import dataAccessConfig from "./responseCodeDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import mapper from "../../../helpers/ObjectMapper";
import BaseDataAccessService from "../BaseDataAccessService";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class ResponseCodeDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }
    
    getResponse(id) {
        return this.get(dataAccessConfig.getResponse, id);
    }    
    

    getAllResponses() {

        let requestUrl = dataAccessConfig.getAllResponses;

        return this.$http.get(requestUrl);
    }
    
    save(data) {
        let listName = "Response Codes";

        let replacements = {
            "{LIST_NAME}": listName
        };

        let requestUrl = helper.replaceData(dataAccessConfig.addResponse, replacements);

        data = mapper.toJson(data);

        data = super.appendListItemTypeToRequestData(data, listName);

        data = JSON.stringify(data);

        let config = {};

        super.addDigestProperty(config);

        return this.$http.post(requestUrl, data, config);
    }
}

ResponseCodeDataAccessService.$inject = ["$http"];