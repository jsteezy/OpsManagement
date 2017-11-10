import template from "./tarWizard.html";
import controller from "./TarWizardController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default component;
