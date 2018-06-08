<%@ Application Language="C#" %>
<%@ Import Namespace="System.Configuration" %>
<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // 在应用程序启动时运行的代码

    }
     public override void Init()
    {
        base.Init();
        foreach (string moduleName in this.Modules)
        {
            string appName =ConfigurationManager.AppSettings["appName"].ToString();
            IHttpModule module = this.Modules[moduleName];
            SessionStateModule ssm = module as SessionStateModule;
            if (ssm != null)
            {
                System.Reflection.FieldInfo storeInfo = typeof(SessionStateModule).GetField("_store", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
                SessionStateStoreProviderBase store = (SessionStateStoreProviderBase)storeInfo.GetValue(ssm);
                if (store == null)//In IIS7 Integrated mode, module.Init() is called later
                {
                    System.Reflection.FieldInfo runtimeInfo = typeof(HttpRuntime).GetField("_theRuntime", System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic);
                    HttpRuntime theRuntime = (HttpRuntime)runtimeInfo.GetValue(null);
                    System.Reflection.FieldInfo appNameInfo = typeof(HttpRuntime).GetField("_appDomainAppId", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
                    appNameInfo.SetValue(theRuntime, appName);
                }
                else
                {
                    Type storeType = store.GetType();
                    if (storeType.Name.Equals("OutOfProcSessionStateStore"))
                    {
                        System.Reflection.FieldInfo uribaseInfo = storeType.GetField("s_uribase", System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic);
                        uribaseInfo.SetValue(storeType, appName);
                    }
                }
            }
        }
    }
    void Application_End(object sender, EventArgs e) 
    {
        //  在应用程序关闭时运行的代码

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // 在出现未处理的错误时运行的代码

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // 在新会话启动时运行的代码

    }

    void Session_End(object sender, EventArgs e) 
    {
        // 在会话结束时运行的代码。 
        // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
        // InProc 时，才会引发 Session_End 事件。如果会话模式设置为 StateServer
        // 或 SQLServer，则不引发该事件。

    }
       
</script>
