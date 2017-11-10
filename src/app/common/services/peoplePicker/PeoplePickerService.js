import ObjectMapper from "../../helpers/ObjectMapper";
import ProfileModel from "../../models/ProfileModel";
import StringHelpers from "../../helpers/StringHelpers";

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

    queryEmergencyContacs( query ) {
        const userId = this.$injector.get("user").id;
        let profilePromise = this.profileDataAccessService.get(userId);

        return profilePromise.then(( data ) => {
            let model = ObjectMapper.toObject(data, new ProfileModel());
            return model.emergencyContacts
                .filter(x => StringHelpers.includes(x.contactName, query))
                .map(x => {
                    x.Title = x.contactName
                    return x;
                });
        });
    }

    queryEmergencyContactsForTraveller( query ) {
        const cache = this.cache.getById("traveller");
        let travellerId = cache.get("travellerId");

        let profilePromise = this.profileDataAccessService.get(travellerId);
        return profilePromise.then(( data ) => {
            let model = ObjectMapper.toObject(data, new ProfileModel());

            return model.emergencyContacts
                .filter(x => StringHelpers.includes(x.contactName, query))
                .map(x => {
                    x.Title = x.contactName
                    return x;
                });
        });
    }
}

PeoplePickerService.$inject = ["$injector", "userService", "profileDataAccessService", "cache"];