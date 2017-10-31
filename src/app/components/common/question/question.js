import template from "./question.html";
import controller from "./QuestionController";

let component = {
    template,
    controller,
    controllerAs: "ctrl",
    transclude: true,
    bindings: {
        model: "=ngModel",
        options: "<",
        isDisabled: "="
    },
    require:{
        form: "^form"
    }
};

export default component;

