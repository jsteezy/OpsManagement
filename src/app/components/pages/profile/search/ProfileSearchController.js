import BaseController from "../../../common/BaseController";

export default class ProfileController extends BaseController {
    constructor( $injector,
                 profileSearchService ) {
        super($injector);

        super.router = this.$router;

        this.title = "OTHERS_PROFILE";

        this.profileSearchService = profileSearchService;

        //this.setProfileGridOptions();
    }

    $routerOnActivate( next, current ) {
        super.permissions = [super.appPermissions.everyone];

        let init = () => {
            super.$routerOnActivate(next, current);
            return this.activate();
        };

        return super.initializePage(init);
    }

    activate() {
        return super.initializePageData(this.loadData());
    }

    loadData() {
        // return this.profileSearchService.buildModel()
        //     .then(
        //         ( data ) => {
        //             this.profileForOthersOptions.data = data;
        //             this.profileForOthersOptions.isGridReady = true;
        //         },
        //         ( errorData ) => {
        //             super.serverRequestErrors = errorData;
        //         });
    }

    openProfile( row ) {
        super.redirectTo(["OthersProfileWizard", { userId: row.entity.id }])
    }

    // setProfileGridOptions() {
    //     this.profileForOthersOptions = GridOptions.options.profileForOthersOptions;
    //     this.profileForOthersOptions.appScopeProvider = this;
    // }
}

ProfileController.$inject = [
    "$injector",
    "profileSearchService"
];