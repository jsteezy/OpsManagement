//import ObjectMapper from "../../helpers/ObjectMapper";
//import ProfileModel from "../../models/ProfileModel";
//import StringHelpers from "../../helpers/StringHelpers";

export default class PeoplePickerService {
    constructor( $injector, userService, profileDataAccessService, cache ) {
        this.$injector = $injector;
        this.userService = userService;
        this.profileDataAccessService = profileDataAccessService;
        this.cache = cache;
    }

    queryUsers( query ) {
        let usersPromise = this.userService.searchUsersInSite(query);

        return usersPromise.then(( data ) => {
            return data;
        });
    }

    queryUsersIncludingOwn( query ) {
        let usersPromise = this.userService.searchUsersInSiteIncludingOwn(query);

        return usersPromise.then(( data ) => {
            return data;
        });
    }

    queryUsersInGroup( query, group ) {
        let usersPromise = this.userService.searchUsersInGroup(query, group);

        return usersPromise.then(( data ) => {
            return data;
        });
    }

    queryUsersInGroupIncludingOwn( query, group ) {
        let usersPromise = this.userService.searchUsersInGroupIncludingOwn(query, group);

        return usersPromise.then(( data ) => {
            return data;
        });
    }

   

   
}

PeoplePickerService.$inject = ["$injector", "userService", "profileDataAccessService", "cache"];