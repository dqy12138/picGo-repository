<%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/10/31
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <base href="<%=basePath%>"> <!--需添加的内容-->
    <link rel="stylesheet" type="text/css" href="Static/css/login.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/jquery-confirm.css"/>
</head>
<body>
<script src="Static/js/lib/jquery-3.5.1.min.js"></script>
<script src="Static/js/lib/jquery-confirm.js"></script>
<script src="Static/js/login.js"></script>
<%
    //* 001  密码错，未超3次
    //* 002  邮箱已注册，密码错三次
    //* 003  邮箱未注册
%>
<form name="form1" action="${pageContext.request.contextPath}/User/toLogin"
      method="post" onsubmit="return PreValidate();"><!--onsubmit="return PreValidate()"有问题-->
    <h1>新闻系统登录</h1>
    <input class=input_1 type="email" id="email" size=15 name="user_email" placeholder="邮箱"/><br/>
    <input class=input_1 id="psd" type="password" size=15 name="user_password" placeholder="密码"/><br/>
    <input class=input_2 id="ValidateCode" type="tel" name="ValidateCode" placeholder="验证码" maxlength="6"/>
    <input class="input_4" type="button" id="getValidateCode" value="获取验证码" disabled="true"/><br/>
    <input class="input_3" type="submit" value="登录" id="submit"/>
    <a class="extra" href="${pageContext.request.contextPath}/User/enroll">注册</a>
</form>
</body>
</html>
