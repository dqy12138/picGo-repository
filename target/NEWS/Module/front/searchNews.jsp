<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/12/17
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>searchNews</title>
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
            $("#newsArea").css(css);
        });

        function more() {
            $.ajax({
                url: "${pageContext.request.contextPath}/queryNewsByKeyMore",
                type: "post",
                //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                data: {key: '${key}', cPage: $("#cp").val()},
                dataType: "json",
                success: function (data) {
                    $.each(data.moreNews, function (index, value) {
                        var s = '<div class="layui-card">' +
                            '<div class="layui-card-header">' +
                            '<a href="${pageContext.request.contextPath}/queryNewsById?nid=' + value.newsId +
                            '" target="_blank">' +
                            '<H2 style="max-width: 95%;overflow:hidden;white-space:nowrap; text-overflow:ellipsis" title="' +
                            value.title +
                            '">' +
                            value.title +
                            '</H2>' +
                            '</a>' +
                            '</div>' +
                            '<div class="layui-card-body">' +
                            value.createTime +
                            '</div>' +
                            '</div>';
                        $("#newsbody").append(s);
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
<body>
<div id="newsArea">
    <div id="newsbody" style="margin-top: 20px">
        <c:forEach items="${requestScope.newsL}" var="news">
            <div class="layui-card">
                <div class="layui-card-header"><a
                        href="${pageContext.request.contextPath}/queryNewsById?nid=${news.newsId}"
                        target="_blank"><H2 style="max-width: 95%;overflow:hidden;white-space:nowrap; text-overflow:ellipsis"
                                            title="${news.title}">${news.title}</H2></a></div>
                <div class="layui-card-body">
                    <fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </div>
            </div>
        </c:forEach>
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
</body>
</html>

