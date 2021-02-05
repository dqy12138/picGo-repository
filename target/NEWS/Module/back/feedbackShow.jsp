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
    <link rel="stylesheet" href="https://unpkg.com/@fortawesome/fontawesome-free@5.12.1/css/all.min.css">
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
        .bootstrap-table.bootstrap4 {
            width: 80%;
            right: 5%;
            margin-left: 5% ;
        }
    </style>
</head>
<body>
<div id="toolbar">
    <button id="remove" class="btn btn-danger" disabled>
        反馈信息页：
    </button>
</div>
<table
        id="table"
        data-toolbar="#toolbar"
        data-search="true"
        data-search-on-enter-key="true"
        data-show-refresh="true"
        data-show-toggle="true"
        data-show-fullscreen="true"
        data-show-columns="true"
        data-show-columns-toggle-all="true"
        data-detail-view="true"
        data-show-export="true"
        data-click-to-select="true"
        data-detail-formatter="detailFormatter"
        data-minimum-count-columns="2"
        data-show-pagination-switch="true"
        data-pagination="true"
        data-id-field="feedback_id"
        data-page-list="[5,10, 25, 50, 100, all]"
        data-show-footer="true"
        data-side-pagination="server"
        data-url="back/feedbackData"
        <%--data-url="https://examples.wenzhixin.net.cn/examples/bootstrap_table/data"--%>
        data-response-handler="responseHandler">
</table>

<script>
    var $table = $('#table')
    var selections = []

    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.id
        })
    }

    function responseHandler(res) {
        $.each(res.rows, function (i, row) {
            row.state = $.inArray(row.id, selections) !== -1
        })
        return res
    }

    function detailFormatter(index, row) {
        var html = []
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>')
        })
        return html.join('')
    }


    function totalTextFormatter(data) {
        return 'Total'
    }

    function totalNameFormatter(data) {
        return data.length
    }

    function totalPriceFormatter(data) {
        var field = this.field
        return '$' + data.map(function (row) {
            return +row[field].substring(1)
        }).reduce(function (sum, i) {
            return sum + i
        }, 0)
    }

    function initTable() {
        $table.bootstrapTable('destroy').bootstrapTable({
            height: 550,
            locale: $('#locale').val(),
            columns:
                /*Feedback{feedback_id=1, user_id=1, content='有待优化', type='响应', createTime='null'}*/
                [{
                    field: 'feedback_id',
                    title: '反馈ID',
                    align: 'left'
                },{
                    field: 'user_id',
                    title: '反馈用户ID',
                    align: 'left'
                }, {
                    field: 'content',
                    title: '反馈信息',
                    align: 'left'
                }, {
                    field: 'type',
                    title: '反馈类型',
                    align: 'left'
                }]
        })
        $table.on('check.bs.table uncheck.bs.table ' +
            'check-all.bs.table uncheck-all.bs.table',
            function () {

                selections = getIdSelections()
                // push or splice the selections if you want to save all data selections
            })
        $table.on('all.bs.table', function (e, name, args) {
            console.log(name, args)
        })

    }

    $(function() {
        initTable()
        $('#locale').change(initTable)
    })
</script>
</body>
</html>