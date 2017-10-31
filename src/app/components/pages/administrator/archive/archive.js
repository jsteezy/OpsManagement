import template from "./archive.html";
import controller from "./ArchiveController";

let archive = {
    template, 
    controller,
    controllerAs: "ctrl",
    bindings: {
        $router: "<"
    }
};

export default archive;