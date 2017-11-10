import dataAccessConfig from "./tarHistoryDataAccessConfig.json";
import helper from "../../../helpers/AppHelpers";
import BaseDataAccessService from "../BaseDataAccessService";
import QueryBuilder from "../../../queryUtils/QueryBuilder";

export default class TarHistoryDataAccessService extends BaseDataAccessService {
    constructor($http) {
        super();
        this.$http = $http;

        this.queryBuilder = new QueryBuilder();
    }

    getTars( userId, filters ) {
        return [this.getActiveTars(userId, filters), this.getArchiveTars(userId, filters)];
    }

    getArchiveTars( userId, filters ) {
        let replacements = {
            "{USER_ID}": userId,
            "{YEAR}": filters.yearValue
        };

        let filterQueryString = dataAccessConfig.filter;


        if (filters){
            filterQueryString = filters.queryArchive;
        }

        return this.get(this.archiveUrl, replacements, filterQueryString);
    }

    getActiveTars( userId, filters ) {
        let replacements = {
            "{USER_ID}": userId
        };

        let filterQueryString = dataAccessConfig.filter;


        if (filters){
            filterQueryString = filters.queryRequests;
        }

        return this.get(this.requestsUrl, replacements, filterQueryString);
    }

    get( url, replacements, filterQueryString ) {
        let requestUrl = helper.replaceData(url, replacements);

        let filterQuery = helper.replaceData(filterQueryString, replacements);

        requestUrl = this.queryBuilder
            .queryValue(requestUrl)
            .queryValue(filterQuery)
            .defaultTop()
            .selectAll()
            .comma()
            .queryValue(dataAccessConfig.expandUsers)
            .build();

        return this.$http.get(requestUrl)
            .then(
                ( data ) => {
                    return Promise.resolve(data);
                },
                () => {
                    return Promise.resolve([]);
                }
            );
    }

    get archiveUrl() {
        return dataAccessConfig.getArchive
    }

    get requestsUrl() {
        return dataAccessConfig.getRequests;
    }
}

TarHistoryDataAccessService.$inject = ["$http"];