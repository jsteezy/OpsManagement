import angular from "angular";

export default class BottomSheetService {
    constructor($mdBottomSheet) {
        this.$mdBottomSheet = $mdBottomSheet;
    }

    open(model, options) {
        return this.$mdBottomSheet.show({
            template: `<bottom-sheet-list ng-model="ctrl.bottomListModel" options="ctrl.bottomListOptions"></bottom-sheet-list>`,
            controller: angular.noop,
            controllerAs: 'ctrl',
            bindToController: true,
            parent: options.parentTag,
            locals:{
                bottomListModel: angular.copy(model),
                bottomListOptions: options
            }
        })
    }
}

BottomSheetService.$inject = ['$mdBottomSheet'];
