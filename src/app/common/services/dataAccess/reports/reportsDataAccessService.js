import dataAccessConfig from "./responseCodeDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import mapper from "../../../helpers/ObjectMapper";
import BaseDataAccessService from "../BaseDataAccessService";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class ReportDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }
    
    getReports(id) {
        return this.get(dataAccessConfig.getReports, id);
    }    
    

    getAllReportss() {

        let requestUrl = dataAccessConfig.getAllReportss;

        return this.$http.get(requestUrl);
    }
    
    save(data) {
        let listName = "Reports Codes";

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

ReportsCodeDataAccessService.$inject = ["$http"];