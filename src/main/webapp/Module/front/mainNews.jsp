<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/12/6
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>mainNews</title>
</head>
<body>
<div class="layui-fluid layui-bg-green" style="width: 60%">
    <div class="layui-row layui-col-space1">
        <c:forEach items="${newsLL}" var="newsL">
            <div class="layui-col-xs4">
                <!-- 填充内容 -->
                <div class="layui-card">
                    <div class="layui-card-body" style="height: 250px;">
                        <c:forEach items="${newsL}" var="news">
                            <li>
                                <a href="${pageContext.request.contextPath}/queryNewsById?nid=${news.newsId}"><h4
                                        style="max-width: 100%;overflow:hidden;white-space:nowrap; text-overflow:ellipsis"
                                        title="${news.title}">${news.title}</h4></a>
                            </li>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
