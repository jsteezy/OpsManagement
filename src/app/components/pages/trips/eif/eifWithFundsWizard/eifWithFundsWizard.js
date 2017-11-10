import template from "./eifWithFundsWizard.html";
import controller from "./EifWithFundsWizardController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default component;
