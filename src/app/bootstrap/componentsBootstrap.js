//main app component
import appMainComponent from "../components/root/root";

//page components
import emptyPage from "../components/pages/emptyPage/emptyPage";
import profileSearch from "../components/pages/profile/search/profileSearch";
import profileWizard from "../components/pages/profile/wizard/profileWizard";
import profileDelegateAccess from "../components/pages/profile/delegateAccess/delegateAccess";
import tarSearch from "../components/pages/trips/tar/search/tarSearch";
import tarWizardCommon from "../components/pages/trips/tar/wizard/tarWizardCommon/tarWizardCommon";
import tarDetailsCommon from "../components/pages/trips/tar/details/tarDetailsCommon/tarDetailsCommon";
import tarWizard from "../components/pages/trips/tar/wizard/tarWizard";
import tarDetails from "../components/pages/trips/tar/details/tarDetails";
import home from "../components/pages/home/home";
import members from "../components/pages/administrator/members/members";
import regions from "../components/pages/administrator/regions/regions";
import users from "../components/pages/administrator/users/users";
import exportComponent from "../components/pages/administrator/export/export";
import countries from "../components/pages/administrator/countries/countries";
import orgUnitTypes from "../components/pages/administrator/orgUnitTypes/orgUnitTypes";
import orgUnits from "../components/pages/administrator/orgUnits/orgUnits";
import archive from "../components/pages/administrator/archive/archive";
import emergencyContact from "../components/pages/profile/wizard/emergencyContact/emergencyContact";
import emergencyContactView from "../components/pages/trips/tar/details/emergencyContactView/emergencyContactView";
import expensesCodes from "../components/pages/profile/wizard/expensesCodes/expensesCodes";
import profileDefaultQuestions from "../components/pages/profile/wizard/profileDefaultQuestions/defaultQuestions";
import destination from "../components/pages/trips/tar/wizard/destination/destination";
import travelAdvance from "../components/pages/trips/tar/wizard/travelAdvance/travelAdvance";
import estimatedCosts from "../components/pages/trips/tar/wizard/estimatedCosts/estimatedCosts";
import budgetCodes from "../components/pages/trips/tar/wizard/budgetCodes/budgetCodes";
import tarApproval from "../components/pages/approvals/tar/search/tarApproval";
import tarApprovalWizard from "../components/pages/approvals/tar/wizard/tarApprovalWizard";
import tarHistory from "../components/pages/history/tar/tarHistory";
import tarHistoryDetails from "../components/pages/history/tar/details/tarHistoryDetails";

import eifSearch from "../components/pages/trips/eif/search/eifSearch";
import eifWizardCommon from "../components/pages/trips/eif/eifWizard/eifWizardCommon/eifWizardCommon";
import eifWithFundsWizard from "../components/pages/trips/eif/eifWithFundsWizard/eifWithFundsWizard";
import eifWizard from "../components/pages/trips/eif/eifWizard/eifWizard";
import eifDetailsCommon from "../components/pages/trips/eif/eifDetails/eifDetailsCommon/eifDetailsCommon";
import eifDetails from "../components/pages/trips/eif/eifDetails/eifDetails";
import eifWithFundsDetails from "../components/pages/trips/eif/eifWithFundsDetails/eifWithFundsDetails";
import eifSearchAll from "../components/pages/approvals/eif/search/eifSearch";

import create from "../components/pages/administrator/create/create";

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
import requestsFloatingButton from "../components/layout/requestsFloatingButton/floatingBtn";
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
        app.component("profileDelegateAccess", profileDelegateAccess);
        app.component("emergencyContact", emergencyContact);
        app.component("emergencyContactView", emergencyContactView);
        app.component("tarSearch", tarSearch);
        app.component("tarWizardCommon", tarWizardCommon);
        app.component("tarWizard", tarWizard);
        app.component("tarDetailsCommon", tarDetailsCommon);
        app.component("tarDetails", tarDetails);
        app.component("home", home);
        app.component("members", members);
        app.component("regions", regions);
        app.component("users", users);
        app.component("export", exportComponent);
        app.component("countries", countries);
        app.component("orgUnitTypes", orgUnitTypes);
        app.component("orgUnits", orgUnits);
        app.component("archive", archive);
        app.component("notification", notification);
        app.component("expensesCodes", expensesCodes);
        app.component("destination", destination);
        app.component("travelAdvance", travelAdvance);
        app.component("estimatedCosts", estimatedCosts);
        app.component("budgetCodes", budgetCodes);
        app.component("profileDefaultQuestions", profileDefaultQuestions);
        app.component("tarApproval", tarApproval);
        app.component("tarApprovalWizard", tarApprovalWizard);
        app.component('tarHistory', tarHistory);
        app.component("tarHistoryDetails", tarHistoryDetails);

        app.component("eifSearch", eifSearch);
        app.component("eifWizardCommon", eifWizardCommon);
        app.component("eifWizard", eifWizard);
        app.component("eifWithFundsWizard", eifWithFundsWizard);
        app.component("eifDetailsCommon", eifDetailsCommon);
        app.component("eifDetails", eifDetails);
        app.component("eifWithFundsDetails", eifWithFundsDetails);
        app.component("eifSearchAll", eifSearchAll);

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