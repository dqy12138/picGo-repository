<%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/12/15
  Time: 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title></title>

    <style>
        html {
            margin: 0;
            padding: 0;
            background-color: white;
        }

        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        #svgContainer {
            width: 640px;
            height: 512px;
            background-color: white;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            margin: auto;
        }
    </style>

</head>

<script type="text/javascript" src="${pageContext.request.contextPath}/Static/js/bodymovin.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/Static/js/data.js"></script>

<div id="svgContainer">

</div>
<div>
    <h1>你请求的页面不存在！</h1>
</div>
<div id="show">
    <a href="${pageContext.request.contextPath}/front/index.html">点击此处跳转到新闻主页</a>
</div>

<script type="text/javascript">
    var svgContainer = document.getElementById('svgContainer');
    var animItem = bodymovin.loadAnimation({
        wrapper : svgContainer,
        animType : 'svg',
        loop : true,
        animationData : JSON.parse(animationData)
    });
</script>

</body>
</html>
