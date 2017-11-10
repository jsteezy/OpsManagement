import template from "./eifWizardCommon.html";
import controller from "./EifWizardCommonController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        model: "=ngModel",
        countries: "="
    },
    require: {
        form: "^form"
    }
};

export default component;
