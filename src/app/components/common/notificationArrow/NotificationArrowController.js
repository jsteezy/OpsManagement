import BaseComponentController from "../BaseComponentController";

export default class LoadingController extends BaseComponentController {
    constructor() {
        super();

        let animate = () => {
            let element = window.jQuery('#notification_arrow');


            element.animate({
                fontSize: element.css('fontSize') == '40px' ? '30px' : '40px'
            }, 500, animate);
        }

        window.jQuery(document).ready(animate);
    }
}