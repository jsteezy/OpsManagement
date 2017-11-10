import template from "./eifWithFundsDetails.html";
import controller from "./EifWithFundsDetailsController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default component;
