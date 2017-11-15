import template from "./profileWizard.html";
import controller from "./ProfileWizardController";

let profile = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: '<'
    }
};

export default profile;