import dataAccessConfig from "./reportsDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import mapper from "../../../helpers/ObjectMapper";
import BaseDataAccessService from "../BaseDataAccessService";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class ReportsDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }
    
    getResponse(id) {
        let listName = "Response Codes";

        let replacements = {
            "{ID}": id,
            "{LIST_NAME}": listName
        };

        let requestUrl = helper.replaceData(dataAccessConfig.getResponse, replacements);

        let url = this.queryBuilder
            .queryValue(requestUrl)
            .selectAll()
            .build();

        return this.$http.get(url);
    } 
    

    getAllReports() {

        let requestUrl = dataAccessConfig.getAllReports;

        return this.$http.get(requestUrl);
    }
    
    save(data) {
        let listName = "Reports";

        let replacements = {
            "{LIST_NAME}": listName
        };

        let requestUrl = helper.replaceData(dataAccessConfig.addReports, replacements);

        data = mapper.toJson(data);

        data = super.appendListItemTypeToRequestData(data, listName);

        data = JSON.stringify(data);

        let config = {};

        super.addDigestProperty(config);

        return this.$http.post(requestUrl, data, config);
    }
}

ReportsDataAccessService.$inject = ["$http"];