import Answers from "../../../common/enums/answers.json";
import FormUtils from "../../../common/helpers/FormUtils";
import BaseComponentController from "../BaseComponentController";
import EventTypes from "../../../common/enums/eventsTypes.json";

export default class QuestionController extends BaseComponentController {
    constructor($scope) {
        super();

        this.$scope = $scope;

        this.setEmptyAnswerIfNecessary(this.model);

        this.options = this.options || {};

        this.hidden = false;
        this.answers = Answers.values;
        this.empty = Answers.empty;

        this.setModelWatcher();

        super.setListener(EventTypes.hideQuestion, (params) => {
            let questionName = params[0];

            if (this.options.name === questionName) {
                this.hidden = true;
            }
        });
    }

    setModelWatcher() {
        const self = this;

        this.$scope.$watch("ctrl.model", (newVal) => {
            self.setEmptyAnswerIfNecessary(newVal);
            self.validate(newVal);
        });
    }

    setEmptyAnswerIfNecessary(currentValue) {
        if (!currentValue || currentValue == "") {
            this.model = Answers.empty;
        }
    }

    isWarningVisible() {
        return this.model != Answers.yes;
    }

    validate(value) {
        if (this.options.required && value == Answers.empty) {
            FormUtils.invalidateProperty(this.form, this.options.name, "novalue")
        }
        else {
            FormUtils.validateProperty(this.form, this.options.name, "novalue")
        }
    }
}

QuestionController.$inject = ["$scope"];