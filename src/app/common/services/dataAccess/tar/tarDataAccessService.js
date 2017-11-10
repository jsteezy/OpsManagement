import dataAccessConfig from "./tarDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import ObjectMapper from "../../../helpers/ObjectMapper";
import BaseDataAccessService from "../BaseDataAccessService";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class TarDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }
    
    getTar(id) {
        return this.get(dataAccessConfig.tarRequestsListName, id);
    }
    
    getDraft(id) {
        return this.get(dataAccessConfig.tarDraftsListName, id);
    }

    get(listName, id) {
        let replacements = {
            "{TAR_ID}": id,
            "{LIST_NAME}": listName
        };

        let requestUrl = dataAccessConfig.getItem;

        requestUrl = helper.replaceData(requestUrl, replacements);

        requestUrl += dataAccessConfig.expandUsers;

        return this.$http.get(requestUrl);
    }

    getTarsForUser(userId, filters) {
        let replacements = {
            "{USER_ID}": userId
        };

        let filterQueryString = dataAccessConfig.getTarsFilter;

        if (filters){
            filterQueryString = filters.query;
        }

        let filterQuery = helper.replaceData(filterQueryString, replacements);

        let requestUrl = this.queryBuilder
                                .queryValue(dataAccessConfig.getTarsForUser)
                                .queryValue(filterQuery)
                                .defaultTop()
                                .selectAll()
                                .comma()
                                .queryValue(dataAccessConfig.expandUsers)
                                .build();
        
        return this.$http.get(requestUrl);
    }

    getTarDraftsForUser(userId) {
        let replacements = {
            "{USER_ID}": userId
        };

        let requestUrl = helper.replaceData(dataAccessConfig.getTarDraftsForUser, replacements);

        return this.$http.get(requestUrl);
    }

    saveAsTar(data) {
        return this.save(dataAccessConfig.tarRequestsListName, data);
    }

    saveAsDraft(data) {
        return this.save(dataAccessConfig.tarDraftsListName, data);
    }
    
    save(listName, data) {
        let replacements = {
            "{LIST_NAME}": listName
        };
        
        let requestUrl = helper.replaceData(dataAccessConfig.saveTar, replacements);

        data = ObjectMapper.toJson(data);

        data = super.appendListItemTypeToRequestData(data, listName);

        data = JSON.stringify(data);
        
        let config = {};
        super.addDigestProperty(config);
        
        return this.$http.post(requestUrl, data, config); 
    }
    
    updateDraft(data) {
        let replacements = {
            "{ITEM_ID}": data.id,
            "{LIST_NAME}": dataAccessConfig.tarDraftsListName
        };
        
        let requestUrl = helper.replaceData(dataAccessConfig.update, replacements);
        
        let config = {
            headers: {
                "X-HTTP-Method": "MERGE",
                "If-Match": data.etag
            }  
        };
        
        super.addDigestProperty(config);
        
        data = ObjectMapper.toJson(data);
        
        data = super.appendListItemTypeToRequestData(data, dataAccessConfig.tarDraftsListName);
        
        data = JSON.stringify(data);
        
        return this.$http.post(requestUrl, data, config);
    }
    
    deleteDraft(id) {
        let replacements = {
            "{ITEM_ID}": id,
            "{LIST_NAME}": dataAccessConfig.tarDraftsListName
        };
        
        let requestUrl = helper.replaceData(dataAccessConfig.delete, replacements);
        
        let config = {
             headers: {
                "X-HTTP-Method": "DELETE",
                "If-Match": "*"
            }  
        };
        
        super.addDigestProperty(config);
        
        return this.$http.post(requestUrl, {}, config);
    }
}

TarDataAccessService.$inject = ["$http"];