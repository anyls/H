<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
 <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
      <h1>我是服务器<%=serviceKey %></h1>
    <h2>登录状态：<%=UserName %></h2>
    <hr />
    <input type="text" id="username" placeholder="用户名称" />
    <input type="button" id="smb" value="登录" />
    <script>
        $(function () {
            $("#smb").click(function () {
                var u = $("#username").val();
                if (u.trim()) {
                    $.get("/Handler.ashx?username=" + u + "&v=" + new Date().getTime(), function (data) {
                        if (data==="ok") {
                            location.reload();
                        }
                    });
                } else {
                    alert("请输入用户名称");
                }
            });
        });
    </script>
</body>
</html>
