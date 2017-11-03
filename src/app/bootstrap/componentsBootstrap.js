//main app component
import appMainComponent from "../components/root/root";

//page components
import emptyPage from "../components/pages/emptyPage/emptyPage";
import home from "../components/pages/home/home";
//import members from "../components/pages/administrator/members/members";
//import regions from "../components/pages/administrator/regions/regions";
import users from "../components/pages/administrator/users/users";
//import exportComponent from "../components/pages/administrator/export/export";
import countries from "../components/pages/administrator/countries/countries";
import create from "../components/pages/administrator/create/create";
import accessDenied from "../components/pages/accessDenied/accessDenied";

//layout components
import menuLink from "../components/layout/menu/menuLink/menuLink";
import menuToggle from "../components/layout/menu/menuToggle/menuToggle";
import toolbar from "../components/layout/toolbar/toolbar";
import sidenav from "../components/layout/sidenav/sidenav";
import footer from "../components/layout/footer/footer";
import loading from "../components/common/loading/loading";
import wizardHeader from "../components/layout/wizardHeader/wizardHeader";
import logo from "../components/layout/logo/logo";
import scrollToTop from "../components/layout/scrollToTop/scrollToTop";

import requestsFloatingButton from "../components/layout/requestsFloatingButton/floatingBtn";
import grid from "../components/common/grid/grid";
import gridDateFilter from "../components/common/gridFilters/date/dateFilter";
import accordion from "../components/common/accordion/accordion";
import toggleAccordionSection from "../components/common/accordion/toggleSection/toggleSection";
import peoplePicker from "../components/common/peoplePicker/peoplePicker";
import fileUpload from "../components/common/fileUpload/fileUpload";
import attachments from "../components/common/attachments/attachments";
import question from "../components/common/question/question";
import list from "../components/common/list/list";
import bottomSheetList from "../components/common/bottomSheetList/bottomSheetList";

import angular from "angular";

export default class Bootstrap {
    static register() {
        const app = angular.module("omt");

        app.component("app", appMainComponent);

        //page components
        app.component("emptyPage", emptyPage);
        app.component("home", home);
        // app.component("members", members);
        // app.component("regions", regions);
        app.component("users", users);
        //app.component("export", exportComponent);
        app.component("countries", countries);
        app.component("create", create);
        app.component("accessDenied", accessDenied);

        //layout components
        app.component("menuLink", menuLink);
        app.component("menuToggle", menuToggle);
        app.component("toolbar", toolbar);
        app.component("sidenav", sidenav);
        app.component("footer", footer);
        app.component("loading", loading);
        app.component("wizardHeader", wizardHeader);
        app.component("requestsFloatingButton", requestsFloatingButton);
        app.component("logo", logo);
        app.component("scrollToTop", scrollToTop);

        app.component("grid", grid);
        app.component("gridDateFilter", gridDateFilter);
        app.component("accordion", accordion);
        app.component("toggleAccordionSection", toggleAccordionSection);
        app.component("peoplePicker", peoplePicker);
        app.component("fileUpload", fileUpload);
        app.component("attachments", attachments);
        app.component("question", question);
        app.component("list", list);
        app.component("bottomSheetList", bottomSheetList);
    }
}