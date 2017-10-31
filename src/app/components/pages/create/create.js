import template from "./create.html";
import controller from "./CreateController";

let create = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default create;

