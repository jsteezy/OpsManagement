import dataAccessConfig from "./eifDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import ObjectMapper from "../../../helpers/ObjectMapper";
import BaseDataAccessService from "../BaseDataAccessService";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class EifDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }

    getAll( filters ) {
        let replacements = {
            "{LIST_NAME}": dataAccessConfig.EIFListName
        }

        let filterQueryString = filters ? filters.query : "";


        let requestUrl = dataAccessConfig.getAll;

        requestUrl = helper.replaceData(requestUrl, replacements);

        var url = this.queryBuilder
                        .queryValue(requestUrl)
                        .queryValue(filterQueryString)
                        .defaultTop()
                        .selectAll()
                        .comma()
                        .queryValue(dataAccessConfig.expandUsers)
                        .build();

        return this.$http.get(url);
    }
    
    getEif(id) {
        return this.get(dataAccessConfig.EIFListName, id);
    }
    
    getDraft(id) {
        return this.get(dataAccessConfig.EIFDraftsListName, id);
    }
    
    get(listName, id) {
        let replacements = {
            "{LIST_NAME}": listName,
            "{ID}": id 
        };
        
        let requestUrl = dataAccessConfig.getItem;
        
        requestUrl = helper.replaceData(requestUrl, replacements);
        
        requestUrl += dataAccessConfig.expandUsers;
        
        return this.$http.get(requestUrl);
    }
    
    getEifDraftsForUser(userId) {
        let replacements = {
            "{USER_ID}": userId,
            "{LIST_NAME}": dataAccessConfig.EIFDraftsListName
        };
        
        let requestUrl = helper.replaceData(dataAccessConfig.getEifDraftsForUser, replacements);
        
        return this.$http.get(requestUrl);
    }
    
    getEifRequestsForUser(userId) {
        let replacements = {
            "{USER_ID}": userId,
            "{LIST_NAME}": dataAccessConfig.EIFListName,
            "{EXPAND_USERS}": dataAccessConfig.expandUsers
        };
        
        let requestUrl = helper.replaceData(dataAccessConfig.getEifSubmittedForUser, replacements);
        
        return this.$http.get(requestUrl);
    }
    
    saveAsEif(data) {
        return this.save(dataAccessConfig.EIFListName, data);
    }
    
    saveAsDraft(data) {
        return this.save(dataAccessConfig.EIFDraftsListName, data);
    }
    
    save(listName, data) {
        let replacements = {
            "{LIST_NAME}": listName
        };
        
        let requestUrl = helper.replaceData(dataAccessConfig.saveEif, replacements);
        
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
            "{LIST_NAME}": dataAccessConfig.EIFDraftsListName
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

        data = super.appendListItemTypeToRequestData(data, dataAccessConfig.EIFDraftsListName);

        data = JSON.stringify(data);

        return this.$http.post(requestUrl, data, config);
    }

    deleteDraft(id) {
        let replacements = {
            "{ITEM_ID}": id,
            "{LIST_NAME}": dataAccessConfig.EIFDraftsListName
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

EifDataAccessService.$inject = ["$http"];