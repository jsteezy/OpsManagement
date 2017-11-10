import angular from "angular";
import '@angular/router/angular1/angular_1_router.js';

export default class StateConfig {
    static config() {
        const app = angular.module("omt");

        app.value('$routerRootComponent', 'app');
    }

    static getModules() {
        return ['ngComponentRouter'];
    }

    static getPaths() {
        return [{
                path: '/profile-search',
                name: 'ProfileSearch',
                component: 'profileSearch'
            },
            {
                path: '/profile-wizard',
                name: 'ProfileWizard',
                component: 'profileWizard'
            },
            {
                path: '/others-profile-wizard/:userId',
                name: 'OthersProfileWizard',
                component: 'profileWizard'
            },
            {
                path: '/tar-search',
                name: 'TarSearch',
                component: 'tarSearch',
                useAsDefault: true
            },
            {
                path: '/add/tar-wizard',
                name: 'TarWizardAdd',
                component: 'tarWizard'
            },
            {
                path: '/edit/draft/tar-wizard/:id',
                name: 'TarWizardDraftEdit',
                component: 'tarWizard'
            },
            {
                path: '/details/tar-details/:id',
                name: 'TarDetails',
                component: 'tarDetails'
            },
            {
                path: '/approval/tar',
                name: 'TarApproval',
                component: 'tarApproval'
            },
            {
                path: '/approval/tar/:id/...',
                name: 'TarApprovalWizard',
                component: 'tarApprovalWizard'
            },
            {
                path: '/history/tar',
                name: 'TarHistory',
                component: 'tarHistory'
            },
            {
                path: '/eif-search',
                name: 'EifSearch',
                component: 'eifSearch'
            },
            {
                path: '/add/eif-wizard',
                name: 'EifWizardAdd',
                component: 'eifWizard'
            },
            {
                path: '/edit/draft/eif-wizard/:id',
                name: 'EifWizardDraftEdit',
                component: 'eifWizard'
            },
            {
                path: '/add/eif-funds-wizard',
                name: 'EifWithFundsWizardAdd',
                component: 'eifWithFundsWizard'
            },
            {
                path: '/edit/eif-funds-wizard/:eifId/:tarId',
                name: 'EifWithFundsWizardEdit',
                component: 'eifWithFundsWizard'
            },
            {
                path: '/details/eif-details/:id',
                name: 'EifDetails',
                component: 'eifDetails'
            },
            {
                path: '/details/eif-funds-details/:eifId/:tarId',
                name: 'EifWithFundsDetails',
                component: 'eifWithFundsDetails'
            },
            {
                path: '/eif-search-all',
                name: 'EifSearchAll',
                component: 'eifSearchAll'
            },
            {
                path: '/access-denied',
                name: 'AccessDenied',
                component: 'accessDenied'
            },
            {
                path: "/home",
                name: "Home",
                component: 'home'
            },
            {
                path: '/admin-members',
                name: 'Members',
                component: 'members'
            },
            {
                path: '/admin-regions',
                name: 'Regions',
                component: 'regions'
            },
            {
                path: '/admin-countries',
                name: 'Countries',
                component: 'countries'
            },
            {
                path: '/admin-org-unit-types',
                name: 'OrgUnitTypes',
                component: 'orgUnitTypes'
            },
            {
                path: '/admin-org-units',
                name: 'OrgUnits',
                component: 'orgUnits'
            },
            {
                path: '/admin-users',
                name: 'Users',
                component: 'users'
            },
            {
                path: '/admin-export',
                name: 'Export',
                component: 'export'
            },
            {
                path: '/admin-archive',
                name: 'Archive',
                component: 'archive'
            },
            {
                path: '/*otherwise',
                redirectTo: ['TarSearch']
            }
        ];
    }
}