import angular from "angular";
import envConfig from "./envConfig.json";
import LanguageCache from "../common/services/LanguageCache";

export default class TranslateConfig{
    static config(){
        const app = angular.module("omt");

        app.config(($translateProvider) =>{
            $translateProvider
                .useStaticFilesLoader({
                    prefix: envConfig.baseUrl + 'i18n/',
                    suffix: '.txt'
                })
                .preferredLanguage('en-gb')
                .useSanitizeValueStrategy(null);
        });

        app.run(['$injector', ($injector) => {
            if ($injector.has("$translate")){
                const $translate = $injector.get("$translate");

                $translate.use(LanguageCache.language);
            }
        }]);
    }
}
