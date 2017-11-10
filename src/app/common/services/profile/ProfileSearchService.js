import ObjectMapper from "../../helpers/ObjectMapper";
import ProfileSearchModel from "../../models/ProfileSearchModel";

export default class ProfileSearchService {
    constructor( user, $injector ) {
        this.user = user;
        this.profileService = $injector.get("profileService");
    }

    buildModel() {
        return this.profileService.loadProfile()
            .then(
                ( data ) => {
                    let profileModel = this.profileService.buildModel(data);

                    return this.getData(profileModel);
                },
                () => {
                    return Promise.reject("Profile not found, please fill you profile");
                });
    }

    getData( profileModel ) {
        if (!profileModel.profileHasAccess.results) return [];

        return profileModel.profileHasAccess.results.map(x => {
            return ObjectMapper.toObject(x, new ProfileSearchModel());
        })
    }
}

ProfileSearchService.$inject = ["user", "$injector"];
