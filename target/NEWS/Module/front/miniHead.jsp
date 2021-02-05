<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    ul.layui-nav {
        top: -11px;
        width: fit-content;
        background: none;
    }
</style>
<div class="mini-header">
    <div class="mini-header__content">
        <div class="mini-nav-user-center">
            <div class="user-con signIn">
                <div class="item">
                    <ul class="layui-nav">
                        <li class="layui-nav-item" >
                            <a href="${pageContext.request.contextPath}/front/index.html"><img
                                    src="${pageContext.request.contextPath}/Static/img/main.png" class="layui-nav-img"/><span id="index">首页</span></a>
                        </li>
                        <c:forEach items="${requestScope.categorys}" var="category">

                            <li class="layui-nav-item" >
                                <a href="javascript:void(0);" id="ch_${comment.comment_id}"
                                   onclick="byCid(${category.category_id})">${category.category_name}
                                </a>
                            </li>
                        </c:forEach>
                        <li class="layui-nav-item layui-hide-xs">
                            <input id="key" type="text" placeholder="搜索..." autocomplete="off"
                                   class="layui-input layui-input-search">
                        </li>
                        <li class="layui-nav-item layui-hide-xs">
                            <button id="search" type="button" class="layui-btn"><i class="layui-icon layui-icon-search"></i>
                            </button>
                        </li>
                    </ul>
                </div>

            </div>
        </div>


        <div class="mini-nav-user-center">
            <div class="user-con signIn">
                <c:choose>
                    <c:when test="${sessionScope.userS!=null}">
                        <div class="item">
                            <ul class="layui-nav">
                                <li class="layui-nav-item">
                                    <a href="${pageContext.request.contextPath}/queryUserById?uid=${sessionScope.userS.userId}">
                                        <c:choose>
                                            <c:when test="${sessionScope.userS.userIcon==null}">
                                                <img src="${pageContext.request.contextPath}/Static/img/userIcon.png"
                                                     class="layui-nav-img"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${sessionScope.userS.userIcon}" class="layui-nav-img"/>
                                            </c:otherwise>
                                        </c:choose>
                                        我</a>
                                    <dl class="layui-nav-child">
                                        <dd>
                                            <a href="${pageContext.request.contextPath}/queryUser">我的资料</a>
                                        </dd>
                                        <dd><a target="_blank"
                                               href="${pageContext.request.contextPath}/toHelp">帮助与反馈</a>
                                        </dd>
                                        <dd>
                                            <a href="javascript: if(window.confirm('确定要退出登录？'))
                                            {window.location.href='${pageContext.request.contextPath}/User/logout'}">退出
                                            </a>
                                        </dd>
                                    </dl>
                                </li>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="item">
                            <a href="${pageContext.request.contextPath}/User/login"><img
                                    src="${pageContext.request.contextPath}/Static/img/userIcon.png"
                                    class="layui-nav-img"/>登录</a>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="item">
                </div>
            </div>
            <div class="upload">
                <c:if test="${sessionScope.userS!=null}">
                    <a href="javascript:void(0);" onclick="toEdit()">
                        <button type="button" class="layui-btn"><i class="layui-icon"></i>写文章</button>
                    </a>
                </c:if>

            </div>
        </div>

    </div>
</div>