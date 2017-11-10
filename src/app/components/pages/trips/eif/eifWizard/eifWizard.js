import template from "./eifWizard.html";
import controller from "./EifWizardController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default component;
