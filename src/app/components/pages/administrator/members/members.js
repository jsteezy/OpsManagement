import template from "./members.html";
import controller from "./MembersController";

let members = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default members;