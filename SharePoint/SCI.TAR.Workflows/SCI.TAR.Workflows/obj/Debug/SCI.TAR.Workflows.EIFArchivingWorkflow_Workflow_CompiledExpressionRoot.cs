namespace SCI.TAR.Workflows.EIFArchivingWorkflow {
    
    #line 17 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System;
    
    #line default
    #line hidden
    
    #line 1 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Collections;
    
    #line default
    #line hidden
    
    #line 18 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Collections.Generic;
    
    #line default
    #line hidden
    
    #line 1 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Activities;
    
    #line default
    #line hidden
    
    #line 1 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Activities.Expressions;
    
    #line default
    #line hidden
    
    #line 1 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Activities.Statements;
    
    #line default
    #line hidden
    
    #line 19 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Data;
    
    #line default
    #line hidden
    
    #line 20 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Text;
    
    #line default
    #line hidden
    
    #line 21 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using Microsoft.Activities;
    
    #line default
    #line hidden
    
    #line 1 "C:\O365\tar\SharePoint\SCI.TAR.Workflows\SCI.TAR.Workflows\EIFArchivingWorkflow\Workflow.xaml"
    using System.Activities.XamlIntegration;
    
    #line default
    #line hidden
    
    
    public partial class Workflow : System.Activities.XamlIntegration.ICompiledExpressionRoot {
        
        private System.Activities.Activity rootActivity;
        
        private object dataContextActivities;
        
        private bool forImplementation = true;
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        public string GetLanguage() {
            return "C#";
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        public object InvokeExpression(int expressionId, System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext) {
            if ((this.rootActivity == null)) {
                this.rootActivity = this;
            }
            if ((this.dataContextActivities == null)) {
                this.dataContextActivities = Workflow_TypedDataContext2.GetDataContextActivitiesHelper(this.rootActivity, this.forImplementation);
            }
            if ((expressionId == 0)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[0] == null)) {
                    cachedCompiledDataContext[0] = new Workflow_TypedDataContext2(locations, activityContext, true);
                }
                Workflow_TypedDataContext2 refDataContext0 = ((Workflow_TypedDataContext2)(cachedCompiledDataContext[0]));
                return refDataContext0.GetLocation<string>(refDataContext0.ValueType___Expr0Get, refDataContext0.ValueType___Expr0Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 1)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[1] == null)) {
                    cachedCompiledDataContext[1] = new Workflow_TypedDataContext4_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext4_ForReadOnly valDataContext1 = ((Workflow_TypedDataContext4_ForReadOnly)(cachedCompiledDataContext[1]));
                return valDataContext1.ValueType___Expr1Get();
            }
            if ((expressionId == 2)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[2] == null)) {
                    cachedCompiledDataContext[2] = new Workflow_TypedDataContext4(locations, activityContext, true);
                }
                Workflow_TypedDataContext4 refDataContext2 = ((Workflow_TypedDataContext4)(cachedCompiledDataContext[2]));
                return refDataContext2.GetLocation<int>(refDataContext2.ValueType___Expr2Get, refDataContext2.ValueType___Expr2Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 3)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[1] == null)) {
                    cachedCompiledDataContext[1] = new Workflow_TypedDataContext4_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext4_ForReadOnly valDataContext3 = ((Workflow_TypedDataContext4_ForReadOnly)(cachedCompiledDataContext[1]));
                return valDataContext3.ValueType___Expr3Get();
            }
            if ((expressionId == 4)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[1] == null)) {
                    cachedCompiledDataContext[1] = new Workflow_TypedDataContext4_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext4_ForReadOnly valDataContext4 = ((Workflow_TypedDataContext4_ForReadOnly)(cachedCompiledDataContext[1]));
                return valDataContext4.ValueType___Expr4Get();
            }
            if ((expressionId == 5)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[1] == null)) {
                    cachedCompiledDataContext[1] = new Workflow_TypedDataContext4_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext4_ForReadOnly valDataContext5 = ((Workflow_TypedDataContext4_ForReadOnly)(cachedCompiledDataContext[1]));
                return valDataContext5.ValueType___Expr5Get();
            }
            if ((expressionId == 6)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[2] == null)) {
                    cachedCompiledDataContext[2] = new Workflow_TypedDataContext4(locations, activityContext, true);
                }
                Workflow_TypedDataContext4 refDataContext6 = ((Workflow_TypedDataContext4)(cachedCompiledDataContext[2]));
                return refDataContext6.GetLocation<Microsoft.Activities.DynamicValue>(refDataContext6.ValueType___Expr6Get, refDataContext6.ValueType___Expr6Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 7)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[1] == null)) {
                    cachedCompiledDataContext[1] = new Workflow_TypedDataContext4_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext4_ForReadOnly valDataContext7 = ((Workflow_TypedDataContext4_ForReadOnly)(cachedCompiledDataContext[1]));
                return valDataContext7.ValueType___Expr7Get();
            }
            if ((expressionId == 8)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[1] == null)) {
                    cachedCompiledDataContext[1] = new Workflow_TypedDataContext4_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext4_ForReadOnly valDataContext8 = ((Workflow_TypedDataContext4_ForReadOnly)(cachedCompiledDataContext[1]));
                return valDataContext8.ValueType___Expr8Get();
            }
            if ((expressionId == 9)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext4.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[2] == null)) {
                    cachedCompiledDataContext[2] = new Workflow_TypedDataContext4(locations, activityContext, true);
                }
                Workflow_TypedDataContext4 refDataContext9 = ((Workflow_TypedDataContext4)(cachedCompiledDataContext[2]));
                return refDataContext9.GetLocation<int>(refDataContext9.ValueType___Expr9Get, refDataContext9.ValueType___Expr9Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 10)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext3_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[3] == null)) {
                    cachedCompiledDataContext[3] = new Workflow_TypedDataContext3_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext3_ForReadOnly valDataContext10 = ((Workflow_TypedDataContext3_ForReadOnly)(cachedCompiledDataContext[3]));
                return valDataContext10.ValueType___Expr10Get();
            }
            if ((expressionId == 11)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext3.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[4] == null)) {
                    cachedCompiledDataContext[4] = new Workflow_TypedDataContext3(locations, activityContext, true);
                }
                Workflow_TypedDataContext3 refDataContext11 = ((Workflow_TypedDataContext3)(cachedCompiledDataContext[4]));
                return refDataContext11.GetLocation<int>(refDataContext11.ValueType___Expr11Get, refDataContext11.ValueType___Expr11Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 12)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext3_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[3] == null)) {
                    cachedCompiledDataContext[3] = new Workflow_TypedDataContext3_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext3_ForReadOnly valDataContext12 = ((Workflow_TypedDataContext3_ForReadOnly)(cachedCompiledDataContext[3]));
                return valDataContext12.ValueType___Expr12Get();
            }
            if ((expressionId == 13)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext3.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[4] == null)) {
                    cachedCompiledDataContext[4] = new Workflow_TypedDataContext3(locations, activityContext, true);
                }
                Workflow_TypedDataContext3 refDataContext13 = ((Workflow_TypedDataContext3)(cachedCompiledDataContext[4]));
                return refDataContext13.GetLocation<System.DateTime>(refDataContext13.ValueType___Expr13Get, refDataContext13.ValueType___Expr13Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 14)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[5] == null)) {
                    cachedCompiledDataContext[5] = new Workflow_TypedDataContext2_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext2_ForReadOnly valDataContext14 = ((Workflow_TypedDataContext2_ForReadOnly)(cachedCompiledDataContext[5]));
                return valDataContext14.ValueType___Expr14Get();
            }
            if ((expressionId == 15)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[0] == null)) {
                    cachedCompiledDataContext[0] = new Workflow_TypedDataContext2(locations, activityContext, true);
                }
                Workflow_TypedDataContext2 refDataContext15 = ((Workflow_TypedDataContext2)(cachedCompiledDataContext[0]));
                return refDataContext15.GetLocation<Microsoft.Activities.DynamicValue>(refDataContext15.ValueType___Expr15Get, refDataContext15.ValueType___Expr15Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 16)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[0] == null)) {
                    cachedCompiledDataContext[0] = new Workflow_TypedDataContext2(locations, activityContext, true);
                }
                Workflow_TypedDataContext2 refDataContext16 = ((Workflow_TypedDataContext2)(cachedCompiledDataContext[0]));
                return refDataContext16.GetLocation<Microsoft.Activities.DynamicValue>(refDataContext16.ValueType___Expr16Get, refDataContext16.ValueType___Expr16Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 17)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[5] == null)) {
                    cachedCompiledDataContext[5] = new Workflow_TypedDataContext2_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext2_ForReadOnly valDataContext17 = ((Workflow_TypedDataContext2_ForReadOnly)(cachedCompiledDataContext[5]));
                return valDataContext17.ValueType___Expr17Get();
            }
            if ((expressionId == 18)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[0] == null)) {
                    cachedCompiledDataContext[0] = new Workflow_TypedDataContext2(locations, activityContext, true);
                }
                Workflow_TypedDataContext2 refDataContext18 = ((Workflow_TypedDataContext2)(cachedCompiledDataContext[0]));
                return refDataContext18.GetLocation<int>(refDataContext18.ValueType___Expr18Get, refDataContext18.ValueType___Expr18Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 19)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[5] == null)) {
                    cachedCompiledDataContext[5] = new Workflow_TypedDataContext2_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext2_ForReadOnly valDataContext19 = ((Workflow_TypedDataContext2_ForReadOnly)(cachedCompiledDataContext[5]));
                return valDataContext19.ValueType___Expr19Get();
            }
            if ((expressionId == 20)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[5] == null)) {
                    cachedCompiledDataContext[5] = new Workflow_TypedDataContext2_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext2_ForReadOnly valDataContext20 = ((Workflow_TypedDataContext2_ForReadOnly)(cachedCompiledDataContext[5]));
                return valDataContext20.ValueType___Expr20Get();
            }
            if ((expressionId == 21)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext2.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[0] == null)) {
                    cachedCompiledDataContext[0] = new Workflow_TypedDataContext2(locations, activityContext, true);
                }
                Workflow_TypedDataContext2 refDataContext21 = ((Workflow_TypedDataContext2)(cachedCompiledDataContext[0]));
                return refDataContext21.GetLocation<int>(refDataContext21.ValueType___Expr21Get, refDataContext21.ValueType___Expr21Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 22)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[6] == null)) {
                    cachedCompiledDataContext[6] = new Workflow_TypedDataContext5(locations, activityContext, true);
                }
                Workflow_TypedDataContext5 refDataContext22 = ((Workflow_TypedDataContext5)(cachedCompiledDataContext[6]));
                return refDataContext22.GetLocation<int>(refDataContext22.ValueType___Expr22Get, refDataContext22.ValueType___Expr22Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 23)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[7] == null)) {
                    cachedCompiledDataContext[7] = new Workflow_TypedDataContext5_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext5_ForReadOnly valDataContext23 = ((Workflow_TypedDataContext5_ForReadOnly)(cachedCompiledDataContext[7]));
                return valDataContext23.ValueType___Expr23Get();
            }
            if ((expressionId == 24)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[7] == null)) {
                    cachedCompiledDataContext[7] = new Workflow_TypedDataContext5_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext5_ForReadOnly valDataContext24 = ((Workflow_TypedDataContext5_ForReadOnly)(cachedCompiledDataContext[7]));
                return valDataContext24.ValueType___Expr24Get();
            }
            if ((expressionId == 25)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[7] == null)) {
                    cachedCompiledDataContext[7] = new Workflow_TypedDataContext5_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext5_ForReadOnly valDataContext25 = ((Workflow_TypedDataContext5_ForReadOnly)(cachedCompiledDataContext[7]));
                return valDataContext25.ValueType___Expr25Get();
            }
            if ((expressionId == 26)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[7] == null)) {
                    cachedCompiledDataContext[7] = new Workflow_TypedDataContext5_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext5_ForReadOnly valDataContext26 = ((Workflow_TypedDataContext5_ForReadOnly)(cachedCompiledDataContext[7]));
                return valDataContext26.ValueType___Expr26Get();
            }
            if ((expressionId == 27)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[7] == null)) {
                    cachedCompiledDataContext[7] = new Workflow_TypedDataContext5_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext5_ForReadOnly valDataContext27 = ((Workflow_TypedDataContext5_ForReadOnly)(cachedCompiledDataContext[7]));
                return valDataContext27.ValueType___Expr27Get();
            }
            if ((expressionId == 28)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[6] == null)) {
                    cachedCompiledDataContext[6] = new Workflow_TypedDataContext5(locations, activityContext, true);
                }
                Workflow_TypedDataContext5 refDataContext28 = ((Workflow_TypedDataContext5)(cachedCompiledDataContext[6]));
                return refDataContext28.GetLocation<int>(refDataContext28.ValueType___Expr28Get, refDataContext28.ValueType___Expr28Set, expressionId, this.rootActivity, activityContext);
            }
            if ((expressionId == 29)) {
                System.Activities.XamlIntegration.CompiledDataContext[] cachedCompiledDataContext = Workflow_TypedDataContext5_ForReadOnly.GetCompiledDataContextCacheHelper(this.dataContextActivities, activityContext, this.rootActivity, this.forImplementation, 8);
                if ((cachedCompiledDataContext[7] == null)) {
                    cachedCompiledDataContext[7] = new Workflow_TypedDataContext5_ForReadOnly(locations, activityContext, true);
                }
                Workflow_TypedDataContext5_ForReadOnly valDataContext29 = ((Workflow_TypedDataContext5_ForReadOnly)(cachedCompiledDataContext[7]));
                return valDataContext29.ValueType___Expr29Get();
            }
            return null;
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        public object InvokeExpression(int expressionId, System.Collections.Generic.IList<System.Activities.Location> locations) {
            if ((this.rootActivity == null)) {
                this.rootActivity = this;
            }
            if ((expressionId == 0)) {
                Workflow_TypedDataContext2 refDataContext0 = new Workflow_TypedDataContext2(locations, true);
                return refDataContext0.GetLocation<string>(refDataContext0.ValueType___Expr0Get, refDataContext0.ValueType___Expr0Set);
            }
            if ((expressionId == 1)) {
                Workflow_TypedDataContext4_ForReadOnly valDataContext1 = new Workflow_TypedDataContext4_ForReadOnly(locations, true);
                return valDataContext1.ValueType___Expr1Get();
            }
            if ((expressionId == 2)) {
                Workflow_TypedDataContext4 refDataContext2 = new Workflow_TypedDataContext4(locations, true);
                return refDataContext2.GetLocation<int>(refDataContext2.ValueType___Expr2Get, refDataContext2.ValueType___Expr2Set);
            }
            if ((expressionId == 3)) {
                Workflow_TypedDataContext4_ForReadOnly valDataContext3 = new Workflow_TypedDataContext4_ForReadOnly(locations, true);
                return valDataContext3.ValueType___Expr3Get();
            }
            if ((expressionId == 4)) {
                Workflow_TypedDataContext4_ForReadOnly valDataContext4 = new Workflow_TypedDataContext4_ForReadOnly(locations, true);
                return valDataContext4.ValueType___Expr4Get();
            }
            if ((expressionId == 5)) {
                Workflow_TypedDataContext4_ForReadOnly valDataContext5 = new Workflow_TypedDataContext4_ForReadOnly(locations, true);
                return valDataContext5.ValueType___Expr5Get();
            }
            if ((expressionId == 6)) {
                Workflow_TypedDataContext4 refDataContext6 = new Workflow_TypedDataContext4(locations, true);
                return refDataContext6.GetLocation<Microsoft.Activities.DynamicValue>(refDataContext6.ValueType___Expr6Get, refDataContext6.ValueType___Expr6Set);
            }
            if ((expressionId == 7)) {
                Workflow_TypedDataContext4_ForReadOnly valDataContext7 = new Workflow_TypedDataContext4_ForReadOnly(locations, true);
                return valDataContext7.ValueType___Expr7Get();
            }
            if ((expressionId == 8)) {
                Workflow_TypedDataContext4_ForReadOnly valDataContext8 = new Workflow_TypedDataContext4_ForReadOnly(locations, true);
                return valDataContext8.ValueType___Expr8Get();
            }
            if ((expressionId == 9)) {
                Workflow_TypedDataContext4 refDataContext9 = new Workflow_TypedDataContext4(locations, true);
                return refDataContext9.GetLocation<int>(refDataContext9.ValueType___Expr9Get, refDataContext9.ValueType___Expr9Set);
            }
            if ((expressionId == 10)) {
                Workflow_TypedDataContext3_ForReadOnly valDataContext10 = new Workflow_TypedDataContext3_ForReadOnly(locations, true);
                return valDataContext10.ValueType___Expr10Get();
            }
            if ((expressionId == 11)) {
                Workflow_TypedDataContext3 refDataContext11 = new Workflow_TypedDataContext3(locations, true);
                return refDataContext11.GetLocation<int>(refDataContext11.ValueType___Expr11Get, refDataContext11.ValueType___Expr11Set);
            }
            if ((expressionId == 12)) {
                Workflow_TypedDataContext3_ForReadOnly valDataContext12 = new Workflow_TypedDataContext3_ForReadOnly(locations, true);
                return valDataContext12.ValueType___Expr12Get();
            }
            if ((expressionId == 13)) {
                Workflow_TypedDataContext3 refDataContext13 = new Workflow_TypedDataContext3(locations, true);
                return refDataContext13.GetLocation<System.DateTime>(refDataContext13.ValueType___Expr13Get, refDataContext13.ValueType___Expr13Set);
            }
            if ((expressionId == 14)) {
                Workflow_TypedDataContext2_ForReadOnly valDataContext14 = new Workflow_TypedDataContext2_ForReadOnly(locations, true);
                return valDataContext14.ValueType___Expr14Get();
            }
            if ((expressionId == 15)) {
                Workflow_TypedDataContext2 refDataContext15 = new Workflow_TypedDataContext2(locations, true);
                return refDataContext15.GetLocation<Microsoft.Activities.DynamicValue>(refDataContext15.ValueType___Expr15Get, refDataContext15.ValueType___Expr15Set);
            }
            if ((expressionId == 16)) {
                Workflow_TypedDataContext2 refDataContext16 = new Workflow_TypedDataContext2(locations, true);
                return refDataContext16.GetLocation<Microsoft.Activities.DynamicValue>(refDataContext16.ValueType___Expr16Get, refDataContext16.ValueType___Expr16Set);
            }
            if ((expressionId == 17)) {
                Workflow_TypedDataContext2_ForReadOnly valDataContext17 = new Workflow_TypedDataContext2_ForReadOnly(locations, true);
                return valDataContext17.ValueType___Expr17Get();
            }
            if ((expressionId == 18)) {
                Workflow_TypedDataContext2 refDataContext18 = new Workflow_TypedDataContext2(locations, true);
                return refDataContext18.GetLocation<int>(refDataContext18.ValueType___Expr18Get, refDataContext18.ValueType___Expr18Set);
            }
            if ((expressionId == 19)) {
                Workflow_TypedDataContext2_ForReadOnly valDataContext19 = new Workflow_TypedDataContext2_ForReadOnly(locations, true);
                return valDataContext19.ValueType___Expr19Get();
            }
            if ((expressionId == 20)) {
                Workflow_TypedDataContext2_ForReadOnly valDataContext20 = new Workflow_TypedDataContext2_ForReadOnly(locations, true);
                return valDataContext20.ValueType___Expr20Get();
            }
            if ((expressionId == 21)) {
                Workflow_TypedDataContext2 refDataContext21 = new Workflow_TypedDataContext2(locations, true);
                return refDataContext21.GetLocation<int>(refDataContext21.ValueType___Expr21Get, refDataContext21.ValueType___Expr21Set);
            }
            if ((expressionId == 22)) {
                Workflow_TypedDataContext5 refDataContext22 = new Workflow_TypedDataContext5(locations, true);
                return refDataContext22.GetLocation<int>(refDataContext22.ValueType___Expr22Get, refDataContext22.ValueType___Expr22Set);
            }
            if ((expressionId == 23)) {
                Workflow_TypedDataContext5_ForReadOnly valDataContext23 = new Workflow_TypedDataContext5_ForReadOnly(locations, true);
                return valDataContext23.ValueType___Expr23Get();
            }
            if ((expressionId == 24)) {
                Workflow_TypedDataContext5_ForReadOnly valDataContext24 = new Workflow_TypedDataContext5_ForReadOnly(locations, true);
                return valDataContext24.ValueType___Expr24Get();
            }
            if ((expressionId == 25)) {
                Workflow_TypedDataContext5_ForReadOnly valDataContext25 = new Workflow_TypedDataContext5_ForReadOnly(locations, true);
                return valDataContext25.ValueType___Expr25Get();
            }
            if ((expressionId == 26)) {
                Workflow_TypedDataContext5_ForReadOnly valDataContext26 = new Workflow_TypedDataContext5_ForReadOnly(locations, true);
                return valDataContext26.ValueType___Expr26Get();
            }
            if ((expressionId == 27)) {
                Workflow_TypedDataContext5_ForReadOnly valDataContext27 = new Workflow_TypedDataContext5_ForReadOnly(locations, true);
                return valDataContext27.ValueType___Expr27Get();
            }
            if ((expressionId == 28)) {
                Workflow_TypedDataContext5 refDataContext28 = new Workflow_TypedDataContext5(locations, true);
                return refDataContext28.GetLocation<int>(refDataContext28.ValueType___Expr28Get, refDataContext28.ValueType___Expr28Set);
            }
            if ((expressionId == 29)) {
                Workflow_TypedDataContext5_ForReadOnly valDataContext29 = new Workflow_TypedDataContext5_ForReadOnly(locations, true);
                return valDataContext29.ValueType___Expr29Get();
            }
            return null;
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        public bool CanExecuteExpression(string expressionText, bool isReference, System.Collections.Generic.IList<System.Activities.LocationReference> locations, out int expressionId) {
            if (((isReference == true) 
                        && ((expressionText == "webUrl") 
                        && (Workflow_TypedDataContext2.Validate(locations, true, 0) == true)))) {
                expressionId = 0;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "System.Guid.Parse(\"{$ListId:Lists/TARSettings;}\")") 
                        && (Workflow_TypedDataContext4_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 1;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "itemId") 
                        && (Workflow_TypedDataContext4.Validate(locations, true, 0) == true)))) {
                expressionId = 2;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "\"Title\"") 
                        && (Workflow_TypedDataContext4_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 3;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "itemId < 1") 
                        && (Workflow_TypedDataContext4_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 4;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "System.Guid.Parse(\"{$ListId:Lists/TARSettings;}\")") 
                        && (Workflow_TypedDataContext4_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 5;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "dynamicValue") 
                        && (Workflow_TypedDataContext4.Validate(locations, true, 0) == true)))) {
                expressionId = 6;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "itemId") 
                        && (Workflow_TypedDataContext4_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 7;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "dynamicValue") 
                        && (Workflow_TypedDataContext4_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 8;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "daysThreshold") 
                        && (Workflow_TypedDataContext4.Validate(locations, true, 0) == true)))) {
                expressionId = 9;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "0 - daysThreshold;") 
                        && (Workflow_TypedDataContext3_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 10;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "daysThreshold") 
                        && (Workflow_TypedDataContext3.Validate(locations, true, 0) == true)))) {
                expressionId = 11;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "DateTime.UtcNow.AddDays(daysThreshold);") 
                        && (Workflow_TypedDataContext3_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 12;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "dateThreshold") 
                        && (Workflow_TypedDataContext3.Validate(locations, true, 0) == true)))) {
                expressionId = 13;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "string.Format(\"{0}/_api/Lists/getByTitle(\'EIF Requests\')/items?$filter=Created lt" +
                            " datetime\'{1}\'\", webUrl, dateThreshold.ToString(\"s\"));") 
                        && (Workflow_TypedDataContext2_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 14;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "restResponse") 
                        && (Workflow_TypedDataContext2.Validate(locations, true, 0) == true)))) {
                expressionId = 15;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "restResponse") 
                        && (Workflow_TypedDataContext2.Validate(locations, true, 0) == true)))) {
                expressionId = 16;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "restResponse") 
                        && (Workflow_TypedDataContext2_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 17;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "itemsCount") 
                        && (Workflow_TypedDataContext2.Validate(locations, true, 0) == true)))) {
                expressionId = 18;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "restResponse") 
                        && (Workflow_TypedDataContext2_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 19;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "0;") 
                        && (Workflow_TypedDataContext2_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 20;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "index") 
                        && (Workflow_TypedDataContext2.Validate(locations, true, 0) == true)))) {
                expressionId = 21;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "eifId") 
                        && (Workflow_TypedDataContext5.Validate(locations, true, 0) == true)))) {
                expressionId = 22;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "restResponse") 
                        && (Workflow_TypedDataContext5_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 23;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "string.Format(\"({0})/Id\", index);") 
                        && (Workflow_TypedDataContext5_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 24;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "System.Guid.Parse(\"{$ListId:Lists/EIFRequests;}\")") 
                        && (Workflow_TypedDataContext5_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 25;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "eifId") 
                        && (Workflow_TypedDataContext5_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 26;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "index + 1;") 
                        && (Workflow_TypedDataContext5_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 27;
                return true;
            }
            if (((isReference == true) 
                        && ((expressionText == "index") 
                        && (Workflow_TypedDataContext5.Validate(locations, true, 0) == true)))) {
                expressionId = 28;
                return true;
            }
            if (((isReference == false) 
                        && ((expressionText == "index < itemsCount") 
                        && (Workflow_TypedDataContext5_ForReadOnly.Validate(locations, true, 0) == true)))) {
                expressionId = 29;
                return true;
            }
            expressionId = -1;
            return false;
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        public System.Collections.Generic.IList<string> GetRequiredLocations(int expressionId) {
            return null;
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        public System.Linq.Expressions.Expression GetExpressionTreeForExpression(int expressionId, System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) {
            if ((expressionId == 0)) {
                return new Workflow_TypedDataContext2(locationReferences).@__Expr0GetTree();
            }
            if ((expressionId == 1)) {
                return new Workflow_TypedDataContext4_ForReadOnly(locationReferences).@__Expr1GetTree();
            }
            if ((expressionId == 2)) {
                return new Workflow_TypedDataContext4(locationReferences).@__Expr2GetTree();
            }
            if ((expressionId == 3)) {
                return new Workflow_TypedDataContext4_ForReadOnly(locationReferences).@__Expr3GetTree();
            }
            if ((expressionId == 4)) {
                return new Workflow_TypedDataContext4_ForReadOnly(locationReferences).@__Expr4GetTree();
            }
            if ((expressionId == 5)) {
                return new Workflow_TypedDataContext4_ForReadOnly(locationReferences).@__Expr5GetTree();
            }
            if ((expressionId == 6)) {
                return new Workflow_TypedDataContext4(locationReferences).@__Expr6GetTree();
            }
            if ((expressionId == 7)) {
                return new Workflow_TypedDataContext4_ForReadOnly(locationReferences).@__Expr7GetTree();
            }
            if ((expressionId == 8)) {
                return new Workflow_TypedDataContext4_ForReadOnly(locationReferences).@__Expr8GetTree();
            }
            if ((expressionId == 9)) {
                return new Workflow_TypedDataContext4(locationReferences).@__Expr9GetTree();
            }
            if ((expressionId == 10)) {
                return new Workflow_TypedDataContext3_ForReadOnly(locationReferences).@__Expr10GetTree();
            }
            if ((expressionId == 11)) {
                return new Workflow_TypedDataContext3(locationReferences).@__Expr11GetTree();
            }
            if ((expressionId == 12)) {
                return new Workflow_TypedDataContext3_ForReadOnly(locationReferences).@__Expr12GetTree();
            }
            if ((expressionId == 13)) {
                return new Workflow_TypedDataContext3(locationReferences).@__Expr13GetTree();
            }
            if ((expressionId == 14)) {
                return new Workflow_TypedDataContext2_ForReadOnly(locationReferences).@__Expr14GetTree();
            }
            if ((expressionId == 15)) {
                return new Workflow_TypedDataContext2(locationReferences).@__Expr15GetTree();
            }
            if ((expressionId == 16)) {
                return new Workflow_TypedDataContext2(locationReferences).@__Expr16GetTree();
            }
            if ((expressionId == 17)) {
                return new Workflow_TypedDataContext2_ForReadOnly(locationReferences).@__Expr17GetTree();
            }
            if ((expressionId == 18)) {
                return new Workflow_TypedDataContext2(locationReferences).@__Expr18GetTree();
            }
            if ((expressionId == 19)) {
                return new Workflow_TypedDataContext2_ForReadOnly(locationReferences).@__Expr19GetTree();
            }
            if ((expressionId == 20)) {
                return new Workflow_TypedDataContext2_ForReadOnly(locationReferences).@__Expr20GetTree();
            }
            if ((expressionId == 21)) {
                return new Workflow_TypedDataContext2(locationReferences).@__Expr21GetTree();
            }
            if ((expressionId == 22)) {
                return new Workflow_TypedDataContext5(locationReferences).@__Expr22GetTree();
            }
            if ((expressionId == 23)) {
                return new Workflow_TypedDataContext5_ForReadOnly(locationReferences).@__Expr23GetTree();
            }
            if ((expressionId == 24)) {
                return new Workflow_TypedDataContext5_ForReadOnly(locationReferences).@__Expr24GetTree();
            }
            if ((expressionId == 25)) {
                return new Workflow_TypedDataContext5_ForReadOnly(locationReferences).@__Expr25GetTree();
            }
            if ((expressionId == 26)) {
                return new Workflow_TypedDataContext5_ForReadOnly(locationReferences).@__Expr26GetTree();
            }
            if ((expressionId == 27)) {
                return new Workflow_TypedDataContext5_ForReadOnly(locationReferences).@__Expr27GetTree();
            }
            if ((expressionId == 28)) {
                return new Workflow_TypedDataContext5(locationReferences).@__Expr28GetTree();
            }
            if ((expressionId == 29)) {
                return new Workflow_TypedDataContext5_ForReadOnly(locationReferences).@__Expr29GetTree();
            }
            return null;
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext0 : System.Activities.XamlIntegration.CompiledDataContext {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            public Workflow_TypedDataContext0(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext0(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext0(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal static object GetDataContextActivitiesHelper(System.Activities.Activity compiledRoot, bool forImplementation) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetDataContextActivities(compiledRoot, forImplementation);
            }
            
            internal static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
            }
            
            public static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 0))) {
                    return false;
                }
                expectedLocationsCount = 0;
                return true;
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext0_ForReadOnly : System.Activities.XamlIntegration.CompiledDataContext {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            public Workflow_TypedDataContext0_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext0_ForReadOnly(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext0_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal static object GetDataContextActivitiesHelper(System.Activities.Activity compiledRoot, bool forImplementation) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetDataContextActivities(compiledRoot, forImplementation);
            }
            
            internal static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
            }
            
            public static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 0))) {
                    return false;
                }
                expectedLocationsCount = 0;
                return true;
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext1 : Workflow_TypedDataContext0 {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            public Workflow_TypedDataContext1(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext1(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext1(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 0))) {
                    return false;
                }
                expectedLocationsCount = 0;
                return Workflow_TypedDataContext0.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext1_ForReadOnly : Workflow_TypedDataContext0_ForReadOnly {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            public Workflow_TypedDataContext1_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext1_ForReadOnly(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext1_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 0))) {
                    return false;
                }
                expectedLocationsCount = 0;
                return Workflow_TypedDataContext0_ForReadOnly.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext2 : Workflow_TypedDataContext1 {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected System.DateTime dateThreshold;
            
            protected int itemsCount;
            
            protected int index;
            
            public Workflow_TypedDataContext2(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext2(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext2(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            protected string webUrl {
                get {
                    return ((string)(this.GetVariableValue((0 + locationsOffset))));
                }
                set {
                    this.SetVariableValue((0 + locationsOffset), value);
                }
            }
            
            protected Microsoft.Activities.DynamicValue restResponse {
                get {
                    return ((Microsoft.Activities.DynamicValue)(this.GetVariableValue((2 + locationsOffset))));
                }
                set {
                    this.SetVariableValue((2 + locationsOffset), value);
                }
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr0GetTree() {
                
                #line 59 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<string>> expression = () => 
          webUrl;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public string @__Expr0Get() {
                
                #line 59 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          webUrl;
                
                #line default
                #line hidden
            }
            
            public string ValueType___Expr0Get() {
                this.GetValueTypeValues();
                return this.@__Expr0Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr0Set(string value) {
                
                #line 59 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
          webUrl = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr0Set(string value) {
                this.GetValueTypeValues();
                this.@__Expr0Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr15GetTree() {
                
                #line 169 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<Microsoft.Activities.DynamicValue>> expression = () => 
          restResponse;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public Microsoft.Activities.DynamicValue @__Expr15Get() {
                
                #line 169 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          restResponse;
                
                #line default
                #line hidden
            }
            
            public Microsoft.Activities.DynamicValue ValueType___Expr15Get() {
                this.GetValueTypeValues();
                return this.@__Expr15Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr15Set(Microsoft.Activities.DynamicValue value) {
                
                #line 169 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
          restResponse = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr15Set(Microsoft.Activities.DynamicValue value) {
                this.GetValueTypeValues();
                this.@__Expr15Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr16GetTree() {
                
                #line 181 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<Microsoft.Activities.DynamicValue>> expression = () => 
          restResponse;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public Microsoft.Activities.DynamicValue @__Expr16Get() {
                
                #line 181 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          restResponse;
                
                #line default
                #line hidden
            }
            
            public Microsoft.Activities.DynamicValue ValueType___Expr16Get() {
                this.GetValueTypeValues();
                return this.@__Expr16Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr16Set(Microsoft.Activities.DynamicValue value) {
                
                #line 181 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
          restResponse = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr16Set(Microsoft.Activities.DynamicValue value) {
                this.GetValueTypeValues();
                this.@__Expr16Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr18GetTree() {
                
                #line 193 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
          itemsCount;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr18Get() {
                
                #line 193 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          itemsCount;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr18Get() {
                this.GetValueTypeValues();
                return this.@__Expr18Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr18Set(int value) {
                
                #line 193 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
          itemsCount = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr18Set(int value) {
                this.GetValueTypeValues();
                this.@__Expr18Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr21GetTree() {
                
                #line 203 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
          index;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr21Get() {
                
                #line 203 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          index;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr21Get() {
                this.GetValueTypeValues();
                return this.@__Expr21Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr21Set(int value) {
                
                #line 203 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
          index = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr21Set(int value) {
                this.GetValueTypeValues();
                this.@__Expr21Set(value);
                this.SetValueTypeValues();
            }
            
            protected override void GetValueTypeValues() {
                this.dateThreshold = ((System.DateTime)(this.GetVariableValue((1 + locationsOffset))));
                this.itemsCount = ((int)(this.GetVariableValue((3 + locationsOffset))));
                this.index = ((int)(this.GetVariableValue((4 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            protected override void SetValueTypeValues() {
                this.SetVariableValue((1 + locationsOffset), this.dateThreshold);
                this.SetVariableValue((3 + locationsOffset), this.itemsCount);
                this.SetVariableValue((4 + locationsOffset), this.index);
                base.SetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 5))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 5);
                }
                expectedLocationsCount = 5;
                if (((locationReferences[(offset + 0)].Name != "webUrl") 
                            || (locationReferences[(offset + 0)].Type != typeof(string)))) {
                    return false;
                }
                if (((locationReferences[(offset + 2)].Name != "restResponse") 
                            || (locationReferences[(offset + 2)].Type != typeof(Microsoft.Activities.DynamicValue)))) {
                    return false;
                }
                if (((locationReferences[(offset + 1)].Name != "dateThreshold") 
                            || (locationReferences[(offset + 1)].Type != typeof(System.DateTime)))) {
                    return false;
                }
                if (((locationReferences[(offset + 3)].Name != "itemsCount") 
                            || (locationReferences[(offset + 3)].Type != typeof(int)))) {
                    return false;
                }
                if (((locationReferences[(offset + 4)].Name != "index") 
                            || (locationReferences[(offset + 4)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext1.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext2_ForReadOnly : Workflow_TypedDataContext1_ForReadOnly {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected System.DateTime dateThreshold;
            
            protected int itemsCount;
            
            protected int index;
            
            public Workflow_TypedDataContext2_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext2_ForReadOnly(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext2_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            protected string webUrl {
                get {
                    return ((string)(this.GetVariableValue((0 + locationsOffset))));
                }
            }
            
            protected Microsoft.Activities.DynamicValue restResponse {
                get {
                    return ((Microsoft.Activities.DynamicValue)(this.GetVariableValue((2 + locationsOffset))));
                }
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr14GetTree() {
                
                #line 174 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<string>> expression = () => 
          string.Format("{0}/_api/Lists/getByTitle('EIF Requests')/items?$filter=Created lt datetime'{1}'", webUrl, dateThreshold.ToString("s"));;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public string @__Expr14Get() {
                
                #line 174 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          string.Format("{0}/_api/Lists/getByTitle('EIF Requests')/items?$filter=Created lt datetime'{1}'", webUrl, dateThreshold.ToString("s"));;
                
                #line default
                #line hidden
            }
            
            public string ValueType___Expr14Get() {
                this.GetValueTypeValues();
                return this.@__Expr14Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr17GetTree() {
                
                #line 186 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<Microsoft.Activities.DynamicValue>> expression = () => 
          restResponse;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public Microsoft.Activities.DynamicValue @__Expr17Get() {
                
                #line 186 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          restResponse;
                
                #line default
                #line hidden
            }
            
            public Microsoft.Activities.DynamicValue ValueType___Expr17Get() {
                this.GetValueTypeValues();
                return this.@__Expr17Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr19GetTree() {
                
                #line 197 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<Microsoft.Activities.DynamicValue>> expression = () => 
        restResponse;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public Microsoft.Activities.DynamicValue @__Expr19Get() {
                
                #line 197 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
        restResponse;
                
                #line default
                #line hidden
            }
            
            public Microsoft.Activities.DynamicValue ValueType___Expr19Get() {
                this.GetValueTypeValues();
                return this.@__Expr19Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr20GetTree() {
                
                #line 208 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
          0;;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr20Get() {
                
                #line 208 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
          0;;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr20Get() {
                this.GetValueTypeValues();
                return this.@__Expr20Get();
            }
            
            protected override void GetValueTypeValues() {
                this.dateThreshold = ((System.DateTime)(this.GetVariableValue((1 + locationsOffset))));
                this.itemsCount = ((int)(this.GetVariableValue((3 + locationsOffset))));
                this.index = ((int)(this.GetVariableValue((4 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 5))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 5);
                }
                expectedLocationsCount = 5;
                if (((locationReferences[(offset + 0)].Name != "webUrl") 
                            || (locationReferences[(offset + 0)].Type != typeof(string)))) {
                    return false;
                }
                if (((locationReferences[(offset + 2)].Name != "restResponse") 
                            || (locationReferences[(offset + 2)].Type != typeof(Microsoft.Activities.DynamicValue)))) {
                    return false;
                }
                if (((locationReferences[(offset + 1)].Name != "dateThreshold") 
                            || (locationReferences[(offset + 1)].Type != typeof(System.DateTime)))) {
                    return false;
                }
                if (((locationReferences[(offset + 3)].Name != "itemsCount") 
                            || (locationReferences[(offset + 3)].Type != typeof(int)))) {
                    return false;
                }
                if (((locationReferences[(offset + 4)].Name != "index") 
                            || (locationReferences[(offset + 4)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext1_ForReadOnly.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext3 : Workflow_TypedDataContext2 {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected int daysThreshold;
            
            public Workflow_TypedDataContext3(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext3(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext3(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr11GetTree() {
                
                #line 135 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
            daysThreshold;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr11Get() {
                
                #line 135 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
            daysThreshold;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr11Get() {
                this.GetValueTypeValues();
                return this.@__Expr11Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr11Set(int value) {
                
                #line 135 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
            daysThreshold = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr11Set(int value) {
                this.GetValueTypeValues();
                this.@__Expr11Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr13GetTree() {
                
                #line 147 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<System.DateTime>> expression = () => 
            dateThreshold;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public System.DateTime @__Expr13Get() {
                
                #line 147 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
            dateThreshold;
                
                #line default
                #line hidden
            }
            
            public System.DateTime ValueType___Expr13Get() {
                this.GetValueTypeValues();
                return this.@__Expr13Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr13Set(System.DateTime value) {
                
                #line 147 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
            dateThreshold = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr13Set(System.DateTime value) {
                this.GetValueTypeValues();
                this.@__Expr13Set(value);
                this.SetValueTypeValues();
            }
            
            protected override void GetValueTypeValues() {
                this.daysThreshold = ((int)(this.GetVariableValue((5 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            protected override void SetValueTypeValues() {
                this.SetVariableValue((5 + locationsOffset), this.daysThreshold);
                base.SetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 6))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 6);
                }
                expectedLocationsCount = 6;
                if (((locationReferences[(offset + 5)].Name != "daysThreshold") 
                            || (locationReferences[(offset + 5)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext2.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext3_ForReadOnly : Workflow_TypedDataContext2_ForReadOnly {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected int daysThreshold;
            
            public Workflow_TypedDataContext3_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext3_ForReadOnly(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext3_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr10GetTree() {
                
                #line 140 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
            0 - daysThreshold;;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr10Get() {
                
                #line 140 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
            0 - daysThreshold;;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr10Get() {
                this.GetValueTypeValues();
                return this.@__Expr10Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr12GetTree() {
                
                #line 152 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<System.DateTime>> expression = () => 
            DateTime.UtcNow.AddDays(daysThreshold);;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public System.DateTime @__Expr12Get() {
                
                #line 152 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
            DateTime.UtcNow.AddDays(daysThreshold);;
                
                #line default
                #line hidden
            }
            
            public System.DateTime ValueType___Expr12Get() {
                this.GetValueTypeValues();
                return this.@__Expr12Get();
            }
            
            protected override void GetValueTypeValues() {
                this.daysThreshold = ((int)(this.GetVariableValue((5 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 6))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 6);
                }
                expectedLocationsCount = 6;
                if (((locationReferences[(offset + 5)].Name != "daysThreshold") 
                            || (locationReferences[(offset + 5)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext2_ForReadOnly.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext4 : Workflow_TypedDataContext3 {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected int itemId;
            
            public Workflow_TypedDataContext4(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext4(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext4(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            protected Microsoft.Activities.DynamicValue dynamicValue {
                get {
                    return ((Microsoft.Activities.DynamicValue)(this.GetVariableValue((7 + locationsOffset))));
                }
                set {
                    this.SetVariableValue((7 + locationsOffset), value);
                }
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr2GetTree() {
                
                #line 85 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
              itemId;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr2Get() {
                
                #line 85 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              itemId;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr2Get() {
                this.GetValueTypeValues();
                return this.@__Expr2Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr2Set(int value) {
                
                #line 85 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
              itemId = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr2Set(int value) {
                this.GetValueTypeValues();
                this.@__Expr2Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr6GetTree() {
                
                #line 115 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<Microsoft.Activities.DynamicValue>> expression = () => 
              dynamicValue;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public Microsoft.Activities.DynamicValue @__Expr6Get() {
                
                #line 115 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              dynamicValue;
                
                #line default
                #line hidden
            }
            
            public Microsoft.Activities.DynamicValue ValueType___Expr6Get() {
                this.GetValueTypeValues();
                return this.@__Expr6Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr6Set(Microsoft.Activities.DynamicValue value) {
                
                #line 115 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
              dynamicValue = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr6Set(Microsoft.Activities.DynamicValue value) {
                this.GetValueTypeValues();
                this.@__Expr6Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr9GetTree() {
                
                #line 127 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
              daysThreshold;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr9Get() {
                
                #line 127 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              daysThreshold;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr9Get() {
                this.GetValueTypeValues();
                return this.@__Expr9Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr9Set(int value) {
                
                #line 127 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
              daysThreshold = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr9Set(int value) {
                this.GetValueTypeValues();
                this.@__Expr9Set(value);
                this.SetValueTypeValues();
            }
            
            protected override void GetValueTypeValues() {
                this.itemId = ((int)(this.GetVariableValue((6 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            protected override void SetValueTypeValues() {
                this.SetVariableValue((6 + locationsOffset), this.itemId);
                base.SetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 8))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 8);
                }
                expectedLocationsCount = 8;
                if (((locationReferences[(offset + 7)].Name != "dynamicValue") 
                            || (locationReferences[(offset + 7)].Type != typeof(Microsoft.Activities.DynamicValue)))) {
                    return false;
                }
                if (((locationReferences[(offset + 6)].Name != "itemId") 
                            || (locationReferences[(offset + 6)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext3.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext4_ForReadOnly : Workflow_TypedDataContext3_ForReadOnly {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected int itemId;
            
            public Workflow_TypedDataContext4_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext4_ForReadOnly(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext4_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            protected Microsoft.Activities.DynamicValue dynamicValue {
                get {
                    return ((Microsoft.Activities.DynamicValue)(this.GetVariableValue((7 + locationsOffset))));
                }
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr1GetTree() {
                
                #line 75 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<System.Guid>> expression = () => 
              System.Guid.Parse("{$ListId:Lists/TARSettings;}");
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public System.Guid @__Expr1Get() {
                
                #line 75 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              System.Guid.Parse("{$ListId:Lists/TARSettings;}");
                
                #line default
                #line hidden
            }
            
            public System.Guid ValueType___Expr1Get() {
                this.GetValueTypeValues();
                return this.@__Expr1Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr3GetTree() {
                
                #line 80 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<string>> expression = () => 
              "Title";
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public string @__Expr3Get() {
                
                #line 80 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              "Title";
                
                #line default
                #line hidden
            }
            
            public string ValueType___Expr3Get() {
                this.GetValueTypeValues();
                return this.@__Expr3Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr4GetTree() {
                
                #line 92 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<bool>> expression = () => 
              itemId < 1;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public bool @__Expr4Get() {
                
                #line 92 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              itemId < 1;
                
                #line default
                #line hidden
            }
            
            public bool ValueType___Expr4Get() {
                this.GetValueTypeValues();
                return this.@__Expr4Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr5GetTree() {
                
                #line 110 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<System.Guid>> expression = () => 
              System.Guid.Parse("{$ListId:Lists/TARSettings;}");
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public System.Guid @__Expr5Get() {
                
                #line 110 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              System.Guid.Parse("{$ListId:Lists/TARSettings;}");
                
                #line default
                #line hidden
            }
            
            public System.Guid ValueType___Expr5Get() {
                this.GetValueTypeValues();
                return this.@__Expr5Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr7GetTree() {
                
                #line 105 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
              itemId;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr7Get() {
                
                #line 105 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              itemId;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr7Get() {
                this.GetValueTypeValues();
                return this.@__Expr7Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr8GetTree() {
                
                #line 122 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<Microsoft.Activities.DynamicValue>> expression = () => 
              dynamicValue;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public Microsoft.Activities.DynamicValue @__Expr8Get() {
                
                #line 122 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              dynamicValue;
                
                #line default
                #line hidden
            }
            
            public Microsoft.Activities.DynamicValue ValueType___Expr8Get() {
                this.GetValueTypeValues();
                return this.@__Expr8Get();
            }
            
            protected override void GetValueTypeValues() {
                this.itemId = ((int)(this.GetVariableValue((6 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 8))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 8);
                }
                expectedLocationsCount = 8;
                if (((locationReferences[(offset + 7)].Name != "dynamicValue") 
                            || (locationReferences[(offset + 7)].Type != typeof(Microsoft.Activities.DynamicValue)))) {
                    return false;
                }
                if (((locationReferences[(offset + 6)].Name != "itemId") 
                            || (locationReferences[(offset + 6)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext3_ForReadOnly.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext5 : Workflow_TypedDataContext2 {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected int eifId;
            
            public Workflow_TypedDataContext5(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext5(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext5(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr22GetTree() {
                
                #line 228 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
              eifId;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr22Get() {
                
                #line 228 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              eifId;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr22Get() {
                this.GetValueTypeValues();
                return this.@__Expr22Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr22Set(int value) {
                
                #line 228 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
              eifId = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr22Set(int value) {
                this.GetValueTypeValues();
                this.@__Expr22Set(value);
                this.SetValueTypeValues();
            }
            
            internal System.Linq.Expressions.Expression @__Expr28GetTree() {
                
                #line 252 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
              index;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr28Get() {
                
                #line 252 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              index;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr28Get() {
                this.GetValueTypeValues();
                return this.@__Expr28Get();
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public void @__Expr28Set(int value) {
                
                #line 252 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                
              index = value;
                
                #line default
                #line hidden
            }
            
            public void ValueType___Expr28Set(int value) {
                this.GetValueTypeValues();
                this.@__Expr28Set(value);
                this.SetValueTypeValues();
            }
            
            protected override void GetValueTypeValues() {
                this.eifId = ((int)(this.GetVariableValue((5 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            protected override void SetValueTypeValues() {
                this.SetVariableValue((5 + locationsOffset), this.eifId);
                base.SetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 6))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 6);
                }
                expectedLocationsCount = 6;
                if (((locationReferences[(offset + 5)].Name != "eifId") 
                            || (locationReferences[(offset + 5)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext2.Validate(locationReferences, false, offset);
            }
        }
        
        [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Activities", "4.0.0.0")]
        [System.ComponentModel.BrowsableAttribute(false)]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        private class Workflow_TypedDataContext5_ForReadOnly : Workflow_TypedDataContext2_ForReadOnly {
            
            private int locationsOffset;
            
            private static int expectedLocationsCount;
            
            protected int eifId;
            
            public Workflow_TypedDataContext5_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locations, System.Activities.ActivityContext activityContext, bool computelocationsOffset) : 
                    base(locations, activityContext, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext5_ForReadOnly(System.Collections.Generic.IList<System.Activities.Location> locations, bool computelocationsOffset) : 
                    base(locations, false) {
                if ((computelocationsOffset == true)) {
                    this.SetLocationsOffset((locations.Count - expectedLocationsCount));
                }
            }
            
            public Workflow_TypedDataContext5_ForReadOnly(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences) : 
                    base(locationReferences) {
            }
            
            internal new static System.Activities.XamlIntegration.CompiledDataContext[] GetCompiledDataContextCacheHelper(object dataContextActivities, System.Activities.ActivityContext activityContext, System.Activities.Activity compiledRoot, bool forImplementation, int compiledDataContextCount) {
                return System.Activities.XamlIntegration.CompiledDataContext.GetCompiledDataContextCache(dataContextActivities, activityContext, compiledRoot, forImplementation, compiledDataContextCount);
            }
            
            public new virtual void SetLocationsOffset(int locationsOffsetValue) {
                locationsOffset = locationsOffsetValue;
                base.SetLocationsOffset(locationsOffset);
            }
            
            internal System.Linq.Expressions.Expression @__Expr23GetTree() {
                
                #line 233 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<Microsoft.Activities.DynamicValue>> expression = () => 
              restResponse;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public Microsoft.Activities.DynamicValue @__Expr23Get() {
                
                #line 233 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              restResponse;
                
                #line default
                #line hidden
            }
            
            public Microsoft.Activities.DynamicValue ValueType___Expr23Get() {
                this.GetValueTypeValues();
                return this.@__Expr23Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr24GetTree() {
                
                #line 223 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<string>> expression = () => 
              string.Format("({0})/Id", index);;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public string @__Expr24Get() {
                
                #line 223 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              string.Format("({0})/Id", index);;
                
                #line default
                #line hidden
            }
            
            public string ValueType___Expr24Get() {
                this.GetValueTypeValues();
                return this.@__Expr24Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr25GetTree() {
                
                #line 245 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<System.Guid>> expression = () => 
              System.Guid.Parse("{$ListId:Lists/EIFRequests;}");
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public System.Guid @__Expr25Get() {
                
                #line 245 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              System.Guid.Parse("{$ListId:Lists/EIFRequests;}");
                
                #line default
                #line hidden
            }
            
            public System.Guid ValueType___Expr25Get() {
                this.GetValueTypeValues();
                return this.@__Expr25Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr26GetTree() {
                
                #line 240 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
              eifId;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr26Get() {
                
                #line 240 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              eifId;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr26Get() {
                this.GetValueTypeValues();
                return this.@__Expr26Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr27GetTree() {
                
                #line 257 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<int>> expression = () => 
              index + 1;;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public int @__Expr27Get() {
                
                #line 257 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
              index + 1;;
                
                #line default
                #line hidden
            }
            
            public int ValueType___Expr27Get() {
                this.GetValueTypeValues();
                return this.@__Expr27Get();
            }
            
            internal System.Linq.Expressions.Expression @__Expr29GetTree() {
                
                #line 217 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                System.Linq.Expressions.Expression<System.Func<bool>> expression = () => 
        index < itemsCount;
                
                #line default
                #line hidden
                return base.RewriteExpressionTree(expression);
            }
            
            [System.Diagnostics.DebuggerHiddenAttribute()]
            public bool @__Expr29Get() {
                
                #line 217 "C:\O365\TAR\SHAREPOINT\SCI.TAR.WORKFLOWS\SCI.TAR.WORKFLOWS\EIFARCHIVINGWORKFLOW\WORKFLOW.XAML"
                return 
        index < itemsCount;
                
                #line default
                #line hidden
            }
            
            public bool ValueType___Expr29Get() {
                this.GetValueTypeValues();
                return this.@__Expr29Get();
            }
            
            protected override void GetValueTypeValues() {
                this.eifId = ((int)(this.GetVariableValue((5 + locationsOffset))));
                base.GetValueTypeValues();
            }
            
            public new static bool Validate(System.Collections.Generic.IList<System.Activities.LocationReference> locationReferences, bool validateLocationCount, int offset) {
                if (((validateLocationCount == true) 
                            && (locationReferences.Count < 6))) {
                    return false;
                }
                if ((validateLocationCount == true)) {
                    offset = (locationReferences.Count - 6);
                }
                expectedLocationsCount = 6;
                if (((locationReferences[(offset + 5)].Name != "eifId") 
                            || (locationReferences[(offset + 5)].Type != typeof(int)))) {
                    return false;
                }
                return Workflow_TypedDataContext2_ForReadOnly.Validate(locationReferences, false, offset);
            }
        }
    }
}
