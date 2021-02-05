<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>新闻发布系统管理主页</title>
    <base href="<%=basePath%>"> <!--需添加的内容-->
    <link rel="icon" href="Static/img/OIP.jpg" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" href="Static/css/lib/left-side-menu.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/jquery-confirm.css"/>
    <script type="text/javascript" src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/left-side-menu.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery-confirm.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery.slimscroll.min.js"></script>
    <style>
        iframe {
            margin-right: 30px;
            border: dotted;
            width: -webkit-fill-available;
            height: calc(100% - 70px);
            position: absolute;
            margin-left: 218px;
            margin-top: 65px;
        }

        div.name {
            position: absolute;
            font-size: large;
            top: 18px;
            left: 70px;
            color: white;
        }

        div#top {
            background: black;
            color: white;
            width: -webkit-fill-available;
            height: 65px;
            position: absolute;
            margin-left: 218px;
        }

        #top ul {
            height: 65px;
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #000;
        }

        #top ul li {
            height: 65px;
            float: left;
            left: 50px;
        }

        #top ul li a {
            display: block;
            color: white;
            text-align: center;
            padding: 23px 16px;
            text-decoration: none;
        }

        #top ul li a:hover:not(.active) {
            background-color: #0b2e13;
        }

        span#clock {
            color: red;
            font-size: large;
        }
    </style>
    <script>
        function logOut() {

            $.confirm({
                title: '请选择：',
                closeIcon:true,
                content: '直接退出本系统，还是退出系统后并转到前端主页？',
                buttons: {
                    logOut: {
                        text: "退出",
                        action:function (){
                            jump(false);
                        }
                    },
                    jump: {
                        text: "退出并跳转",
                        action: function () {
                            jump(true);
                        }
                    }
                }
            });
        }
        function jump(flag){
            $.ajax({
                url: "User/logOut",
                method: 'post',
                dataType:'text'
            })
            .done(function (){
               window.location.href= flag?"front/index.html":"back/login.html";
            });
        }

        function disptime() {
            var time = new Date(); //获得当前时间
            var year = time.getFullYear(); //获得年月日
            var month = time.getMonth()===0?1:time.getMonth(); //获得年月日
            var date = time.getDate(); //获得年月日
            var hour = time.getHours(); //获得小时、分钟、秒
            var minute = time.getMinutes();
            var second = time.getSeconds();
            if (minute < 10) //如果分钟只有1位，补0显示
                minute = "0" + minute;
            if (second < 10) //如果秒数只有1位，补0显示
                second = "0" + second;
            document.getElementById('clock').innerHTML = year + "年" + month + "月" + date + "日&nbsp&nbsp&nbsp" + hour + ":" + minute + ":" + second;
            /*设置定时器每隔1秒（1000毫秒），调用函数disptime()执行，刷新时钟显示*/
            var myTime = setTimeout("disptime()", 1000);
        }
    </script>
</head>

<body onload="disptime()">
<div id="top">
    <ul>
        <li><a href="javascript:void(0);" onclick="logOut()"><i class="my-icon my-icon_logout"></i> 退出</a></li>
        <li style="float: right"><a><span id="clock"></span></a></li>
    </ul>
</div>
<iframe name="frame_show" class="frame_show" src="${pageContext.request.contextPath}/back/dataShow"></iframe>
<div class="left-side-menu">
    <div class="lsm-expand-btn">
        <div class="lsm-mini-btn">
            <label>
                <input type="checkbox" checked="checked">
                <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="50" cy="50" r="30"/>
                    <path class="line--1" d="M0 40h62c18 0 18-20-17 5L31 55"/>
                    <path class="line--2" d="M0 50h80"/>
                    <path class="line--3" d="M0 60h62c18 0 18 20-17-5L31 45"/>
                </svg>
            </label>

        </div>
        <div class="name">新闻发布系统</div>

    </div>
    <div class="lsm-container">
        <div class="lsm-scroll">
            <div class="lsm-sidebar">
                <ul>
                    <li class="lsm-sidebar-item">
                        <a href="${pageContext.request.contextPath}/back/dataShow" target="frame_show">
                            <i class="my-icon lsm-sidebar-icon data"></i>
                            <span>数据页</span>
                            <i class="my-icon lsm-sidebar-more my-icon_right"></i>
                        </a>
                    </li>
                    <li class="lsm-sidebar-item">
                        <a href="javascript:;"><i class="my-icon lsm-sidebar-icon icon_1"></i>
                            <span>首页新闻选取</span>
                            <i class="my-icon lsm-sidebar-more my-icon_right"></i>
                        </a>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/back/sliderShow" target="frame_show"><span>轮播图新闻选取</span></a></li>
                            <li><a href="${pageContext.request.contextPath}/back/boardShow" target="frame_show"><span>板块新闻选取</span></a></li>
                            <li><a href="${pageContext.request.contextPath}/back/interShow" target="frame_show"><span>国内外新闻选取</span></a>
                            </li>
                            <%--<li class="lsm-sidebar-item">
                                <a href="javascript:;"><i class="my-icon lsm-sidebar-icon "></i><span>二级菜单</span><i class="my-icon lsm-sidebar-more"></i></a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/back/dataShow" target="frame_show"><span>test</span></a></li>
                                    <li><a href="${pageContext.request.contextPath}/back/testjsp.html" target="frame_show"><span>test</span></a></li>
                                </ul>
                            </li>--%>
                        </ul>
                    </li>

                    <li class="lsm-sidebar-item">
                        <a href="${pageContext.request.contextPath}/back/auditingShow" target="frame_show">
                            <i class="my-icon lsm-sidebar-icon icon_2"></i>
                            <span>新闻审核</span>
                            <i class="my-icon lsm-sidebar-more my-icon_right"></i>
                        </a>
                    </li>
                    <li class="lsm-sidebar-item">
                        <a href="${pageContext.request.contextPath}/back/ManageUsersShow" target="frame_show">
                            <i class="my-icon lsm-sidebar-icon icon_3"></i><span>用户管理</span>
                            <i class="my-icon lsm-sidebar-more my-icon_right"></i>
                        </a>
                    </li>
                    <li class="lsm-sidebar-item">
                        <a href="${pageContext.request.contextPath}/back/showFeedback" target="frame_show">
                            <i class="my-icon lsm-sidebar-icon feedback"></i>
                            <span>反馈信息页</span>
                            <i class="my-icon lsm-sidebar-more my-icon_right"></i>
                        </a>
                    </li>
                    <%--<li class="lsm-sidebar-item">
                        <a href="${pageContext.request.contextPath}/back/adminShow" target="frame_show">
                            <i class="my-icon lsm-sidebar-icon icon_4"></i>
                            <span>管理员个人信息</span>
                            <i class="my-icon lsm-sidebar-more my-icon_right"></i>
                        </a>
                    </li>--%>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
