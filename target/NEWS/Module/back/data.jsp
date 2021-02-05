<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%--
<html>
<head>
    <title>Bootstrap Table Examples</title>
    <meta charset="utf-8">

    <base href="<%=basePath%>"> <!--需添加的内容-->
    <meta name="viewPort" content="width=device-width">
    <script src="Static/js/lib/jquery-3.5.1.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="Static/js/lib/bootstrap.min.js"></script>
    <link href="Static/css/lib/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://unpkg.com/@fortawesome/fontawesome-free@5.12.1/css/all.min.css">

    <link href="Static/css/lib/bootstrapTable/bootstrap-table.min.css" rel="stylesheet">
    <script src="Static/js/lib/bootstrapTable/bootstrap-table.min.js"></script>
    <script src="Static/js/lib/bootstrapTable/bootstrap-table-zh-CN.min.js"></script>

    <style>
    </style>
</head>
<body>


<div id="toolbar">
    <button id="remove" class="btn btn-danger" disabled>
        <i class="fa fa-trash"></i> Delete
    </button>
</div>
<table
        id="table"
        data-ajax="ajaxRequest"
        data-toolbar="#toolbar"
        data-search="true"
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
        data-pagination="true"
        data-id-field="userId"
        data-page-list="[5, 10, 25, 50, 100, all]"
        data-side-pagination="server"
        data-response-handler="responseHandler">
</table>

<script>
    let total;

    function ajaxRequest(params) {
        getData();
        console.log(params);
        $.ajax({
            url: "back/queryUsersTest",
            type: "POST",
            dataType: "json",
            data: {offset: params.data.offset, limit: params.data.limit},
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
            url: 'back/countUsersAll', type: 'get', dataType: 'text'
        })
            .done(function (date) {
                total = date;
            })
            .fail(function () {
                console.log("服务器错误！！！！");
            });
    }


    var $table = $('#table')
    var $remove = $('#remove')
    var selections = []

    function getIdSelections() {    //选中用的
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.userId;
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
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>')
        })
        return html.join('')
    }

    function operateFormatter(value, row, index) {  //加载图标用的
        return [
            '<a class="like" href="javascript:void(0)" title="Like">',
            '<i class="fa fa-heart"></i>',
            '</a>  ',
            '<a class="remove" href="javascript:void(0)" title="Remove">',
            '<i class="fa fa-trash"></i>',
            '</a>'
        ].join('')
    }

    window.operateEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row))
        },
        'click .remove': function (e, value, row, index) {
            $table.bootstrapTable('remove', {   //单个删除
                field: 'userId',
                values: row.userId
            })
        }
    }


    function initTable() {
        $table.bootstrapTable('destroy').bootstrapTable({
            height: 550,
            locale: $('#locale').val(),
            columns: [
                {
                    field: 'state',
                    radio:true,
                    align: 'center',
                    valign: 'middle'
                },
                {
                    field: "userEmail",
                    title: "邮箱"
                },
                {
                    field: "userId",
                    title: "ID"
                },
                {
                    field: "userName",
                    title: "昵称"
                },
                {
                    field: "userPassword",
                    title: "密码"
                },
                {
                    field: "userState",
                    title: "状态"
                },
                {
                    field: 'operate',
                    title: 'Item Operate',
                    align: 'center',
                    clickToSelect: false,
                    events: window.operateEvents,
                    formatter: operateFormatter
                }




                // [{
                //     field: 'state',
                //     checkbox: true,
                //     rowspan: 2,
                //     align: 'center',
                //     valign: 'middle'
                // }, {
                //     title: 'Item ID',
                //     field: 'id',
                //     rowspan: 2,
                //     align: 'center',
                //     valign: 'middle',
                //     sortable: true,
                //     footerFormatter: totalTextFormatter
                // }, {
                //     title: 'Item Detail',
                //     colspan: 3,
                //     align: 'center'
                // }],
                // [{
                //     field: 'name',
                //     title: 'Item Name',
                //     sortable: true,
                //     footerFormatter: totalNameFormatter,
                //     align: 'center'
                // }, {
                //     field: 'price',
                //     title: 'Item Price',
                //     sortable: true,
                //     align: 'center',
                //     footerFormatter: totalPriceFormatter
                // }, {
                //     field: 'operate',
                //     title: 'Item Operate',
                //     align: 'center',
                //     clickToSelect: false,
                //     events: window.operateEvents,
                //     formatter: operateFormatter
                // }]
            ],

            onPageChange: function (number, size) {
                console.log(number + "\t" + size)
            },
        })
        $table.on('check.bs.table uncheck.bs.table ' +
            'check-all.bs.table uncheck-all.bs.table',
            function () {
                $remove.prop('disabled', !$table.bootstrapTable('getSelections').length)

                // save your data, here just save the current page
                selections = getIdSelections()
                // push or splice the selections if you want to save all data selections
            })
        $table.on('all.bs.table', function (e, name, args) {
            //console.log(name, args)
        })
        $remove.click(function () {
            var ids = getIdSelections()
            $table.bootstrapTable('remove', {
                field: 'userId',
                values: ids
            })
            $remove.prop('disabled', true)
        })

    }

    $(function () {
        initTable()
        $('#locale').change(initTable)
    })
</script>
</body>
</html>--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <base href="<%=basePath%>">
    <title>数据</title><!--需添加的内容-->
    <script type="text/javascript" src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script src="Static/js/lib/echarts.min.js"></script>
    <script src="Static/js/lib/vintage.min.js"></script>
</head>

<body>

<div id="main" style="height: 100%; width: 100%;">

</div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例

    function dataChange(timestamp){
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
        var D = date.getDate()
        return Y + M + D;
    }

    var date = new Array();
    var newsCount = new Array();
    var userCount = new Array();
    var feedbackCount = new Array();

    let dates = ${dataList};
    $.each(dates,function (index,value){
        date.push(dataChange(value.date));
        newsCount.push(value.newsCount);
        userCount.push(value.userCount);
        feedbackCount.push(value.feedbackCount);
    })


    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    option = {
        title: {
            text: '新闻发布系统数据概况'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                crossStyle: {
                    color: '#862a2a'
                }
            }
        },
        toolbox: {
            feature: {
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true},
            }
        },
        legend: {
            data: ['用户数', '单日新增新闻数', '反馈数']
        },
        xAxis: [
            {
                type: 'category',
                data: date,//['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                axisPointer: {
                    type: 'shadow'
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                name: '条数',
                min: 0,
                max: 50,
                interval: 2,
                axisLabel: {
                    formatter: '{value}'
                }
            }
            ,
            {
                type: 'value',
                name: '人数',
                min: 0,
                max: 50,
                interval: 2,
                axisLabel: {
                    formatter: '{value}'
                }
            }
        ],
        series: [
            {
                name: '用户数',
                type: 'line',
                data: userCount,//[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3]
            },
            {
                name: '单日新增新闻数',
                type: 'bar',
                data: newsCount,//[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
            },
            {
                name: '反馈数',
                type: 'bar',
                yAxisIndex: 1,
                data: feedbackCount,//[2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2]
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>
</html>
