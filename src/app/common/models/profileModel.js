import ProfileCommonModel from "./ProfileCommonModel";

export default class ProfileModel extends ProfileCommonModel {
    constructor() {
        super();

        //this.userId = "";
        //this.userEmail = "";
        // this.code = "";
        // this.description = "";
        // this.startDate = DateUtils.today;
        // this.region = "";
        // this.country = "";

        // this.userLanguage = "";
        // this.profileHasAccess = {};
        // this.profileHasAccessId = {};
        // this.profileOthersAccess = [];
        // this.profileOthersAccessId = 0;

        super.excludeProperties(this.getExcludedProperties());
    }

    addNewUserWhoHasAccess(id) {
        if (!this.profileHasAccessId || !this.profileHasAccessId.results) {
            this.profileHasAccessId = { results: [] }
        }

        this.profileHasAccessId.results.push(id);
    }

    initPeoplePickers() {
        this.peoplePickerProperties.forEach((prop) => {
            if (this[prop] === undefined ||
                this[prop].length === 0 ||
                this[prop][0].Title == null) {

                this[prop] = [];
            }
        });
    }

    getExcludedProperties() {
        return ["profileHasAccess",
            "profileOthersAccess",
            "lineManager"
        ];
    }

    get peoplePickerProperties() {
        return ["profileOthersAccess", "lineManager"];
    }

    get multipleValuesProperties() {
        return ["profileHasAccessId"];
    }
}