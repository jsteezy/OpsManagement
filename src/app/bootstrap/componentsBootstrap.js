//main app component
import appMainComponent from "../components/root/root";

//page components
import emptyPage from "../components/pages/emptyPage/emptyPage";
import profileSearch from "../components/pages/profile/search/profileSearch";

import tarSearch from "../components/pages/trips/tar/search/tarSearch";
import tarWizardCommon from "../components/pages/trips/tar/wizard/tarWizardCommon/tarWizardCommon";
import tarDetailsCommon from "../components/pages/trips/tar/details/tarDetailsCommon/tarDetailsCommon";
import tarWizard from "../components/pages/trips/tar/wizard/tarWizard";
import tarDetails from "../components/pages/trips/tar/details/tarDetails";

//keep
import home from "../components/pages/home/home";
import reports from "../components/pages/reports/reports";
import create from "../components/pages/administrator/create/create";


import regions from "../components/pages/administrator/regions/regions";
import users from "../components/pages/administrator/users/users";
import exportComponent from "../components/pages/administrator/export/export";
import countries from "../components/pages/administrator/countries/countries";
import archive from "../components/pages/administrator/archive/archive";
import profileWizard from "../components/pages/administrator/wizard/profileWizard";

import tarApproval from "../components/pages/approvals/tar/search/tarApproval";
import tarApprovalWizard from "../components/pages/approvals/tar/wizard/tarApprovalWizard";
import tarHistory from "../components/pages/history/tar/tarHistory";
import tarHistoryDetails from "../components/pages/history/tar/details/tarHistoryDetails";



import accessDenied from "../components/pages/accessDenied/accessDenied";

//layout components
import menuLink from "../components/layout/menu/menuLink/menuLink";
import menuToggle from "../components/layout/menu/menuToggle/menuToggle";
import toolbar from "../components/layout/toolbar/toolbar";
import sidenav from "../components/layout/sidenav/sidenav";
import footer from "../components/layout/footer/footer";
import notification from "../components/layout/toolbar/notification/notification";
import loading from "../components/common/loading/loading";
import wizardHeader from "../components/layout/wizardHeader/wizardHeader";
import logo from "../components/layout/logo/logo";
import scrollToTop from "../components/layout/scrollToTop/scrollToTop";

import notificationArrow from "../components/common/notificationArrow/notificationArrow";
import grid from "../components/common/grid/grid";
import gridDateFilter from "../components/common/gridFilters/date/dateFilter";
import accordion from "../components/common/accordion/accordion";
import toggleAccordionSection from "../components/common/accordion/toggleSection/toggleSection";
import languagePicker from "../components/common/languagePicker/languagePicker";
import peoplePicker from "../components/common/peoplePicker/peoplePicker";
import fileUpload from "../components/common/fileUpload/fileUpload";
import attachments from "../components/common/attachments/attachments";
import question from "../components/common/question/question";
import list from "../components/common/list/list";
import bottomSheetList from "../components/common/bottomSheetList/bottomSheetList";
import workflowStatus from "../components/common/worflowStatus/workflowStatus";

import angular from "angular";

export default class Bootstrap {
    static register() {
        const app = angular.module("omt");

        app.component("app", appMainComponent);

        //page components
        app.component("emptyPage", emptyPage);
        app.component("profileSearch", profileSearch);
        app.component("profileWizard", profileWizard);


        app.component("tarSearch", tarSearch);
        app.component("tarWizardCommon", tarWizardCommon);
        app.component("tarWizard", tarWizard);
        app.component("tarDetailsCommon", tarDetailsCommon);
        app.component("tarDetails", tarDetails);

        app.component("home", home);
        app.component("reports", reports);
        

        app.component("regions", regions);
        app.component("users", users);
        app.component("export", exportComponent);
        app.component("countries", countries);
        app.component("archive", archive);
        app.component("notification", notification);
        app.component("tarApproval", tarApproval);
        app.component("tarApprovalWizard", tarApprovalWizard);
        app.component('tarHistory', tarHistory);
        app.component("tarHistoryDetails", tarHistoryDetails);



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
        app.component("logo", logo);
        app.component("scrollToTop", scrollToTop);

        app.component("grid", grid);
        app.component("gridDateFilter", gridDateFilter);
        app.component("accordion", accordion);
        app.component("toggleAccordionSection", toggleAccordionSection);
        app.component("languagePicker", languagePicker);
        app.component("peoplePicker", peoplePicker);
        app.component("fileUpload", fileUpload);
        app.component("attachments", attachments);
        app.component("question", question);
        app.component("list", list);
        app.component("bottomSheetList", bottomSheetList);
        app.component("workflowStatus", workflowStatus);
        app.component("notificationArrow", notificationArrow);
    }
}