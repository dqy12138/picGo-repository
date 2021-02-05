<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/11/20
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>板块新闻</title>
    <base href="<%=basePath%>"> <!--需添加的内容-->

    <meta name="viewPort" content="width=device-width">
    <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.1/css/all.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="Static/css/lib/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap.min.css"/>
    <link href="Static/css/lib/bootstrapTable/bootstrap-table.min.css" rel="stylesheet">
    <link href="Static/css/lib/jquery-confirm.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/bootstrap.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery-confirm.js"></script>
    <script src="Static/js/lib/bootstrapTable/bootstrap-table.min.js"></script>
    <script src="Static/js/lib/bootstrapTable/bootstrap-table-zh-CN.min.js"></script>
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

        .btn-outline-primary {
            border: 1px blue solid;
            border-radius: 0.5em;
            margin-left: 10px;
            padding-left: 5px;
            padding-right: 5px;
        }

        input[type="checkbox"] {
            margin-top: 5px;
        }

        tr {
            text-align: center;
        }

        .modal-dialog {
            max-width: 700px;
            margin: 1.75rem auto;
        }

        .contentDiv {
            height: 470px;
        }

        .jconfirm-content {
            max-height: 450px;
        }
    </style>
</head>
<body>
<h1>选取板块新闻：</h1>
<div class="container">
    <div class="row justify-content-md-center" style="min-width: border-box">
        <div class="col col-lg-auto">
            <button type="button" class="btn btn-primary" disabled>新闻类型：</button>
        </div>

        <div class="col col-lg-auto">
            <select class="form-control">
                <option>请选择...</option>
                <option selected>军事新闻</option>
                <option>文化新闻</option>
                <option>体育新闻</option>
                <option>娱乐新闻</option>
                <option>科技新闻</option>
                <option>教育新闻</option>
                <option>汽车新闻</option>
            </select>
        </div>
        <div class="col-lg-2">
            <!--占空用-->
        </div>
        <div class="col col-lg-auto">
            <button class="btn btn-outline-primary" id="queryNews"><i class="my-icon my-icon_fly"></i> 查询
            </button>
        </div>
    </div>
</div>
<script>
    let categoryId = 1;
    $(function () {

        $("#queryNews").click(function () {
            switch ($(".form-control").val()){
                case "军事新闻": categoryId = 3; break;
                case "文化新闻": categoryId = 4; break;
                case "体育新闻": categoryId = 5; break;
                case "娱乐新闻": categoryId = 6; break;
                case "科技新闻": categoryId = 7; break;
                case "教育新闻": categoryId = 8; break;
                case "汽车新闻": categoryId = 9; break;
            }
            //....todo 还有未完成的地方

            // 内置表格渲染
            initTable();
            $(".fixed-table-border").height('0px');
            $('#locale').change(initTable)
            // 内置表格渲染

            totalFlag = false;

            $.ajax({url: 'back/getBoardNews?categoryId=' + categoryId, type: 'get', dataType: 'json'})
                .done(function (date) {
                    console.log(date);
                    let str = "";
                    for (let i = 0; i < date.length; i++) {
                        str += "<tr><td> " + i + " </td>" +
                            "<td>" + date[i].news_id + "</td>" +
                            "<td>" + date[i].title + "</td>" +
                            "<td><div class=\"btn-group\" role=\"group\"><a class=\"btn btn-primary btn-sm\"><i class=\"my-icon my-icon_view\"></i> 查看</a>" +
                            "<a class=\"btn btn-info btn-sm\"><i class=\"my-icon my-icon_update\"></i> 修改</a></div></td>" +
                            "</tr>";
                    }
                    $("#indexTbody").empty();
                    $("#indexTbody").append(str);

                })
                .fail(function () {
                    console.log("服务器错误！！！！");
                });
        }); //queryNews click

        $(".table tbody").on("click", "tr td .btn-group a", function () {
            td = $(this).parent()[0];
            let id = td.parentElement.parentElement.getElementsByTagName("td")[1].innerHTML;
            let flag = false;
            if ($(this).text().replace(/\s/g, "") === "查看") {
                flag = true;
            } else if ($(this).text().replace(/\s/g, "") === "修改") {
                flag = false;
                viewFlag = true;
            }

            if (flag) {
                $.confirm({
                    boxWidth: '40%',
                    useBootstrap: false,
                    dragWindowBorder: true,
                    content: function () {
                        let self = this;
                        return $.ajax({
                            url: 'back/getNewsById',
                            dataType: 'json',
                            method: 'post',
                            data: {id}
                        }).done(function (response) {
                            self.setTitle(response.title);
                            self.setContent('<div class="contentDiv">' + response.content + '</div>')       //无奈之举
                        }).fail(function () {
                            self.setTitle('错误');
                            self.setContent('服务器错误');
                        });
                    },
                    buttons: {
                        confirm: {
                            text: "确认",
                            btnClass: 'btn-blue'
                        }
                    }
                });
            } else {
                $("#myModal").modal("show");
            }
        });//点击事件
    })
</script>
<hr/>
<table class="table table-bordered table-striped table-hover">
    <thead class="text-center thead-light">
    <tr>
        <th scope="col" style="width: 60px ">序号</th>
        <th scope="col">新闻ID</th>
        <th scope="col">新闻标题</th>
        <th scope="col" style="width: 180px">操作</th>
    </tr>
    </thead>
    <tbody id="indexTbody">
    <c:forEach var="boardNews" items="${initBoardList}">
        <tr>
            <td>${initBoardList.indexOf(boardNews)}</td>
            <td>${boardNews.news_id}</td>
            <td>${boardNews.title}</td>
            <td>
                <div class="btn-group" role="group">
                    <a class="btn btn-primary btn-sm"><i class="my-icon my-icon_view"></i> 查看</a>
                    <a class="btn btn-info btn-sm"><i class="my-icon my-icon_update"></i> 修改</a>
                </div>
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
                <h4 class="modal-title">重新选择新闻</h4>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body">
                <div id="toolbar">
                    <button id="toAdd" class="btn btn-danger" disabled>
                        <i class="my-icon my-icon_add"></i> 确认修改
                    </button>
                </div>
                <table
                        id="table"
                        data-ajax="ajaxRequest"
                        data-toolbar="#toolbar"
                        data-show-refresh="true"
                        data-show-toggle="true"
                        data-show-fullscreen="true"
                        data-detail-view="true"
                        data-click-to-select="true"
                        data-pagination="true"
                        data-id-field="userId"
                        data-detail-formatter="detailFormatter"
                        data-page-list="[5,6,7,8,9, 10, 25, all]"
                        data-page-size="8"
                        data-side-pagination="server"
                        data-response-handler="responseHandler">
                </table>
                <script>
                    let total, totalFlag = false;

                    function ajaxRequest(params) {
                        if (!totalFlag) {
                            getData();
                            totalFlag = true;
                        }

                        $(".fixed-table-border").height(0);
                        $.ajax({
                            url: "back/queryAllNewsByCategoryIdAndPage",
                            type: "POST",
                            dataType: "json",
                            data: {offset: params.data.offset, row: params.data.limit, categoryId: categoryId},
                            success: function (rs) {
                                console.log(rs)
                                params.success({ //注意，必须返回参数 params
                                    total: total,
                                    rows: rs
                                });
                            },
                            error: function (rs) {
                                console.log("失败");
                            }
                        });

                    }

                    function getData() {
                        //debugger;
                        $.ajax({
                            url: 'back/countAllByCategoryId',
                            type: 'get',
                            dataType: 'text',
                            data: {categoryId: categoryId}
                        })
                            .done(function (date) {
                                total = date;
                            })
                            .fail(function () {
                                console.log("服务器错误！！！！");
                            });
                    }

                    var $table = $('#table')
                    var $toAdd = $('#toAdd')
                    var selections = []
                    let viewFlag = true;

                    function getIdSelections() {    //选中用的
                        return $.map($table.bootstrapTable('getSelections'), function (row) {
                            return row;
                        })
                    }

                    function responseHandler(res) {
                        $.each(res.rows, function (i, row) {
                            row.state = $.inArray(row.id, selections) !== -1
                        })
                        return res
                    }

                    function detailFormatter(index, row) {  //显示详情
                        var html = []
                        html.push('<p><b>新闻ID:</b> ' + row.news_id + '</p>')
                        html.push('<p><b>新闻标题:</b> ' + row.title + '</p>')
                        return html.join('')
                    }

                    function operateFormatter(value, row, index) {  //加载图标用的
                        return [
                            '<a class="like" href="javascript:void(0)" title="Like">',
                            '<i class="fa fa-heart"></i> 查看',
                            '</a>  '
                        ].join('')
                    }

                    window.operateEvents = {
                        'click .like': function (e, value, row, index) {    //模态框点击查看
                            console.log(JSON.stringify(row));

                            $.alert({
                                title: row.title,
                                content: row.content,
                                backgroundDismiss: true
                            });

                            //alert('You click like action, row: ' + JSON.stringify(row))
                        }
                    }

                    function initTable() {
                        $("#table").bootstrapTable("resetView");
                        $table.bootstrapTable('destroy').bootstrapTable({
                            height: 550,
                            locale: $('#locale').val(),
                            columns: [
                                {
                                    field: 'state',
                                    radio: true,
                                    align: 'center',
                                    valign: 'middle'
                                },
                                {
                                    field: "newsId",
                                    title: "新闻ID",
                                    valign: 'left'
                                },
                                {
                                    field: "title",
                                    title: "新闻标题",
                                    valign: 'left'
                                },
                                {
                                    field: 'operate',
                                    title: '操作',
                                    align: 'center',
                                    clickToSelect: false,
                                    events: window.operateEvents,
                                    formatter: operateFormatter
                                }
                            ]
                        })
                        $table.on('check.bs.table uncheck.bs.table ' +
                            'check-all.bs.table uncheck-all.bs.table',
                            function () {
                                $toAdd.prop('disabled', !$table.bootstrapTable('getSelections').length)

                                // save your data, here just save the current page
                                selections = getIdSelections()
                                // push or splice the selections if you want to save all data selections
                            })
                        $toAdd.click(function () {
                            let row = getIdSelections()
                            console.log(row);
                            //显示到前端
                            let tds = td.parentElement.parentElement.getElementsByTagName("td");
                            view(row,tds,viewFlag);
                        })
                        $toAdd.prop('disabled', true)
                    }

                   function view(row,tds,flag){
                       console.log(tds[1].textContent + "\t" + row[0].newsId);
                       if(flag){
                           $.ajax({
                               url: "back/exchangeIsShown",
                               data: {newsId20: tds[1].textContent, newsId21: row[0].newsId},
                               dataType: "text",
                               method: "post"
                           }).done(function (response) {
                               if (parseInt(response, 10) === 1) {
                                   tds[1].innerHTML = row[0].newsId;
                                   tds[2].innerHTML = row[0].title;
                                   $("#myModal").modal("hide");
                                   $toAdd.prop('disabled', true)
                                   $.alert("修改成功！！！")
                               } else {
                                   $.alert("发生未知错误，修改未完成！！！")
                               }
                           }); //修改数据库
                       }
                       viewFlag = false;
                   }
                </script>
            </div>
        </div>
    </div>
</div>

</body>
</html>