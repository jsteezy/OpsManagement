import template from "./workflowStatus.html";
import controller from "./WorkflowStatusController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        model: "=ngModel"
    }
};

export default component;

