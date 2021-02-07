<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/12/6
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Info</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Static/js/lib/layUi/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#upUser").click(function () {
                var uid = '${sessionScope.userS.userId}';
                var uname = $("#uname").val();
                var phone = $("#phone").val();
                var address = $("#address").val();
                var detail = $("#detail").val();
                var uIcon= '/NEWS_war_exploded/'+$("#userIcon").val();
                $("#unameTip").html('');
                $("#phoneTip").html('');
                $("#addressTip").html('');
                $("#detailTip").html('');
                if (uname === "") {
                    alert("用户名不能为空！");
                    $("#unameTip").css("color", "red").html('用户名不能为空');
                } else if (phone === "") {
                    alert("手机不能为空！");
                    $("#phoneTip").css("color", "red").html('手机不能为空');
                } else if (address === "") {
                    alert("地址不能为空！");
                    $("#addressTip").css("color", "red").html('地址不能为空');
                } else if (detail === "") {
                    alert("个人介绍不能为空！");
                    $("#detailTip").css("color", "red").html('个人介绍不能为空');
                } else {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/updateUserByUId",
                        type: "post",
                        //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                        data: {
                            userId: uid,
                            userName: uname,
                            userPhone: phone,
                            userAddress: address,
                            userDetail: detail,
                            userIcon:uIcon,
                        },
                        dataType: "json",
                        success: function (data) {
                            if ("success" === data.result) {
                                alert("修改成功！");
                            } else {
                                alert("异常！");
                            }
                        }
                    })
                }
            })
        })
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header"><h3>设置我的资料</h3></div>
                <div class="layui-card-body" pad15="">
                    <div class="layui-form">
                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="uname" value="${user.userName}"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="unameTip"></span></div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">头像</label>
                            <div class="layui-upload">
                                <button type="button" class="layui-btn" id="test1">上传图片</button>
                                <div class="layui-upload-list" align="center">
                                    <img class="layui-upload-img" id="demo1" width="75" height="75">
                                    <p id="demoText"></p>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="userIcon"/>
                        <div class="layui-form-item">
                            <label class="layui-form-label">手机</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" value="${user.userPhone}"
                                       lay-verify="phone" placeholder="请输入手机号"
                                       autocomplete="off"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="phoneTip"></span></div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-inline">
                                <input type="text" id="email" value="${user.userEmail}" readonly
                                       lay-verify="email"
                                       autocomplete="off"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="eamilTip">不可修改。一般用于系统登入名</span></div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">地址</label>
                            <div class="layui-input-inline">
                                <input type="text" id="address" value="${user.userAddress}"
                                       placeholder="请输入地址"
                                       autocomplete="off"
                                       class="layui-input"/>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="addressTip"></span></div>
                        </div>
                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">个人介绍</label>
                            <div class="layui-input-block">
    <textarea id="detail" placeholder="请输入内容"
              class="layui-textarea">${user.userDetail}</textarea>
                            </div>
                            <div class="layui-form-mid layui-word-aux"><span id="detailTip"></span></div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" id="upUser">确认修改</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重新填写</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            , url: '/NEWS_war_exploded/uploadUserIcon/' //改成您自己的上传接口
            ,accept:'images'
            ,size:1024
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                }
                //上传成功
                var demoText = $('#demoText');
                demoText.html('<span style="color: #4cae4c;">上传成功</span>');

                var fileupload = $(".image");
                fileupload.attr("value",res.data.src);
                console.log(fileupload.attr("value"));
                $("#userIcon").val(res.data.src);
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });

    });
</script>
</html>
