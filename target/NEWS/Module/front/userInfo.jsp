<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/12/3
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>userInfo</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/miniHeadStyle.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/underHeadStyle.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Static/js/lib/layUi/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        var uid = '${sessionScope.userS.userId}';

        function toEdit() {
            var myForm = document.createElement("form");
            myForm.method = "post";
            myForm.target = "_blank";
            myForm.action = "${pageContext.request.contextPath}/toEdit";
            var myInput = document.createElement("input");
            myInput.setAttribute("name", "uid"); // 为input对象设置name
            myInput.setAttribute("value", uid); // 为input对象设置value
            myForm.appendChild(myInput);
            document.body.appendChild(myForm);
            myForm.submit();
            document.body.removeChild(myForm); // 提交后移除创建的form
        }

        $(function () {
            myInfo(${sessionScope.userS.userId});
        });

        function myInfo(uid) {
            main0("${pageContext.request.contextPath}/queryUserInfo?uid=" + uid);
        }

        function myPwd(uid) {
            main0("${pageContext.request.contextPath}/queryUserPwd?uid=" + uid);
        }

        function myMisc() {
            main0("${pageContext.request.contextPath}/userDanger");
        }

        function main0(href) {
            $("#myMain").html('');
            $("#myMain").load(href);
        }
    </script>

</head>
<body bgcolor="#F2F2F2">
<jsp:include page="miniHead.jsp"/>
<%--<jsp:include page="underHead.jsp"/>--%>

<div class="layui-side" style="margin-top: 70px;margin-left: 20%;width: 15%">
    <ul class="layui-nav layui-bg-green">
        <li class="layui-nav-item">
            <a href="javascript:void(0);" onclick="myInfo(${sessionScope.userS.userId})"><img
                    src="${pageContext.request.contextPath}/Static/img/info.png"
                    class="layui-nav-img"/>账户资料</a>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:void(0);" onclick="myPwd(${sessionScope.userS.userId})"><img
                    src="${pageContext.request.contextPath}/Static/img/cpwd.png"
                    class="layui-nav-img"/>修改密码</a>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:void(0);" onclick="myMisc(${sessionScope.userS.userId})"><img
                    src="${pageContext.request.contextPath}/Static/img/aset.png"
                    class="layui-nav-img"/>账号管理</a>
        </li>
    </ul>
</div>
<div id="myMain" class="layui-body" style="margin-top: 60px;margin-left:25%;width: 45%">

</div>
<script src="${pageContext.request.contextPath}/Static/js/lib/layUi/layui.js" charset="utf-8"></script>
<script>
    layui.use('element', function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
    });
</script>
</body>
</html>
