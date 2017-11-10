import template from "./emergencyContact.html";
import controller from "./EmergencyContactController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        contact: "=ngModel"
    }
};

export default component;