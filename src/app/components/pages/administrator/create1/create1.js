import template from "./create1.html";
import controller from "./Create1Controller";

let create1 = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default create1;