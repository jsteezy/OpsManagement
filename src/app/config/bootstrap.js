import angular from "angular";
import ObjectMapper from "../common/helpers/ObjectMapper";
import LanguageCache from "../common/services/LanguageCache";
import GlobalFeaturesCache from "../common/services/GlobalFeaturesCache";
import Permissions from "../common/enums/permissions.json";

export default class AngularApp {
    static bootstrap() {
        const $injector = angular.injector(['ng', 'omt']);

        const userService = $injector.get("userService");
        const profileService = $injector.get("profileDataAccessService");

        const appStart = () => {
            angular.element(document).ready(() => {
                angular.bootstrap(document, ["omt"])
            })
        };

        userService.getCurrentUser().then((data) => {
                let userModel = ObjectMapper.toUserModel(data);

                userModel.permissions = userModel.groups.concat(Permissions.everyone);

                angular.module("omt").constant("user", userModel);

                profileService.get(userModel.id).then(
                    (profileData) => {
                        const profile = ObjectMapper.toAnonymous(profileData[0]);
                        LanguageCache.language = profile.userLanguage;

                        GlobalFeaturesCache.isAppRunning = true;
                        GlobalFeaturesCache.hasProfile = true;

                        appStart();
                    },
                    () => {
                        GlobalFeaturesCache.isAppRunning = true;

                        appStart();
                    })
            },
            () => {
                throw "User error";
            });
    }
}