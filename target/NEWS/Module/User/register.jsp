<%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/10/30
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
    <title>新闻系统注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <base href="<%=basePath%>"> <!--需添加的内容-->
    <link rel="stylesheet" href="Static/css/register.css"/>
</head>
<body>
<form name="form1" action="${pageContext.request.contextPath}/User/toEnroll" method="post"
      onsubmit="return login()"><%--todo--%>
    <h1>发布新闻管理系统</h1>
    <input class=input_1 id="username" size=15 name="user_name" placeholder=用户名><br/>
    <input class=input_1 id="password" type="password" size=15 name="user_password" placeholder=密码><br/>
    <input class=input_1 id="email" type="email" size=15 name="user_email" placeholder=邮箱><br/>
    <input class=input_2 id="captcha" type="tel" name="captcha" placeholder="验证码" maxlength="6">
    <input class="input_4" type="button" id="sendCap" value="获取验证码" disabled="true"/><br/>
    <input class="input_3" type="submit" value="注册"/>
    <a href="${pageContext.request.contextPath}/User/login">登录</a>
</form>
<script src="Static/js/lib/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="Static/js/register.js"></script>
</body>
</html>
