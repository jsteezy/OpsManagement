import dataAccessConfig from "./tarApprovalDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import BaseDataAccessService from "../BaseDataAccessService";
import ObjectMapper from "../../../helpers/ObjectMapper";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class TarApprovalDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }

    getForBudget(userId, filters) {
        let replacements = {
            "{USER_ID}": userId
        };

        let filterQueryString = dataAccessConfig.getForBudgetApproverFilters;

        if (filters){
            filterQueryString = filters.query;
        }

        let filterQuery = helper.replaceData(filterQueryString, replacements);

        let requestUrl = this.queryBuilder
                                .queryValue(dataAccessConfig.getForBudgetApprover)
                                .queryValue(filterQuery)
                                .defaultTop()
                                .queryValue(dataAccessConfig.selectForBudgetApprover)
                                .queryValue(dataAccessConfig.expandTravellerAndRequester)
                                .build();

        return this.$http.get(requestUrl);
    }

    getAllForBudget(filters) {
        let filterQueryString = dataAccessConfig.getAllForBudgetApproverFilters;

        if (filters){
            filterQueryString = filters.query;
        }

        let requestUrl = this.queryBuilder
            .queryValue(dataAccessConfig.getForBudgetApprover)
            .queryValue(filterQueryString)
            .defaultTop()
            .queryValue(dataAccessConfig.selectForBudgetApprover)
            .queryValue(dataAccessConfig.expandUsers)
            .build();

        return this.$http.get(requestUrl);
    }

    getForSecurity(userId, filters) {
        let replacements = {
            "{USER_ID}": userId
        };

        let filterQueryString = dataAccessConfig.getForSecurityFilters;

        if (filters){
            filterQueryString = filters.query;
        }

        let filterQuery = helper.replaceData(filterQueryString, replacements);
        
        let requestUrl = this.queryBuilder
                                .queryValue(dataAccessConfig.getForSecurity)
                                .queryValue(filterQuery)
                                .defaultTop()
                                .queryValue(dataAccessConfig.selectForSecurity)
                                .queryValue(dataAccessConfig.expandUsers)
                                .build();
        
        return this.$http.get(requestUrl);
    }

    getTarTask(tarId) {
        let replacements = {
            "{TAR_ID}": tarId
        };

        let requestUrl = helper.replaceData(dataAccessConfig.getTask, replacements);

        return this.$http.get(requestUrl);
    }

    updateTarTask(taskId, data) {
        let replacements = {
            "{ITEM_ID}": taskId
        };

        let requestUrl = helper.replaceData(dataAccessConfig.approveTask, replacements);
        
        data = super.appendListItemTypeToRequestData(data, 'TAR Workflow Tasks');

        let config = {
            headers: {
                "X-HTTP-Method": "MERGE",
                "If-Match": "*"
            }
        };

        super.addDigestProperty(config);

        data = JSON.stringify(data);

        return this.$http.post(requestUrl, data, config);
    }
    
    updateTarStatus(id, data) {
        let replacements = {
            "{ITEM_ID}": id
        };
        
        let requestUrl = helper.replaceData(dataAccessConfig.updateTarApprovalStatus, replacements);
        
        data = ObjectMapper.toJson(data);
        
        data = super.appendListItemTypeToRequestData(data, 'TAR Requests');
        
        let config = {
            headers: {
                "X-HTTP-Method": "MERGE",
                "If-Match": "*"
            }
        };

        super.addDigestProperty(config);

        data = JSON.stringify(data);

        return this.$http.post(requestUrl, data, config);
    }
}