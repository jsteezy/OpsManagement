import dataAccessConfig from "./accountCodesDataAccessConfig.json";

export default class AccountCodesDataAccessService {
    constructor($http) {
        this.$http = $http;
    }
    
    getAll() {
        return this.$http.get(dataAccessConfig.getAll);
    }
}

AccountCodesDataAccessService.$inject = ["$http"];