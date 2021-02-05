<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/11/28
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>updateNews</title>
    <script src="${pageContext.request.contextPath}/Static/js/lib/ckEditor/ckeditor.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            CKEDITOR.replace('content');
        };
    </script>
</head>
<body>
<a href="${pageContext.request.contextPath}/User/toLogin">回到首页</a><br/>

<form method="post" action="${pageContext.request.contextPath}/updateNews">
    <input name="newsId" type="hidden" value="${requestScope.news.newsId}">
    <input name="userId" type="hidden" value="${sessionScope.user.userId}"/>
    标题：<input type="text" name="title" id="title" value="${requestScope.news.title}"/><br/>
    类别：<select name="categoryId">
    <c:forEach items="${requestScope.categorys}" var="category">
        <option value="${category.category_id}"
                <c:if test="${category.category_id==requestScope.news.category_id}">
                    selected="true"
                </c:if>>${category.category_name}</option>
    </c:forEach>
</select><br/>
    内容：<textarea name="content" id="content">${news.content}</textarea>
    <input name="state" type="hidden" value="${news.state}"/>
    <input type="submit" value="修改"/>
</form>
</body>
</html>
