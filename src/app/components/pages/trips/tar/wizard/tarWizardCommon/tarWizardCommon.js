import template from "./tarWizardCommon.html";
import controller from "./TarWizardCommonController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        model: "=ngModel",
        currencies: "="
    },
    require: {
        form: "^form"
    }
};

export default component;
