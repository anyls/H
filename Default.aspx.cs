﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    public string UserName = string.Empty;
    public string serviceKey = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        serviceKey = ConfigurationManager.AppSettings["serviceKey"].ToString();
        UserName = Session["UserName"] == null ? string.Empty : Session["UserName"].ToString();
        if (string.IsNullOrEmpty(UserName))
        {
            UserName = "未登录";
        }
    }
}