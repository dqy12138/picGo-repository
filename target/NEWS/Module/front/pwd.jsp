<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/12/6
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>pwd</title>
    <script src="${pageContext.request.contextPath}/Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#update").click(function () {
                var oldPwd = $("#oldPwd").val();
                var newPwd = $("#newPwd").val();
                var renewPwd = $("#renewPwd").val();
                $("#oldTip").html('');
                $("#newTip").html('');
                $("#renewTip").html('');
                if (oldPwd === "") {
                    alert("原密码不能为空！");
                    $("#oldTip").css("color", "red").html('原密码不能为空');
                } else if (newPwd === "") {
                    alert("新密码不能为空！");
                    $("#newTip").css("color", "red").html('新密码不能为空');
                } else if (renewPwd === "") {
                    alert("确认新密码不能为空！");
                    $("#renewTip").css("color", "red").html('确认新密码不能为空');
                } else if (newPwd !== renewPwd) {
                    alert("两次新密码不一致！");
                    $("#newTip").css("color", "red").html('两次新密码不一致');
                    $("#renewTip").css("color", "red").html('两次新密码不一致');
                } else if (oldPwd === newPwd) {
                    alert("新旧密码不能相同！");
                    $("#newTip").css("color", "red").html('新旧密码不能相同');
                } else {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/updatePwd",
                        type: "post",
                        //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                        data: {oldPwd: oldPwd, newPwd: newPwd},
                        dataType: "json",
                        success: function (data) {
                            if ("success" === data.result) {
                                var answer = confirm("修改成功，是要现在跳转吗？");
                                var url = '${pageContext.request.contextPath}/User/login';
                                setTimeout("top.location.href='" + url + "'", 3000);
                                if (answer) {
                                    window.location = url;
                                }
                            } else if ("fail" === data.result) {
                                alert("原密码不正确！");
                                $("#oldTip").css("color", "red").html('原密码不正确');
                                $("#oldPwd").focus();
                                return false;
                            } else {
                                alert("异常！");
                                $("#oldPwd").focus();
                                return false;
                            }
                        }
                    })
                }
            })
        })
    </script>
</head>
<body>
<div class="layui-fluid" id="loginbox">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header"><h3>修改我的密码</h3></div>
                <div class="layui-card-body" pad15="">
                    <div class="layui-form">
                        <div class="layui-form-item">
                            <label class="layui-form-label">原密码</label>
                            <div class="layui-input-inline">
                                <input type="password" name="oldPwd"
                                       placeholder="请输入原密码" autocomplete="off" id="oldPwd"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="oldTip"></span></div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">新密码</label>
                            <div class="layui-input-inline">
                                <input type="password" name="newPwd"
                                       placeholder="请输入新密码" autocomplete="off" id="newPwd"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="newTip"></span></div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">确认新密码</label>
                            <div class="layui-input-inline">
                                <input type="password" name="newPwd"
                                       placeholder="请再次输入新密码" autocomplete="off" id="renewPwd"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="renewTip"></span></div>
                        </div>
                        <%--                        <div class="layui-form-item">--%>
                        <%--                            <label class="layui-form-label">邮箱</label>--%>
                        <%--                            <div class="layui-input-inline">--%>
                        <%--                                <input type="text" name="email" value="${user.user_email}"--%>
                        <%--                                       lay-verify="email"--%>
                        <%--                                       autocomplete="off"--%>
                        <%--                                       class="layui-input"/>--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                        <div class="layui-form-item" id="showmsg">
                            <div class="layui-input-block">
                                <button class="layui-btn" id="update">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重新填写</button>
                            </div>
                            <div class="layui-form-mid layui-word-aux">注意：修改成功后需要重新登录。提示框：确认则立即跳转，取消则3秒后跳转</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
