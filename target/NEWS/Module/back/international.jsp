<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/11/20
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>国内外新闻</title>
    <base href="<%=basePath%>"> <!--需添加的内容-->
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap-switch.min.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/jquery-confirm.css"/>
    <script type="text/javascript" src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery-confirm.js"></script>
    <script type="text/javascript" src="Static/js/lib/bootstrap.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/bootstrap-switch.min.js"></script>
    <style>
        .bootstrap-switch {
            height: 40px;
            width: 260px;
            margin-bottom: 10px;
            margin-top: 10px;
            margin-left: 10px;
        }

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

        a.btn {
            padding: 0.05rem .75rem;
        }
    </style>
</head>
<body>
<input name="switch" type="checkbox" checked>
<div id="img_box"></div>
<table class="table table-bordered table-striped table-hover">
    <thead class="text-center thead-light">
    <tr>
        <th scope="col" style="width: 60px ">序号</th>
        <th scope="col">新闻ID</th>
        <th scope="col">新闻图片</th>
        <th scope="col">新闻标题</th>
        <th scope="col" style="width: 187px">操作</th>
    </tr>
    </thead>
    <tbody id="mainTbody">

    <c:forEach items="${picNewsList}" var="PicNews"><%--传递state为1的数据--%>
        <tr>
            <td>${picNewsList.indexOf(PicNews)}</td>
            <td>${PicNews.newsId}</td>
            <td class="img"><img height="40px" src="${PicNews.picUrl}"></td>
            <td>${PicNews.title}</td>
            <td>
                <a class="btn btn-primary"> <i class="my-icon my-icon_view"></i> 查看</a>
                <a class="btn btn-danger"> <i class="my-icon my-icon_choose"></i> 重选</a>
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
                        <th scope="col" style="width: 50px">ID</th>
                        <th scope="col" style="width: 100px">PIC</th>
                        <th scope="col" style="width: 250px">新闻标题</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${allPicNewsList}" var="PicNews"><%--传递所有选项数据--%>
                        <tr>
                            <c:if test="${PicNews.isshown == 1}">
                                <td><input type="checkbox" checked disabled/></td>
                            </c:if>

                            <c:if test="${PicNews.isshown==0}">
                                <td><input type="checkbox"/></td>
                            </c:if>
                            <td>${allPicNewsList.indexOf(PicNews)}</td>
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

<script type="text/javascript">

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

    $(document).on('click', ".table tbody tr td a", function () {
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
                alert("服务器错误！！！！");
            });
    });


    $("#btnClick").click(function () {
        let newId;
        let b;
        $("#myModal input[type='checkbox']:checked:enabled:first").each(function () {//
            b = $(this).parent().parent()[0];
            newId = $(this).parent().parent()[0].children[2].innerHTML;
        });
        $.confirm({
            title: '注意!',
            content: '操作不可撤回，请再次确认是否需要此操作？',
            buttons: {
                confirm: {
                    text: '确认',
                    action: function () {
                        if (a.children[1].innerHTML !== newId) {

                            $.ajax({
                                url: 'back/change', type: 'post', dataType: 'text',
                                data: {
                                    oldId: a.children[1].innerHTML,
                                    newId: newId
                                }
                            })
                                .done(function (date) {
                                    console.log(date);
                                    if (date === '1') {
                                        a.children[1].innerHTML = b.children[2].innerHTML;
                                        a.children[2].innerHTML = b.children[3].innerHTML;
                                        a.children[3].innerHTML = b.children[4].innerHTML;
                                    }
                                })
                                .fail(function () {
                                    alert("服务器错误！！！！");
                                })
                        }
                    }
                },
                cancel: {text: '取消'}
            }
        });
    });  //btnClick

    $("#img_box").hide();       //鼠标悬浮显示大图
    $(document).on('mouseover', "td.img img", function () {
        //console.log(this.src);
        let pic_url = this.src;
        $("#img_box").show();
        $("#img_box").append("<img src='" + pic_url + "'/>");
    });
    $(document).on('mouseout', "td.img img", function () {
        $("#img_box").empty();
        $("#img_box").hide();
    });

    function initTable(flag) {
        $.ajax({
            url: 'back/queryPicNews', data: {categoryId: flag ? 1 : 2}/*todo 国内外新闻类别*/, dataType: 'json', method: 'post',
            success: function (dataList) {
                //.log(dataList);
                fillTable(dataList);
            }
        })
    }

    function fillTable(dataLists) {
        $("#mainTbody").empty();
        let str = "";
        for (let i = 0; i < dataLists.list.length; i++) {
            //console.log(dataLists.list[i]);
            str += '<tr><td>' + i + '</td><td>' +
                dataLists.list[i].newsId + '</td><td class="img"><img height="40px" src="' +
                dataLists.list[i].picUrl + '"></td><td>' +
                dataLists.list[i].title + '</td><td><a class="btn btn-primary"><i class="my-icon my-icon_view"></i> 查看</a><a class="btn btn-danger"><i class="my-icon my-icon_choose"></i> 重选</a></td>' +
                '</tr>';
        }
        $("#mainTbody").html(str);

        $("#modalTable tbody").empty();
        str = "";
        for (let i = 0; i < dataLists.allList.length; i++) {
            if (dataLists.allList[i].isshown === 1)
                str += '<tr><td><input type="checkbox" checked disabled/></td>';
            else
                str += '<tr><td><input type="checkbox"/></td>';
            str += '<td>' + i + '</td><td>' +
                dataLists.allList[i].newsId + '</td><td class="img"><img height="40px" src="' +
                dataLists.allList[i].picUrl + '"></td><td>' +
                dataLists.allList[i].title + '</td><td><a class="btn btn-primary"><i class="my-icon my-icon_view"></i> 查看</a><a class="btn btn-danger"><i class="my-icon my-icon_choose"></i> 重选</a></td>' +
                '</tr>';
        }
        $("#modalTable tbody").html(str);
    }

    $(function () {
        $("[name='switch']").bootstrapSwitch({
            onText: "国内新闻挑选",      // 设置ON文本
            offText: "国外新闻挑选",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色(info/success/warning/danger/primary)
            offColor: "warning",  // 设置OFF文本颜色 (info/success/warning/danger/primary)
            size: "normal",    // 设置控件大小,从小到大  (mini/small/normal/large)
            // 当开关状态改变时触发
            onSwitchChange: function (event, state) {
                if (state == true) {
                    //console.log("true");
                    initTable(true);
                } else {
                    //console.log("false");
                    initTable(false);
                }
            }
        });
    });
</script>
</body>
</html>
