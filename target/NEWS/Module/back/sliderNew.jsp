<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/11/20
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<%--
    todo: 选取所有带图片的新闻； ====>  列表展示<表中：标题+图片>;
--%>
<html>
<head>
    <title>轮播新闻</title>
    <base href="<%=basePath%>"> <!--需添加的内容-->
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/jquery-confirm.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/iconfont.css"/>
    <script type="text/javascript" src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery-confirm.js"></script>
    <script type="text/javascript" src="Static/js/lib/bootstrap.js"></script>
    <script>
        $(document).ready(function () {
            //有问题
            // $("input[type='checkbox']").on('click',function () {
            //     console.log(this);
            //     if ($(this).prop("checked")) {//jquery 1.6以前版本 用  $(this).attr("checked")
            //         alert("选中");
            //     } else {
            //         alert("没有选中");
            //     }
            // });
            $("a").each(function () {
                $(this).click(function (event) {
                    event.preventDefault();   // 如果<a>定义了 target="_blank“ 需要这句来阻止打开新页面
                })
            });
            let a;

            function tableAction(id) {  //用来处理选择表格的数据项
                let tr = $("#modalTable").children("tbody").children('tr');
                tr.each(function () {
                    let idTd = $(this).children('td')[2].innerText;
                    if (idTd === id) {
                        //todo 处理
                        $(this).find('input:checkbox:first').prop("checked", false);
                        $(this).find('input:checkbox:first').prop("disabled", false);
                    }
                });
            }


            $("#btnClick").click(function () {
                let newId;
                $.confirm({
                    title: '注意!',
                    content: '操作不可撤回，请再次确认是否需要此操作？',
                    buttons: {
                        confirm: {
                            text: '确认',
                            action: function () {
                                $("input[type='checkbox']:checked:enabled:first").each(function () {//
                                    newId = $(this).parent().parent()[0].children[2].innerHTML;
                                }),
                                    $.ajax({
                                        url: 'back/change', type: 'post', dataType: 'text',
                                        data: {
                                            oldId: a.children[1].innerHTML,
                                            newId: newId
                                        }
                                    })
                                        .done(function (date) {
                                            console.log(date);
                                            if (date==='1') {
                                                $("input[type='checkbox']:checked:enabled:first").each(function () {//
                                                    a.children[1].innerHTML = $(this).parent().parent()[0].children[2].innerHTML;
                                                    a.children[2].innerHTML = $(this).parent().parent()[0].children[3].innerHTML;
                                                    a.children[3].innerHTML = $(this).parent().parent()[0].children[4].innerHTML;
                                                });
                                            }
                                        })
                                        .fail(function () {
                                            alert("服务器错误！！！！");
                                        })
                            }
                        },
                        cancel: {text: '取消'}
                    }
                });
            });  //btnClick

            $(".table tbody tr td a").click(function () {
                let td = $(this).parent()[0];
                let id = td.parentElement.getElementsByTagName("td")[1].innerHTML;

                if ($(this).text().replace(/\s/g, "") === "重选") {
                    $("#myModal").modal('show');
                    $("h4.modal-title").html("重新选择");
                    $(".modal-body").html($("#modalTable"));
                    $(".modal-footer").show();
                    $("#modalTable").show();
                    tableAction(id);
                    a = td.parentNode; //.innerHTML = a.outerHTML;      //替换一行数据 td ==》 a
                    return;
                }

                $("#temp").html($("#modalTable"));
                $("#modalTable").hide();

                $.ajax({
                    url: 'back/getNewsById', type: 'post', dataType: 'json', data: {id}
                })
                    .done(function (date) {
                        $("#myModal").modal("show");
                        $("h4.modal-title").html(date.title);
                        $(".modal-body").html(date.content);
                        $(".modal-footer").hide();
                    })
                    .fail(function () {
                        $.alert("服务器错误！！！！");
                    });
            });

            $("#img_box").hide();       //鼠标悬浮显示大图
            $("td.img img").on('mouseover',function () {
                console.log(this.src);
                let pic_url = this.src;
                $("#img_box").show();
                $("#img_box").append("<img src='" + pic_url + "'/>");
            });
            $("td.img img").on('mouseout',function () {
                $("#img_box").empty();
                $("#img_box").hide();
            });
        });
    </script>
    <style>
        .table {
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            table-layout: fixed !important;
        }

        .table tbody tr td {
            min-width: 100px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .btn-primary {
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.6em;
            padding: 0.1em 0.3em;
            text-decoration: none;
        }
        a {
            cursor: pointer;
            color: #007bff;
            text-decoration: none;
            background-color: transparent;
        }
        input[type="checkbox"] {
            margin-top: 5px;
        }

        tr {
            text-align: center;
        }

        td.img {
            padding-top: 3px;
            padding-bottom: 3px;
        }

        div img { /*新闻查看里的图片大小*/
            width: 379px;
        }

        .img img {
            width: auto;
        }

        #img_box {
            border: 2px solid skyblue;
            position: absolute;
            left: 100px;
            top: 100px;
        }

        .modal-dialog {
            min-width: 576px;
            max-width: min-content;
            margin: 1.75rem auto;
        }
    </style>

</head>
<body>
<h1>轮播新闻</h1>
<div id="img_box"></div>
<table class="table table-bordered table-striped table-hover">
    <thead class="text-center thead-light">
    <tr>
        <th scope="col" style="width: 60px ">序号</th>
        <th scope="col">新闻ID</th>
        <th scope="col">新闻图片</th>
        <th scope="col">新闻标题</th>
        <th scope="col" style="width: 180px">操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${picNewsList}" var="PicNews"><%--传递state为1的数据--%>
        <tr>
            <td>${picNewsList.indexOf(PicNews)}</td>
            <td>${PicNews.newsId}</td>
            <td class="img"><img height="40px" src="${PicNews.picUrl}"></td>
            <td>${PicNews.title}</td>
            <td><a class="btn-primary"><i class="my-icon my-icon_check"></i> 查看</a>
                <a class="btn-primary"><i class="my-icon my-icon_choose"></i> 重选</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- 模态框 -->
<div class="modal fade" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">标题</h4>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body">
                <table class="table table-bordered table-striped table-hover" id="modalTable" style="display: none">
                    <thead class="text-center thead-light">
                    <tr>
                        <th style="width: 50px">#</th>
                        <th scope="col" style="width: 50px">No.</th>
                        <th scope="col" style="width: 60px">ID</th>
                        <th scope="col" style="width: 100px">PIC</th>
                        <th scope="col" style="width: 250px">新闻标题</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${picNewsListAll}" var="PicNews"><%--传递所有选项数据--%>
                        <tr>
                            <c:if test="${PicNews.isshown == 1}">
                                <td><input type="checkbox" checked disabled/></td>
                            </c:if>

                            <c:if test="${PicNews.isshown==0}">
                                <td><input type="checkbox"/></td>
                            </c:if>
                            <td>${picNewsListAll.indexOf(PicNews)}</td>
                            <td>${PicNews.newsId}</td>
                            <td class="img"><img height="40px" src="${PicNews.picUrl}"></td>
                            <td>${PicNews.title}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button class="btn btn-danger" id="btnClick" data-dismiss="modal"
                        style="margin-left: 10%; margin-bottom: 10px;">确认
                </button>
            </div>

        </div>
    </div>
</div>
<div id="temp"></div>


</body>
</html>
