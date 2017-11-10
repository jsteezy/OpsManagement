import template from "./emergencyContactView.html";
import controller from "./EmergencyContactViewController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        contact: "=ngModel"
    }
};

export default component;