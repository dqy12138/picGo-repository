<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/11/27
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>userDetail</title>
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

        function toEditNews(nid) {
            window.open("${pageContext.request.contextPath}/toEdit?uid=${sessionScope.userS.userId}");

        }

        function delNews(nid) {
            if (confirm("确定要删除吗？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/deleteNews",
                    type: "post",
                    //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                    data: {nid: nid},
                    dataType: "json",
                    success: function (data) {
                        if (data.result === 'success') {
                            alert("新闻删除成功");
                            $("#ndiv_" + nid).remove();
                        } else {
                            alert("新闻删除失败");
                        }
                    }
                });
                return true;
            } else {
                return false;
            }
        }

        function delComment(cid) {
            if (confirm("确定要删除吗？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/deleteComment",
                    type: "post",
                    //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                    data: {cid: cid},
                    dataType: "json",
                    success: function (data) {
                        if (data.result === 'success') {
                            alert("评论删除成功");
                            $("#cdiv_" + cid).remove();
                        } else {
                            alert("评论删除失败");
                        }
                    }
                });
                return true;
            } else {
                return false;
            }
        }
    </script>
</head>
<body bgcolor="F2F2F2">
<jsp:include page="miniHead.jsp"/>
<jsp:include page="underHead.jsp"/>
<div style="width: 60%;margin-top: 5px;margin-left: auto;margin-right: auto">
    <div class="layui-card">
        <div style="text-align: center;height: 100px">
            <a href="${pageContext.request.contextPath}/queryUserById?uid=${user.userId}"
               style="line-height: 50px">
                <c:choose>
                    <c:when test="${user.userIcon==null}">
                        <img class="layadmin-homepage-pad-img" width="64" height="64" style="margin:5px;"
                             src="${pageContext.request.contextPath}/Static/img/userIcon.png"/>
                    </c:when>
                    <c:otherwise>
                        <img class="layadmin-homepage-pad-img" width="64" height="64" style="margin:5px;"
                             src="${user.userIcon}"/>
                    </c:otherwise>
                </c:choose>
                ${user.userName}
            </a>
        </div>
        <div class="layadmin-homepage-pad-ver" style="text-align: center;height: 40px">
            <a href="javascript:;" class="layui-icon layui-icon-cellphone"></a>
            <a href="javascript:;" class="layui-icon layui-icon-vercode"></a>
            <a href="javascript:;" class="layui-icon layui-icon-login-wechat"></a>
            <a href="javascript:;" class="layui-icon layui-icon-login-qq"></a>
        </div>
    </div>
    <button class="layui-btn layui-btn-fluid">关注</button>
    <br/>
    <div class="layui-card" style="padding: 5px">
        <div><h2>关于我</h2>
        </div>
        <div style="margin-top: 5px">
            <c:if test="${user.userDetail==null}">
                此人很懒，没有编辑个人介绍
            </c:if>
            <c:if test="${user.userDetail!=null}">
                ${user.userDetail}
            </c:if>        </div>
    </div>
    <br/>
    <div class="layui-tab">
        <ul class="layui-tab-title layui-bg-green">
            <li class="layui-this">新闻</li>
            <li class="">评论</li>
            <li class="">反馈</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <c:forEach items="${newsL}" var="news">
                    <div class="layui-card" id="ndiv_${news.newsId}">
                        <div class="layui-card-header">
                            <a href="${pageContext.request.contextPath}/queryNewsById?nid=${news.newsId}"
                               target="_blank">
                                <H2 style="max-width: 95%;overflow:hidden;white-space:nowrap; text-overflow:ellipsis;"
                                    title="${news.title}">${news.title}</H2>
                            </a></div>
                        <div class="layui-card-body">
                            <fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </div>
                        <c:if test="${requestScope.user.userId==sessionScope.userS.userId}">
                            <div align="right">
                                <a href="javascript:void(0);" onclick="toEditNews(${news.newsId})"><span
                                        style="color: blue">修改</span></a>
                                <a href="javascript:void(0);" onclick="delNews(${news.newsId})"><span
                                        style="color: red">删除</span></a>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
            <div class="layui-tab-item">
                <c:forEach items="${comments}" var="comment">
                    <div class="layui-card" id="cdiv_${comment.comment_id}">
                        <div class="layui-card-body">
                            <div align="left">
                                <a href="${pageContext.request.contextPath}/queryNewsById?nid=${comment.news_id}"><h2>
                                    新闻标题：${comment.title}</h2></a>
                            </div>
                            <br/>
                            评论内容：${comment.content}
                            <div align="right">
                                <c:if test="${sessionScope.userS.userId==comment.user_id}">
                                    <a href="javascript:void(0);" onclick="delComment(${comment.comment_id})"><span
                                            style="color: red">删除</span></a>
                                </c:if>
                            </div>
                            <div align="right">
                                    ${comment.createTime}
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="layui-tab-item">
                <c:forEach items="${feedbacks}" var="feedback">
                    <div class="layui-card">
                        <div class="layui-card-body">
                            <div align="left">
                                <h3>反馈类型：${feedback.type}</h3>
                            </div>
                            <br/>
                            内容：${feedback.content}
                            <div align="right">
                                    ${feedback.createTime}
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/Static/js/lib/layUi/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
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
