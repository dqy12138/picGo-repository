<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>News</title>
    <base href="<%=basePath%>">
    <script src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script src="Static/js/lib/jquery-confirm.js"></script>
    <script src="Static/js/lib/bootstrap.min.js"></script>
    <script src="Static/js/easing.min.js"></script>
    <script src="Static/js/owl-carousel.min.js"></script>
    <script src="Static/js/twitterFetcher_min.js"></script>
    <script src="Static/js/jquery.newsTicker.min.js"></script>
    <script src="Static/js/modernizr.min.js"></script>
    <script src="Static/js/scripts.js"></script>
    <script src="Static/js/lib/layUi/layui.js" charset="utf-8"></script>

    <link rel="stylesheet" href="Static/css/lib/jquery-confirm.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/miniHeadStyle.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/underHeadStyle.css"/>
    <style>
        .dd_lm a {
            color: #4a5265;
        }
/*    font-weight: bolder;
    text-shadow: 1px 1px 8px #000000;*/
        .dd_lm a:visited {
            color: #4a5265;
        }

        .dd_lm a:hover {
            color: #990000;
            text-decoration: underline
        }

        .dd_time {
            color: #919191;
            float: right;
            width: 24%;
            font-size: 13px;
            _font-size: 12px;
            _font-family: "宋体";
        }

        .dd_lm {
            text-align: center;
            width: 12%;
            color: #4a5265;
            float: left;
            font-size: 15px;
            _font_size: 14px;
            _font-family: "宋体";
        }

        .dd_bt {
            color: #333;
            width: 60%;
            float: left;
            text-align: left;
            font-size: 15px;
            _font_size: 14px;
            _font-family: "宋体";
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .dd_bt a {
            color: #333
        }

        .dd_bt a:link {
            color: #333;
            text-decoration: none
        }

        .dd_bt a:hover {
            color: #990000;
            text-decoration: underline
        }

        .dd_bt a:visited {
            color: #919191;
            text-decoration: none;
        }

        .content_list {
            clear: both;
            margin: auto;
            width: 395px;
        }

        .content_list li {
            overflow: hidden;
            line-height: 26px;
        }

        ul {
            display: block;
            list-style-type: disc;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            padding: 0px;
        }

        .content_list li.nocontent {
            height: 20px;
        }

        /*.layui-nav {*/
        /*    top: -28px;*/
        /*    width: 116px;*/
        /*    position: relative;*/
        /*    !* padding: 0 20px; *!*/
        /*    !* background-color: #393D49; *!*/
        /*    color: #fff;*/
        /*    border-radius: 2px;*/
        /*    font-size: 0;*/
        /*    box-sizing: border-box;*/
        /*}*/

        .layui-nav-item a{
            font-weight: bolder;
            text-shadow: 1px 1px 8px #000000;
        }
        div#dqy {
            width: fit-content;
            height: 3100px;
            overflow: auto;
        }
    </style>

    <link rel="stylesheet" href="Static/js/lib/layUi/css/layui.css" media="all">

    <script>

        var cPage = 0;
        var uid = '${sessionScope.userS.userId}';

        function subgo(){
            $.alert({
                title:'此处没有功能',
                content:'尽吾志也而不能致者，可以无悔矣！！！',
                buttons:{
                    opt1:{
                        keys:['enter'],
                        text:'选择原谅',
                    }
                }
            })
        }

        function byCid(cid) {
            // $("#ch_" + cid).css("color",red);
            main("queryNewsByCId?cid=" + cid + "&cPage=" + cPage);
        }

        function toEdit() {
            var myForm = document.createElement("form");
            myForm.method = "post";
            myForm.target = "_blank";
            myForm.action = "${pageContext.request.contextPath}/toEdit";
            var myInput = document.createElement("input");
            myInput.setAttribute("name", "uid"); // 为input对象设置name
            myInput.setAttribute("value", uid); // 为input对象设置value
            myForm.appendChild(myInput);
            document.body.appendChild(myForm);
            myForm.submit();
            document.body.removeChild(myForm); // 提交后移除创建的form
        }

        function main(href) {
            $("#main").html('');
            $("#main").load(href);
        }

        $(function () {

            $("#search").click(function () {
                var key = $("#key").val();
                main("${pageContext.request.contextPath}/queryNewsByKey?key=" + key + "&cPage=" + cPage);
            });
            $('#key').bind('keypress', function (event) {
                if (event.keyCode === 13) {
                    $("#search").click();
                }
            });

            layui.use(['carousel', 'form'], function () {
                var carousel = layui.carousel
                    , form = layui.form;
                //图片轮播
                carousel.render({
                    elem: '#test10'
                    , width: '100%'
                    , height: '100%'
                    , interval: 5000
                });
            });
            layui.use('element', function () {
                var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

                //监听导航点击
                element.on('nav(demo)', function (elem) {
                    //console.log(elem)
                    layer.msg(elem.text());
                });
            });

            //  $("#index").trigger('click');
            $("#dqy").load('http://www.chinanews.com/scroll-news/news1.html .content_list');

        });
    </script>

</head>
<body class="bg-gray">

<jsp:include page="miniHead.jsp"/>
<jsp:include page="underHead.jsp"/>


<main class="main oh">

    <div id="main">
        <!-- Featured Posts Grid -->
        <section class="featured-posts-grid bg-white">
            <div class="container clearfix">

                <!-- Large post slider 轮播图 -->
                <div class="featured-posts-grid__item featured-posts-grid__item--lg">
                    <div class="layui-carousel" id="test10">
                        <div carousel-item="">
                            <c:forEach items="${picNewsList}" var="pic">
                                <div>
                                    <a href="${pageContext.request.contextPath}/queryNewsById?nid=${pic.newsId}">
                                        <img src="${pic.picUrl}" style="width: 100%;height: 100%"/>
                                    </a>
                                    <div class="thumb-text-holder">
                                        <h2 class="thumb-entry-title thumb-eantry-title--sm">
                                            <a>${pic.title}</a>
                                        </h2>
                                        <ul class="entry__meta">
                                            <li class="entry__meta-date">
                                                <i class="my-icon lsm-sidebar-icon data"></i>
                                                    ${pic.createTime.toGMTString()}
                                            </li>
                                        </ul>
                                    </div>
                                        <%--图片注释--%>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <%--轮播图右边2张图  ======> 定点新闻 --%>
                <div class="featured-posts-grid__item featured-posts-grid__item--sm">
                    <article class="entry featured-posts-grid__entry">
                        <div class="thumb-bg-holder" style="background-image: url(Static/img/U445P4T47D47702F980DT20201115180934.jpg);">
                            <a href="http://www.chinanews.com/gn/z/ChinaView/index.shtml" class="thumb-url"></a>
                            <div class="bottom-gradient"></div>
                        </div>

                        <div class="thumb-text-holder">
                            <h2 class="thumb-entry-title thumb-entry-title--sm">
                                <a href="http://www.chinanews.com/gn/z/ChinaView/index.shtml">尽观中国，中国新闻特别策划</a>
                            </h2>
                            <ul class="entry__meta">
                                <li class="entry__meta-date">
                                    “中国减贫奇迹”——习近平为世界展示的一种可能
                                </li>
                            </ul>
                        </div>
                    </article>
                </div>
                <div class="featured-posts-grid__item featured-posts-grid__item--sm">
                    <article class="entry featured-posts-grid__entry">
                        <div class="thumb-bg-holder" style="background-image: url(Static/img/2057.jpg);">
                            <a href="http://www.chinanews.com/gn/2020/12-22/9368324.shtml" class="thumb-url"></a><%-- todo 链接--%>
                            <div class="bottom-gradient"></div>
                        </div>

                        <div class="thumb-text-holder">
                            <h2 class="thumb-entry-title thumb-entry-title--sm">
                                <a href="http://www.chinanews.com/gn/2020/12-22/9368324.shtml">V型反转背后的关键词</a>
                            </h2>
                            <ul class="entry__meta">
                                <li class="entry__meta-date">
                                    2020年是新中国历史上极不平凡的一年。
                                </li>
                            </ul>
                        </div>
                    </article>
                </div>

            </div>
        </section> <!-- end featured posts grid -->

        <div class="main-container container mt-40" id="main-container">
            <!-- Content -->
            <div class="row">

                <div class="col-lg-8 blog__content mb-30">
                    <!-- 热点新闻Hot News -->
                    <section class="section tab-post mb-10">
                        <div class="title-wrap">
                            <h3 class="section-title">热点新闻</h3>
                        </div>

                        <div class="tabs__content tabs__content-trigger tab-post__tabs-content">
                            <div class="tabs__content-pane tabs__content-pane--active" id="tab-all">
                                <div class="row">

                                    <%--热点新闻1--%>
                                    <div class="col-md-6">
                                        <article class="entry">
                                            <div class="entry__img-holder">
                                                <a href="http://www.chinanews.com/gj/2020/12-22/9368011.shtml">
                                                    <div class="thumb-container thumb-75">
                                                        <img src="Static/img/1211.jpg" class="entry__img lazyloaded" >
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="entry__body">
                                                <div class="entry__header">
                                                    <h2 class="entry__title">
                                                        <a href="http://www.chinanews.com/gj/2020/12-22/9368011.shtml">美国当选总统拜登公开接种新冠疫苗 促民众保持警惕</a>
                                                    </h2>
                                                    <ul class="entry__meta">
                                                        <li class="entry__meta-date">
                                                            没有时间
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="entry__excerpt">
                                                    <p>12月22日电 据美联社报道，当地时间21日下午，美国当选总统拜登在特拉华州一家医院公开接种了新冠疫苗，希望借此向公众证明疫苗的安全性...</p>
                                                </div>
                                            </div>
                                        </article>
                                    </div>

                                        <%--热点新闻2--%>
                                    <div class="col-md-6">
                                        <article class="entry">
                                            <div class="entry__img-holder">
                                                <a href="http://www.chinanews.com/ty/2020/12-21/9367823.shtml">
                                                    <div class="thumb-container thumb-75">
                                                        <img src="Static/img/7065552e3a164fa9a423354c2b96ad34.jpg" class="entry__img lazyloaded" alt="">
                                                    </div>
                                                </a>
                                            </div>

                                            <div class="entry__body">
                                                <div class="entry__header">
                                                    <h2 class="entry__title">
                                                        <a href="http://www.chinanews.com/ty/2020/12-21/9367823.shtml">
                                                            完成月球之旅 北京冬奥会吉祥物“回家”
                                                        </a>
                                                    </h2>
                                                    <ul class="entry__meta">
                                                        <li class="entry__meta-date">
                                                            没有时间
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="entry__excerpt">
                                                    <p>12月17日，嫦娥五号在太空遨游23天之后，首次实现了中国地外天体采样返回。与此同时，这次嫦娥五号探测器上还搭载了国际奥委会会旗一面、国际残奥委会会旗一面、北京冬奥会和冬残奥会会旗各一面、会徽两对、吉祥物手办一对、吉祥物徽章两对。...</p>
                                                </div>
                                            </div>
                                        </article>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </section>

                    <%--国内外新闻--%>
                    <section class="section editors-picks mb-20">
                        <c:forEach var="item" items="${international}">
                            <div class="title-wrap">
                                <h3 class="section-title"><i class="my-icon news"></i> ${item.key}</h3>
                                <a href="javascript:void(0);" onclick="byCid(${item.value.get(0).categoryId})" class="all-posts-url">更多 >></a>
                            </div>
                            <div class="row">
                                    <%--左侧图片--%>
                                <div class="col-lg-7">
                                    <article class="entry">
                                        <div class="entry__img-holder">
                                            <a href="${pageContext.request.contextPath}/queryNewsById?nid=${item.value.get(0).newsId}">
                                                <div class="thumb-container thumb-75">
                                                    <img data-src="Static/img/testImg.jpg"
                                                         src="${item.value.get(0).picUrl}"
                                                         class="entry__img lazyloaded" alt="暂无数据">
                                                </div>
                                            </a>
                                        </div>
                                        <div class="entry__body">
                                            <div class="entry__header">
                                                <h2 class="entry__title">
                                                    <a href="${pageContext.request.contextPath}/queryNewsById?nid=${item.value.get(0).newsId}">
                                                            ${item.value.get(0).title}
                                                    </a>
                                                </h2>
                                                <ul class="entry__meta">
                                                    <li class="entry__meta-date">
                                                        <i class="my-icon lsm-sidebar-icon data"></i>
                                                            ${item.value.get(0).createTime}
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </article>
                                </div>
                                    <%--右侧列表--%>
                                <div class="col-lg-5">
                                    <ul class="post-list-small">
                                        <c:forEach items="${item.value}" var="picNews">
                                            <li class="post-list-small__item">
                                                <article class="post-list-small__entry">
                                                    <div class="post-list-small__body">
                                                        <h3 class="post-list-small__entry-title">
                                                            <a href="${pageContext.request.contextPath}/queryNewsById?nid=${picNews.newsId}">
                                                                    ${picNews.title}
                                                            </a>
                                                        </h3>
                                                        <ul class="entry__meta">
                                                            <li class="entry__meta-date">
                                                                <i class="my-icon lsm-sidebar-icon data"></i>
                                                                    ${picNews.createTime}
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </article>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </c:forEach>
                    </section> <!-- end editors picks -->
                    <hr>
                    <%--板块新闻--%>
                    <!-- 四小块新闻Posts from categories -->
                    <section class="section mb-0">
                        <div class="row">
                            <%--分类别的新闻--%>
                            <%--todo todo板块--%>
                            <c:forEach items="${boardNews}" var="item">
                                <div class="col-md-6 mb-40">
                                    <div class="title-wrap bottom-line bottom-line--orange">
                                        <h3 class="section-title section-title--sm"><i class="my-icon news"></i> ${item.key}</h3><%--新闻类别--%>
                                        <a href="javascript:void(0);" onclick="byCid(${item.value.get(0).category_id})" class="all-posts-url">更多 >></a>
                                    </div>
                                    <ul class="post-list-small post-list-small--border-top">
                                        <c:forEach items="${item.value}" var="boardnews">
                                            <li class="post-list-small__item">
                                                <article class="post-list-small__entry">
                                                    <div class="post-list-small__body">
                                                        <h3 class="post-list-small__entry-title">
                                                            <a href="${pageContext.request.contextPath}/queryNewsById?nid=${boardnews.news_id}">${boardnews.title}</a>
                                                        </h3>
                                                        <ul class="entry__meta">
                                                            <li class="entry__meta-date">
                                                                <i class="my-icon time"></i>
                                                                    ${boardnews.createTime.toGMTString()}
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </article>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <!-- end world -->
                            </c:forEach>

                        </div>
                    </section> <!-- end posts from categories -->
                </div> <!-- end posts -->
                <!-- 右部分广告Sidebar -->
                <aside class="col-lg-4 sidebar sidebar--right">
                    <div class="title-wrap">
                        <h3 class="section-title">实时滚动新闻</h3>
                    </div>
                    <div id="dqy"></div>
                </aside> <!-- end sidebar -->
            </div> <!-- end content -->
        </div> <!-- end main container -->
    </div>


    <!-- Footer -->
    <footer class="footer footer--dark">

        <div class="footer__bottom">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 order-lg-2 text-right text-md-center">
                        <div class="widget widget_nav_menu">
                            <ul>
                                <li><a href="javascript:void(0);" onclick="subgo();">团队</a></li>
                                <li><a href="javascript:void(0);" onclick="subgo();">联系方式</a></li>
                                <li><a href="javascript:void(0);" onclick="subgo();">隐私政策</a></li>
                                <li><a href="javascript:void(0);" onclick="subgo();">我是乱填的</a></li>
                                <li><a href="javascript:void(0);" onclick="subgo();">他可不是乱填的</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-5 order-lg-1 text-md-center">
              <span class="copyright">
                Copyright © 2020-HENU
                  <br>
                  制作单位：河南大学计算机与信息工程学院 计算机科学与技术专业 18-1班
              </span>
                    </div>
                </div>
            </div>
        </div> <!-- end bottom footer -->
    </footer> <!-- end footer -->

    <div id="back-to-top" class="">
        <a href="front/index.html#top" aria-label="Go to top">
            <i class="my-icon fig"></i>
        </a>
    </div>

</main> <!-- end main-wrapper -->
</body>
</html>
