<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/11/26
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>新闻审核</title>
    <base href="<%=basePath%>"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/jquery-confirm.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/iconfont.css"/>
    <script type="text/javascript" src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/bootstrap.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery-confirm.js"></script>
    <style>
        .btn:not(:disabled):not(.disabled) {
            cursor: pointer;
        }

        .table {
            table-layout: fixed;
            margin-left: auto;
            width: 75%;
            margin-right: auto;
        }

        ul.pagination.justify-content-md-end {
            margin-right: 12.5%;
            position: inherit;
            bottom: 1px;
        }

        a.page-link {
            cursor: pointer;
        }

        li.page-item.disabled {
            cursor: no-drop;
        }
        .contentDiv {
            height: 470px;
        }
        .table td, .table th {
            padding: .75rem;
            /* vertical-align: top; */
            border-top: 1px solid #dee2e6;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>
<h1>新闻审核</h1>
<table class="table table-bordered table-striped table-advance table-hover">
    <thead>
    <tr><!--添加图标-->
        <th style="width: 74px;/* width: auto */">ID</th>
        <th style="width: 352px;"> 标题</th>
        <th style="width: 90px;/* width: auto */"> 类别</th>
        <th style="width: 74px;/* width: auto */"> 状态</th>
        <th style="width: 171px;"> 提交时间</th>
        <th style="width: 235px">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${newsList}" var="news">
        <tr>
            <td>${news.newsId}</td>
            <td>${news.title}</td>
            <td>
                <c:choose>
                    <c:when test="${news.categoryId==1}">国内新闻</c:when>
                    <c:when test="${news.categoryId==2}">国外新闻</c:when>
                    <c:when test="${news.categoryId==3}">军事新闻</c:when>
                    <c:when test="${news.categoryId==4}">文化新闻</c:when>
                    <c:when test="${news.categoryId==5}">体育新闻</c:when>
                    <c:when test="${news.categoryId==6}">娱乐新闻</c:when>
                    <c:when test="${news.categoryId==7}">科技新闻</c:when>
                    <c:when test="${news.categoryId==8}">教育新闻</c:when>
                    <c:when test="${news.categoryId==9}">汽车新闻</c:when>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${news.state == 0}">未审核</c:when>
                    <c:when test="${news.state == 1}">已通过</c:when>
                    <c:when test="${news.state == 2}">未通过</c:when>
                </c:choose>
            </td>
            <td><fmt:formatDate value="${news.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td class="btn_td btn-group">
                <a class="btn btn-primary btn-sm"><i class="my-icon my-icon_check"></i>  查看</a>
                <a class="btn btn-success btn-sm"><i class="my-icon my-icon_pass"></i>  通过</a>
                <a class="btn btn-danger btn-sm"><i class="my-icon my-icon_nopass"></i>  不通过</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<nav>
    <ul class="pagination justify-content-md-end">
        <li id="li_1" class="page-item disabled"><a class="page-link">上一页</a></li>
        <li id="li_2" class="page-item disabled"><a class="page-link">首页</a></li>
        <li id="li_3" class="page-item active"><a id="a_1" class="page-link">1</a></li>
        <li id="li_4" class="page-item"><a id="a_2" class="page-link">2</a></li>
        <li id="li_5" class="page-item"><a id="a_3" class="page-link">3</a></li>
        <li id="li_6" class="page-item"><a class="page-link">尾页</a></li>
        <li id="li_7" class="page-item"><a class="page-link">下一页</a></li>
    </ul>
    <div class="input-group" style="left: 12.5%;margin-top: -55px; max-width: fit-content;">
        <div class="input-group-append">
            <span class="input-group-text">跳转到</span>
        </div>
        <div id="div_page" class="input-group-append" contenteditable="true" style="padding: .375rem .75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    min-width: 40px;"></div>
        <div class="input-group-append">
            <span class="input-group-text">页</span>
        </div>
        <div class="input-group-append" id="button-addon">
            <button class="btn btn-primary" type="button">OK</button>
        </div>
    </div>
</nav>

<div class="modal fade" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">标题</h4>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body">

            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button class="btn btn-danger" id="btnPass" data-dismiss="modal"
                        style="margin-left: 10%; margin-bottom: 10px;">通过
                </button>
                <button class="btn btn-danger" id="btnOut" data-dismiss="modal"
                        style="margin-left: 10%; margin-bottom: 10px;">不通过
                </button>
            </div>

        </div>
    </div>
</div>

<script>
    let td;
    function updateTable(code){
        td.parentElement.getElementsByTagName("td")[3].innerHTML= code===1?'已通过':'未通过';
    }

    function updateNews(id,state){
        $.confirm({
            autoClose: 'update|3000',
            content: function () {
                let self = this;
                return $.ajax({
                    url: 'back/updateNewsSate',
                    dataType: 'text',
                    method: 'post',
                    data: {'id': id, 'state': state}
                }).done(function (response) {
                    self.setContent('你已经成功修改！本页面自动关闭');
                    self.setTitle("修改成功");
                    updateTable(state);
                }).fail(function () {
                    self.setContent('服务器错误');
                });
            },
            buttons: {
                update: {text: 'OK'}
            }
        });
    }

    $(document).on('click',".table tbody tr td a", function ()  {
        td = $(this).parent()[0];
        let id = td.parentElement.getElementsByTagName("td")[0].innerHTML;
        let name = $(this).text().replace(/\s/g, "")
        if (name === "查看") {
            $.confirm({
                boxWidth: '40%',
                useBootstrap: false,
                dragWindowBorder:true,
                closeIcon:true,
                autoClose: true,
                content: function () {
                    let self = this;
                    return $.ajax({
                        url: 'back/getNewsById',
                        dataType: 'json',
                        method: 'post',
                        data: {id}
                    }).done(function (response) {
                        self.setTitle(response.title);
                        self.setContent('<div class="contentDiv">'+response.content+'</div>')
                    }).fail(function () {
                        self.buttons.pass.hide()
                        self.buttons.out.hide()
                        self.setTitle('错误');
                        self.setContent('服务器错误');
                    });
                },
                buttons: {
                    pass:{
                        text: '通过',
                        action:function (){
                            updateNews(id,1);
                        }
                    },
                    out:{
                        text: '不通过',
                        action:function (){
                            updateNews(id,2);
                        }
                    }
                }
            });
        }else if(name ==="通过") {
            updateNews(id,1);
        }else if(name ==="不通过") {
            updateNews(id,2);
        }
    });
    $(function () {

        $("a").each(function () {
            $(this).click(function (event) {
                event.preventDefault();   // 如果<a>定义了 target="_blank“ 需要这句来阻止打开新页面
            })
        });

        Date.prototype.format = function (fmt) {
            var o = {
                "M+": this.getMonth() + 1,                 //月份
                "d+": this.getDate(),                    //日
                "h+": this.getHours(),                   //小时
                "m+": this.getMinutes(),                 //分
                "s+": this.getSeconds(),                 //秒
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                "S": this.getMilliseconds()             //毫秒
            };

            if (/(y+)/.test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            }
            for (var k in o) {
                if (new RegExp("(" + k + ")").test(fmt)) {
                    fmt = fmt.replace(
                        RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                }
            }
            return fmt;
        }

        let totalPage = 7;
        let currentPage = 1;
        let requestPage = 1;

        $.ajax({
            url: 'back/countNewsAll', type: 'get', dataType: 'text'
        })
            .done(function (date) {
                totalPage = Math.ceil(date / 7);
            })
            .fail(function () {
                console.log("服务器错误！！！！");
            });

        $("#button-addon").click(function () {
            requestPage = parseInt($("#div_page").text());
            if (requestPage <= totalPage)
                change();
            else
                $.alert("请求不合法！！\n您要跳转到: " + requestPage + "页,已经超出总页数:" + totalPage);
            $("#div_page").text("");
        });     //跳转事件

        $("nav ul li a").click(function () {
            if ($(this).text() === "上一页")
                requestPage -= 1;
            else if ($(this).text() === "下一页")
                requestPage += 1;
            else if ($(this).text() === "首页")
                requestPage = 1;
            else if ($(this).text() === "尾页")
                requestPage = totalPage;
            else {
                requestPage = parseInt($(this).text());
            }
            change();
        });     //分页按钮事件

        function exchange(id){
            let idStr='未分类';
            switch (id){
                case 1:idStr='国内新闻';break;
                case 2:idStr='国外新闻';break;
                case 3:idStr='军事新闻';break;
                case 4:idStr='文化新闻';break;
                case 5:idStr='体育新闻';break;
                case 6:idStr='娱乐新闻';break;
                case 7:idStr='科技新闻';break;
                case 8:idStr='教育新闻';break;
                case 9:idStr='汽车新闻';break;
            }
            return idStr;
        }

        function change() {
            if (requestPage !== currentPage) {
                $.ajax({
                    url: 'back/queryNewsPage',
                    type: 'post',
                    dataType: 'json',
                    data: {offset: requestPage}
                })      //获取分页数据
                    .done(function (date) {
                        let str = "";
                        for (let i = 0; i < date.length; i++) {
                            let state='未审核';
                            if(date[i].state===1){
                                state='已通过';
                            }else if(date[i].state===2){
                                state='未通过';
                            }

                            str += "<tr><td> " + date[i].newsId + " </td>" +
                                "<td>" + date[i].title + "</td>" +
                                "<td>" + exchange(date[i].categoryId) + "</td>" +
                                "<td>" + state + "</td>" +
                                "<td>" + new Date(date[i].createTime).format("yyyy-MM-dd hh:mm:ss") + "</td>" +
                                "<td class=\"btn_td btn-group\"><a class=\"btn btn-primary btn-sm\"><i class='my-icon my-icon_check'></i> 查看</a>" +
                                "<a class=\"btn btn-success btn-sm\"><i class=\"my-icon my-icon_pass\"></i> 通过</a>" +
                                "<a class=\"btn btn-danger btn-sm\"><i class=\"my-icon my-icon_nopass\"></i> 不通过</a></td>" +
                                "</tr>";
                        }
                        $("tbody").empty();
                        $("tbody").html(str);
                    })
                    .fail(function () {
                        $.alert("服务器错误！！！！");
                    });

                if (requestPage === 1) {
                    $("#li_1").addClass("disabled");
                    $("#li_2").addClass("disabled");
                    $("#li_3").addClass("active");
                    $("#li_4").removeClass("active");
                    $("#li_5").removeClass("active");
                    $("#li_6").removeClass("disabled");
                    $("#li_7").removeClass("disabled");
                    $("#a_1").text(1);
                    $("#a_2").text(2);
                    $("#a_3").text(3);
                } else if (requestPage === totalPage) {
                    $("#li_1").removeClass("disabled");
                    $("#li_2").removeClass("disabled");
                    $("#li_3").removeClass("active");
                    $("#li_4").removeClass("active");
                    $("#li_5").addClass("active");
                    $("#li_6").addClass("disabled");
                    $("#li_7").addClass("disabled");
                    $("#a_1").text(totalPage - 2);
                    $("#a_2").text(totalPage - 1);
                    $("#a_3").text(totalPage);
                } else {
                    $("#a_1").text(requestPage - 1);
                    $("#a_2").text(requestPage);
                    $("#a_3").text(requestPage + 1);
                }
                if (requestPage > 1 && requestPage < totalPage) {   //全部激活
                    $("#li_1").removeClass("disabled");
                    $("#li_2").removeClass("disabled");
                    $("#li_6").removeClass("disabled");
                    $("#li_7").removeClass("disabled");

                    $("#li_3").removeClass("active");
                    $("#li_4").addClass("active");
                    $("#li_5").removeClass("active");
                }
            }
            currentPage = requestPage;
        }
    })
</script>

</body>
</html>

