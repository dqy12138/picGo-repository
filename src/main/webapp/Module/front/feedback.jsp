<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/11/28
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>feedback</title>
    <link rel="stylesheet" href="Static/js/lib/layUi/css/layui.css" media="all">
    <script src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script src="Static/js/lib/jquery-confirm.js"></script>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/jquery-confirm.css"/>
    <script type="text/javascript">
        $(function () {
            $("#sendTo").click(function () {
                //获取值
                var uid = '${sessionScope.userS.userId}';
                var type = $("#type").val();
                var content = $("#content").val();
                if (content !== "") {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/addFeedback",
                        type: "post",
                        //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                        data: {user_id: uid, type: type, content: content},
                        dataType: "json",
                        success: function (data) {
                            if (data.result === 'success') {
                                //alert("谢谢您的反馈，我们会认真思考，努力变得更好！");
                                $.confirm({
                                    title: '反馈成功：',
                                    closeIcon:true,
                                    content: '谢谢您的反馈，我们会认真思考，努力变得更好！<br\> 您是退回个人主页还是跳转到首页？',
                                    buttons: {
                                        logOut: {
                                            text: "退到个人主页",
                                            action:function (){
                                                window.location.href= "queryUserById?uid=${sessionScope.userS.userId}"
                                            }
                                        },
                                        jump: {
                                            text: "退出到新闻主页",
                                            action: function () {
                                                window.location.href= "front/index.html";
                                            }
                                        }
                                    }
                                });
                            } else {
                                $.alert("反馈失败！");
                            }
                        }
                    })
                } else {
                    $.alert("内容不能为空！");
                }
            });
        });
    </script>
</head>
<body bgcolor="F2F2F2">
<div style="margin-top: 10px;margin-left: 15px;">
    <a href="${pageContext.request.contextPath}/User/toLogin" style="line-height: 50px"><img
            src="${pageContext.request.contextPath}/Static/img/main.png"
            class="layui-nav-img"/>首页</a>
</div>

<div class="layui-card" style="width: 50%;margin-top: 100px; margin-left: auto;margin-right: auto;">
    <div class="layui-card-header">意见反馈</div>
    <div class="layui-card-body">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">反馈类型</label>
                <div class="layui-input-block">
                    <select id="type">
                        <option value="安全">安全</option>
                        <option value="体验">体验</option>
                        <option value="功能">功能</option>
                        <option value="速度">速度</option>
                        <option value="异常">异常</option>
                        <option value="建议">建议</option>
                        <option value="其他">其他</option>
                    </select>
                    <div class="layui-unselect layui-form-select">
                        <div class="layui-select-title">
                            <input type="text" placeholder="请选择" value="" readonly=""
                                   class="layui-input layui-unselect">
                            <i class="layui-edge"></i>
                        </div>
                        <dl class="layui-anim layui-anim-upbit">
                            <dd lay-value="安全">安全</dd>
                            <dd lay-value="体验">体验</dd>
                            <dd lay-value="功能">功能</dd>
                            <dd lay-value="速度">速度</dd>
                            <dd lay-value="异常">异常</dd>
                            <dd lay-value="建议">建议</dd>
                            <dd lay-value="其他">其他</dd>
                        </dl>
                    </div>
                </div>
            </div>
            <div class="layui-input-block">
                <textarea placeholder="请输入反馈内容" class="layui-textarea" id="content"></textarea>
            </div>
            <div class="layui-input-block" align="right">
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                <button type="button" class="layui-btn" id="sendTo">提交</button>
            </div>
        </form>
        <div id="after">
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/Static/js/lib/layUi/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use('form', function () {
        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
        form.render();
    });
</script>
</body>
</html>
