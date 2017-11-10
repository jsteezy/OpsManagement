import FormUtils from "../../../common/helpers/FormUtils";
import LanguageCache from "../../../common/services/LanguageCache";

export default class LanguagePickerController {
    constructor($translate, cache) {
        this.$translate = $translate;
        this.cache = cache;

        this.languageOpen = true;
    }

    changeLanguage(language){
        this.model = language;
        this.$translate.use(language).then(() => {
            LanguageCache.language = language;
        });

        FormUtils.setAsDirty(this.form);
    }
}

LanguagePickerController.$inject = ["$translate", "cache"];
