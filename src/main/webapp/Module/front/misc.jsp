<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/12/20
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>misc</title>
</head>
<body>
<div class="layui-fluid" id="loginbox">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header"><h3>危险操作</h3></div>
                <div class="layui-card-body" pad15="">
                    <div class="layui-timeline-content layui-text">
                        <h3 class="layui-timeline-title">永久删除帐号</h3>
                        <ul>
                            <li class="">如果你不小心创建出了多余的帐号，或在绑定帐号的时候提示帐号被占用，你可以在帐号绑定解绑相关问题汇总中获得相关帮助。</li>
                            <li>如果你对某些内容、功能或社区规则不满意，你可以在<a target="_blank"
                                                           href="${pageContext.request.contextPath}/toHelp"
                                                           style="color: #01AAED">帮助与反馈</a>向我们提出。
                            </li>
                            <li>删除帐号前，请确保已经没有任何公开或私密文章。</li>
                            <li>删除帐号是不可逆的操作，删除后将无法恢复。</li>
                            <li>如果账号已被封号，则删除账号后原有手机号无法再次注册，你可以先「申诉解封」，或联系邮箱 xxx@xxx.com。</li>
                        </ul>
                    </div>

                    若文章尚未全部清除
                    (请点击右上角「<a target="_blank" href="javascript:void(0);" onclick="toEdit()"
                               style="color: #01AAED">写文章</a>」页，删除所有公开&私密&空文章)
                    <br/>
                    <button type="button" class="layui-btn"><i class="layui-icon"></i>注销账号</button>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
