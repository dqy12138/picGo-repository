<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/11/25
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>main</title>
    <%--    <meta name="renderer" content="webkit">--%>
    <%--    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">--%>
    <%--    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
    <style type="text/css">
        html, body {
            height: 100%;
        }

        body {
            margin: 0;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Static/js/lib/layUi/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        var cPage = 0;
        var uid = '${sessionScope.userS.userId}';
        $(function () {
            main("${pageContext.request.contextPath}/front/index.html");
            $("#search").click(function () {
                var key = $("#key").val();
                main("${pageContext.request.contextPath}/queryNewsByKey?key=" + key + "&cPage=" + cPage);
            });
            $('#key').bind('keypress', function (event) {
                if (event.keyCode === 13) {
                    $("#search").click();
                }
            });
        });

        function byCid(cid) {
            main("${pageContext.request.contextPath}/queryNewsByCId?cid=" + cid + "&cPage=" + cPage);
        }

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

        function main(href) {
            $("#main").html('');
            $("#main").load(href);
        }
    </script>
</head>
<body bgcolor="F2F2F2">
<div class="layui-layout-admin">
    <div class="layui-header layui-bg-blue header header-user">
        <ul class="layui-nav layui-layout-body">
            <li class="layui-nav-item  layui-this"><a href="${pageContext.request.contextPath}/User/toLogin"><img
                    src="${pageContext.request.contextPath}/Static/img/main.png" class="layui-nav-img"/>首页</a></li>
            <c:forEach items="${requestScope.categorys}" var="category">
                <li class="layui-nav-item"><a href="javascript:void(0);"
                                              onclick="byCid(${category.category_id})">${category.category_name}</a>
                </li>
            </c:forEach>
            <li class="layui-nav-item layui-hide-xs">
                <input id="key" type="text" placeholder="搜索..." autocomplete="off"
                       class="layui-input layui-input-search">
            </li>
            <li class="layui-nav-item layui-hide-xs">
                <button id="search" type="button" class="layui-btn"><i class="layui-icon layui-icon-search"></i>
                </button>
            </li>
        </ul>
        <c:choose>
            <c:when test="${sessionScope.userS!=null}">
                <ul class="layui-nav layui-layout-right">
                    <li class="layui-nav-item ">
                        <a href="javascript:void(0);" onclick="toEdit()">
                            <button type="button" class="layui-btn"><i class="layui-icon"></i>写文章</button>
                        </a>
                    </li>
                    <li class="layui-nav-item" lay-unselect="">
                        <a href="${pageContext.request.contextPath}/queryUserById?uid=${sessionScope.userS.userId}">
                            <c:choose>
                                <c:when test="${sessionScope.userS.userIcon==null}">
                                    <img src="${pageContext.request.contextPath}/Static/img/userIcon.png"
                                         class="layui-nav-img"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="${sessionScope.userS.userIcon}" class="layui-nav-img"/>
                                </c:otherwise>
                            </c:choose>
                            我</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="${pageContext.request.contextPath}/queryUser">我的资料</a>
                            </dd>
                            <dd><a target="_blank" href="${pageContext.request.contextPath}/toHelp">帮助与反馈</a></dd>
                            <dd><a href="javascript: if(window.confirm('确定要退出登录？'))
        {window.location.href='${pageContext.request.contextPath}/User/logout'}">退出</a></dd>
                        </dl>
                    </li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul class="layui-nav layui-layout-right">
                    <li class="layui-nav-item " lay-unselect="">
                        <a href="${pageContext.request.contextPath}/User/login"><img
                                src="${pageContext.request.contextPath}/Static/img/userIcon.png"
                                class="layui-nav-img"/>登录</a>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>

<%--<div class="layui-carousel" id="test10">--%>
<%--    <div carousel-item="">--%>
<%--        <c:forEach items="${requestScope.pics}" var="pic">--%>
<%--            <div><a href="${pageContext.request.contextPath}/queryNewsById?nid=${pic.news_id}"><img src="${pic.pic_url}"--%>
<%--                                                                                                    style="width: 100%;height: auto"/></a>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
<%--</div>--%>
<div id="main">
</div>

</div>
<script src="${pageContext.request.contextPath}/Static/js/lib/layUi/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['carousel', 'form'], function () {
        var carousel = layui.carousel
            , form = layui.form;
        //图片轮播
        carousel.render({
            elem: '#test10'
            , width: '350px'
            , height: '200px'
            , interval: 5000
        });
    });
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
