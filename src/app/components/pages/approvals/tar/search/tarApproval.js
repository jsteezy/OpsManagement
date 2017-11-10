import template from "./tarApproval.html";
import controller from "./TarApprovalController";

let tarSearch = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default tarSearch;