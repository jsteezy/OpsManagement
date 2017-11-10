import template from "./tarSearch.html";
import controller from "./TarSearchController";

let tarSearch = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default tarSearch;