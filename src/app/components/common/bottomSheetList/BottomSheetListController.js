import ObjectUtils from "../../../common/helpers/ObjectUtils";

export default class BottomSheetListController {
    constructor($mdBottomSheet) {
        this.$mdBottomSheet = $mdBottomSheet;
    }

    listItemClick(item){
        this.$mdBottomSheet.hide(item);
    }

    displayProperty(obj, path) {
        return ObjectUtils.getProperty(obj, path);
    }
}

BottomSheetListController.$inject = ["$mdBottomSheet"];
