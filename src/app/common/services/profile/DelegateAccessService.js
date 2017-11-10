//import ObjectMapper from "../../helpers/ObjectMapper";

export default class DelegateAccessService {
    constructor( profileService ) {
        this.profileService = profileService;
    }

    buildModel() {
        return this.profileService.loadProfile()
            .then(
                ( data ) => {
                    return this.profileService.buildModel(data);
                });
    }

    store( pageMode, model ) {
        return this.profileService.loadProfile(model.profileOthersAccessId)
            .then(
                ( data ) => {
                    return this.profileService.buildModel(data, model.profileOthersAccessId);
                })
            .then(( data ) => {
                data.addNewUserWhoHasAccess(model.userId)
                return this.profileService.store(pageMode, data);
            })
            .then(
                () => {
                    return this.profileService.store(pageMode, model);
                }
            )
    }
}

DelegateAccessService.$inject = ["profileService"];
