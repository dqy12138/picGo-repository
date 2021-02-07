<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/11/23
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>show</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Static/js/lib/layUi/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var css = {
                marginLeft: 'auto',
                marginRight: 'auto',
                width: '70%',
                height: 'auto',
            };
            $("#show").css(css);
            $("#sendTo").click(function () {
                //获取值
                var uid = '${sessionScope.userS.userId}';
                var uname = '${sessionScope.userS.userName}';
                var nid = '${news.newsId}';
                var content = $("#content").val();
                var uIcon = '${sessionScope.userS.userIcon}';
                if (content !== "") {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/addComment",
                        type: "post",
                        //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                        data: {user_id: uid, news_id: nid, content: content},
                        dataType: "json",
                        success: function (data) {
                            if (data.result === 'success') {
                                alert("评论成功");
                                var iconSrc="${pageContext.request.contextPath}/Static/img/userIcon.png"
                                if(!(uIcon === "")){
                                    iconSrc=uIcon;
                                }
                                $("#content").val('');
                                var s = '<div class="layui-card" id="div_' + data.cid + '">' +
                                    '<div class="layui-card-body">' +
                                    '<div align="left">' +
                                    '<a href="${pageContext.request.contextPath}/queryUserById?uid='+uid+'">' +
                                    '<img class="layui-nav-img" src="' + iconSrc + '"/>' +
                                    uname + '</a>' +
                                    ' </div>' +
                                    content +
                                    '<div align="right">' +
                                    '<a href="javascript:void(0);" onclick="delComment(' + data.cid + ')">删除</a>' +
                                    '</div>' +
                                    '<div align="right">' +
                                    getCurrentDate(new Date()) +
                                    '</div>' +
                                    '</div>' +
                                    '</div>';
                                $("#newComment").prepend(s);
                            } else {
                                alert("评论失败");
                            }
                        }
                    })
                } else {
                    alert("评论不能为空！");
                }
            });
        });

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
                            $("#div_" + cid).remove();
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

        function getCurrentDate(date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            var h = date.getHours();
            var min = date.getMinutes();
            var s = date.getSeconds();
            var str = y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d) + '-' + (h < 10 ? ('0' + h) : h) + ':' + (min < 10 ? ('0' + min) : min) + ':' + (s < 10 ? ('0' + s) : s);
            return str;
        }

        function more() {
            $.ajax({
                url: "${pageContext.request.contextPath}/queryCommentByNIdMore",
                type: "post",
                //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                data: {nid: '${nid}', cPage: $("#cp").val()},
                dataType: "json",
                success: function (data) {
                    $.each(data.moreComments, function (index, value) {
                        if (value.user_id ==='${sessionScope.userS.userId}') {
                            var z = '<div align="right">' +
                                '<a href="javascript:void(0);" onclick="delComment(' + value.comment_id + ')">删除</a>' +
                                '</div>';
                        } else {
                            var z = '';
                        }
                        var iconSrc="${pageContext.request.contextPath}/Static/img/userIcon.png"
                        if("user_icon" in value){
                            iconSrc=value.user_icon;
                        }
                        var s = '<div class="layui-card" id="div_' + value.comment_id + '">' +
                            '<div class="layui-card-body">' +
                            '<div align="left">' +
                            '<a href="${pageContext.request.contextPath}/queryUserById?uid=' + value.user_id + '"> ' +
                            '<img src="'+iconSrc+'" class="layui-nav-img"/>' +
                            value.user_name + '</a>' +
                            ' </div>' +
                            value.content +
                            z +
                            '<div align="right">' +
                            value.createTime +
                            '</div>' +
                            '</div>' +
                            '</div>';
                        $("#comments").append(s);
                    });
                    if (data.cPage + 1 <${totalPage}) {
                        var x = '<a href="javascript:void(0);" onclick="more()">点击查看更多&gt;&gt;</a>';
                        $("#more").html(x)
                    } else {
                        var y = '<p>没有更多内容了</p>';
                        $("#more").html(y)
                    }
                    $("#cp").val(data.cPage);
                }
            })
        }
    </script>
</head>
<body bgcolor="F2F2F2">
<div align="left" style="margin-top: 10px;margin-left: 15px;">
    <a href="${pageContext.request.contextPath}/User/toLogin" style="line-height: 50px"><img
            src="${pageContext.request.contextPath}/Static/img/main.png"
            class="layui-nav-img"/>首页</a>
</div>
<c:choose>
    <c:when test="${news.state!=1||news==null}">
        <h2 align="center">该文章审核尚未通过！</h2>
    </c:when>
    <c:otherwise>
        <div id="show">
            <div id="newsbody" style="margin-top: 20px">
                <div class="layui-card">
                    <div class="layui-card-header"><h1>${requestScope.news.title}</h1></div>
                    <div align="right"><a
                            href="${pageContext.request.contextPath}/queryNewsByCId?cid=${news.categoryId}">其他新闻</a>
                        <fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </div>

                    <div class="layui-card-body">
                            ${requestScope.news.content}
                        <br/>作者：<a href="${pageContext.request.contextPath}/queryUserById?uid=${news.userId}">点这</a>
                    </div>
                </div>
                <br/>
            </div>
            <div>
                评论区：<br/>
                <c:choose>
                    <c:when test="${sessionScope.userS!=null}">
                        <div class="layui-card">
                            <div class="layui-card-body">
                                <form class="layui-form">
                                    <div class="layui-input-block">
                                        <textarea placeholder="请输入内容" class="layui-textarea" id="content"></textarea>
                                    </div>
                                    <div class="layui-input-block" align="right">
                                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                        <button type="button" class="layui-btn" id="sendTo">评论</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/User/login">登陆后可评论</a>
                    </c:otherwise>
                </c:choose>
                <div id="newComment">
                </div>
                <br/>
                <div id="comments">
                    <c:forEach items="${comments}" var="comment">
                        <div class="layui-card" id="div_${comment.comment_id}">
                            <div class="layui-card-body">
                                <div align="left">
                                    <a href="${pageContext.request.contextPath}/queryUserById?uid=${comment.user_id}">
                                        <c:choose>
                                            <c:when test="${comment.user_icon==null}">
                                                <img src="${pageContext.request.contextPath}/Static/img/userIcon.png"
                                                     class="layui-nav-img"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${comment.user_icon}" class="layui-nav-img"/>
                                            </c:otherwise>
                                        </c:choose>
                                            ${comment.user_name}
                                    </a>
                                </div>
                                    ${comment.content}
                                <div align="right">
                                    <c:if test="${sessionScope.userS.userId==comment.user_id}">
                                        <a href="javascript:void(0);" onclick="delComment(${comment.comment_id})">删除</a>
                                    </c:if>
                                </div>
                                <div align="right">
                                        ${comment.createTime}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <br/>
            <div id="more">
                <c:choose>
                    <c:when test="${cPage+1<totalPage}">
                        <a href="javascript:void(0);" onclick="more()">点击查看更多&gt;&gt;</a>
                    </c:when>
                    <c:otherwise>
                        <p>没有更多内容了</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <input id="cp" type="hidden" value="${cPage}"/>
    </c:otherwise>
</c:choose>


</body>
</html>
