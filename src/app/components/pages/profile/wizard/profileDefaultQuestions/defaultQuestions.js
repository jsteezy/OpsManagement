import template from "./defaultQuestions.html";
import controller from "./DefaultQuestionsController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    bindings: {
        model: "=ngModel",
        areRequired: "<"
    },
    require:{
        form: "^form"
    }
};

export default component;