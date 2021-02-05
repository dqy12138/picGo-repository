<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/11/23
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <title>edit</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Static/js/lib/layUi/css/layui.css" media="all">
    <style type="text/css">
        html, body {
            height: 100%;
        }

        body {
            margin: 0;
        }
    </style>
    <script src="${pageContext.request.contextPath}/Static/js/lib/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/Static/js/lib/ckEditor/ckeditor.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            CKEDITOR.replace('content', {height: "400px"});
        };

        $(function () {
            $("#submit").click(function () {
                var ops = $("#ops").val();
                if (ops !== '0') {
                    opNews("updateNews");
                } else {
                    opNews("addNews");
                }
            })
        });

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
                            $("#div_" + nid).remove();
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

        function upNews(nid) {
            $.ajax({
                url: "${pageContext.request.contextPath}/toUpdate",
                type: "post",
                //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                data: {nid: nid},
                dataType: "json",
                success: function (data) {
                    if (data.result === 'success') {
                        $("#ops").val(data.newsId);
                        var select = 'dd[lay-value=' + data.categoryId + ']';
                        //触发点击事件，实现自动选择
                        $("#categoryId").siblings("div.layui-form-select").find('dl').find(select).click();
                        $("#title").val(data.title);
                        CKEDITOR.instances.content.setData(data.content);
                    } else {
                        alert("出错！");
                    }
                }
            });
        }

        function opNews(op) {
            var ops = $("#ops").val();
            var uid = '${sessionScope.userS.userId}';
            var cid = $("#categoryId").val();
            var title = $("#title").val();
            var content = CKEDITOR.instances.content.getData();
            if (title !== "" && content !== "") {
                if (ops !== '0') {
                    var dataparam = {
                        newsId: ops,
                        userId: uid,
                        categoryId: cid,
                        title: title,
                        content: content,
                        state: 0
                    }
                } else {
                    var dataparam = {userId: uid, categoryId: cid, title: title, content: content, state: 0}
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/" + op,
                    type: "post",
                    //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                    data: dataparam,
                    dataType: "json",
                    success: function (data) {
                        if (data.result === 'success') {
                            alert("发布成功,审核通过后点击左侧标题查看效果！");
                            var s = '<div class="layui-card" id="div_' + data.newsId + '">' +
                                '<div class="layui-card-header">' +
                                '<h3 style="max-width: 95%;overflow:hidden;white-space:nowrap; text-overflow:ellipsis" title="' + title + '">' +
                                '<a target="_blank" href="${pageContext.request.contextPath}/queryNewsById?nid=' + data.newsId + '">' + title + '</a>' +
                                '</h3>' +
                                '</div>' +
                                '<div class="layui-card-body">' +
                                '<img src="${pageContext.request.contextPath}/Static/img/inreview.png" class="layui-nav-img"/>' +
                                '<div align="right">' +
                                '<a href="javascript:void(0);" onclick="upNews(' + data.newsId + ')"><span style="color: blue">修改</span></a>' +
                                '<a href="javascript:void(0);" onclick="delNews(' + data.newsId + ')"><span style="color: red">删除</span></a>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                            if (ops !== '0') {
                                $("#div_" + nid).remove();
                            }
                            $("#newNews").prepend(s);
                        } else {
                            alert("发布失败！");
                        }
                    }
                })
            } else {
                alert("标题或内容不能为空！");
            }
        }

        function add() {
            $("#ops").val('0');
            var select = 'dd[lay-value=' + 1 + ']';
            //触发点击事件，实现自动选择
            $("#categoryId").siblings("div.layui-form-select").find('dl').find(select).click();
            $("#title").val('');
            CKEDITOR.instances.content.setData('');
        }
    </script>

</head>
<body>
<div style="height: 100%">
    <div class="layui-row" style="height: 100%">
        <div class="layui-col-xs3 layui-bg-gray" style="height: 100%;padding: 5px;overflow-y:auto;">
            <div class="grid-demo">
                <div style="background-color: #00FFFF; text-align: center;height: 50px">
                    <a href="${pageContext.request.contextPath}/User/toLogin" style="line-height: 50px"><img
                            src="${pageContext.request.contextPath}/Static/img/main.png"
                            class="layui-nav-img"/>首页</a>
                </div>
                <br/>
                <div style="background-color:bisque; text-align: center;height: 50px">
                    <a href="javascript:void(0);" onclick="add()" style="line-height: 50px"><img
                            src="${pageContext.request.contextPath}/Static/img/addn.png"
                            class="layui-nav-img"/>新建</a>
                </div>
                <br/>
                <div id="newNews">
                </div>
                <br/>
                <div>
                    <c:forEach items="${ownNews}" var="news">
                        <div class="layui-card" id="div_${news.newsId}">
                            <div class="layui-card-header">
                                <h3 style="max-width: 95%;overflow:hidden;white-space:nowrap; text-overflow:ellipsis"
                                    title="${news.title}">
                                    <a target="_blank"
                                       href="${pageContext.request.contextPath}/queryNewsById?nid=${news.newsId}">${news.title}</a>
                                </h3>
                            </div>
                            <div class="layui-card-body">
                                <c:choose>
                                    <c:when test="${news.state==0}">
                                        <img src="${pageContext.request.contextPath}/Static/img/inreview.png"
                                             class="layui-nav-img"/>
                                    </c:when>
                                    <c:when test="${news.state==1}">
                                        <img src="${pageContext.request.contextPath}/Static/img/accept.png"
                                             class="layui-nav-img"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/Static/img/reject.png"
                                             class="layui-nav-img"/>
                                    </c:otherwise>
                                </c:choose>
                                <div align="right">
                                    <a href="javascript:void(0);" onclick="upNews(${news.newsId})"><span
                                            style="color: blue">修改</span></a>
                                    <a href="javascript:void(0);" onclick="delNews(${news.newsId})"><span
                                            style="color: red">删除</span></a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="layui-col-xs9">
            <div class="layui-card">
                <div class="layui-card-body" pad15="">
                    <div class="layui-form">
                        <div class="layui-form-item">
                            <label class="layui-form-label">标题</label>
                            <div class="layui-input-inline">
                                <input type="text" id="title" name="title"
                                       placeholder="请输入标题" style="width: 400px"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"></div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">选择框</label>
                            <div class="layui-input-block">
                                <select id="categoryId" name="categoryId">
                                    <c:forEach items="${categorys}" var="category">--%>
                                        <option value="${category.category_id}">${category.category_name}</option>
                                    </c:forEach>
                                </select>
                                <div class="layui-unselect layui-form-select">
                                    <div class="layui-select-title">
                                        <input type="text" placeholder="请选择" value="" readonly=""
                                               class="layui-input layui-unselect">
                                        <i class="layui-edge"></i></div>
                                    <dl class="layui-anim layui-anim-upbit" style="">
                                        <c:forEach items="${categorys}" var="category">--%>
                                            <dd lay-value="${category.category_id}">${category.category_name}</dd>
                                        </c:forEach>
                                    </dl>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">内容</label>
                            <div class="layui-input-block">
                                <textarea id="content" name="content"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block" align="right">
                                <button type="reset" class="layui-btn layui-btn-primary">重新填写</button>
                                <button type="button" class="layui-btn" id="submit">发布</button>
                                <input type="hidden" id="ops" value="0"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/Static/js/lib/layUi/layui.js" charset="utf-8"></script>
<script>
    layui.use('form', function () {
        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
        form.render();
    });
</script>
</body>
</html>
