<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/12/20
  Time: 18:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Help</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Static/js/lib/layUi/css/layui.css" media="all">
</head>
<body>
<div style="margin-top: 10px;margin-left: 15px;">
    <a href="${pageContext.request.contextPath}/User/toLogin" style="line-height: 50px"><img
            src="${pageContext.request.contextPath}/Static/img/main.png"
            class="layui-nav-img"/>首页</a>
</div>
<div style="width: 70%;margin-top: 5px;margin-left: auto;margin-right: auto">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md7">
            <div class="grid-demo">
                <blockquote class="layui-elem-quote"><h1>热门问题</h1></blockquote>
                <blockquote class="layui-elem-quote layui-quote-nm">
                    <a href=""><h3 style="color: #01AAED">如何更换绑定的邮箱，原有邮箱不用了怎么办？</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED"> 为什么文章会被锁定，被锁定如何解锁？</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">什么情况下我的账号会存在安全风险</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">如何开启「禁止转载」功能</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">如何注销账号</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED"> 账号绑定解绑相关问题汇总</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">如果你发现你的文章全部消失了</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">我该如何发表一篇付费文章？</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">文章列表处的缩略图不显示怎么办？</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED"> 官方专题投稿指南大全</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">关于举报“抄袭类文章”的说明</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">删除的文章如何找回，有回收站吗？</h3></a><br/>
                </blockquote>
                <blockquote class="layui-elem-quote"><h1>帮助中心</h1></blockquote>
                <blockquote class="layui-elem-quote layui-quote-nm">
                    <a href=""><h3 style="color: #01AAED">验证码控件异常问题的错误提示详情</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">历史版本</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">上传图片的私密性说明</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">喜欢的文章</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">我的动态</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">个人主页</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">作者推荐</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">好文推荐</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">Markdown 编辑器</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">富文本（Rich-text）编辑器</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">文章书写</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">文章管理</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">阅读主界面</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">写作主界面</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED"> 设置</h3></a><br/>
                </blockquote>
                <blockquote class="layui-elem-quote"><h1>更多</h1></blockquote>
                <blockquote class="layui-elem-quote layui-quote-nm">
                    <a href=""><h3 style="color: #01AAED"> 添加写文章快捷方式到桌面</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">文章喜欢数变动说明</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED"> 如何写一个整洁好看的标题</h3></a><br/>
                    <a href=""><h3 style="color: #01AAED">文章字数统计有问题怎么办</h3></a><br/>
                </blockquote>
            </div>
        </div>
        <div class="layui-col-md5">
            <div class="grid-demo">
                <img src="${pageContext.request.contextPath}/Static/img/question.png" class="layui-nav-img"
                     width="100"/>
                <h2>没解决您的问题?</h2><br/>
                <a href="${pageContext.request.contextPath}/toFeedback"><h3 style="color: #01AAED">去反馈&nbsp;&gt;</h3></a>
                <hr class="layui-bg-black">
                <br/>
                <h3>帐户冻结、文章锁定问题，请邮件联系 xxx@xxx.com</h3>
                <br/>
                <hr class="layui-bg-black">
                <br/>
                <a href=""><h3 style="color: #01AAED">联系我们&nbsp;&gt;</h3></a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
