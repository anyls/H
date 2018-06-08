<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Web.SessionState;

public class Handler : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        var username = context.Request["username"].ToString();
        context.Session["UserName"] = username;
        context.Response.Write("ok");
            context.Response.End();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}