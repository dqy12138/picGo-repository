<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="POJO.Users" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: We
  Date: 2020/11/26
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>用户管理</title>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="Static/js/lib/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="Static/js/lib/bootstrap.js"></script>
    <script type="text/javascript" src="Static/js/lib/jquery-confirm.js"></script>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/jquery-confirm.css"/>
    <link rel="stylesheet" type="text/css" href="Static/css/lib/bootstrap.min.css"/>
    <style>
        .btn:not(:disabled):not(.disabled) {
            cursor: pointer;
        }

        ul.pagination.justify-content-md-end {
            margin-right: 12.5%;
            position: inherit;
            bottom: 1px;
        }

        .table {
            margin-left: auto;
            width: 75%;
            margin-right: auto;
        }

        a.page-link {
            cursor: pointer;
        }

        li.page-item.disabled {
            cursor: no-drop;
        }

        a.btn.btn-sm {
            display: revert;
        }
        input[type="text"] {
            position: absolute;
            right: 56px;
            height: 23px;
            width: auto;
        }
        input.userInput{
            border:none;
        }
    </style>
    <script>
        $(function () {
            let inputChangeFlag = false;
            $("input").bind("input propertychange", function (event) {
                inputChangeFlag = true;
                console.log("inputChangeFlag: " + inputChangeFlag)
            });
            let td;
            $(".table tbody").on("click", "tr td .btn-group a", function () {
                td = $(this).parent()[0];
                let id = td.parentElement.parentElement.getElementsByTagName("td")[0].innerHTML;
                let flag = false;
                if ($(this).text().replace(/\s/g, "") === "查看") {
                    flag = true;
                } else if ($(this).text().replace(/\s/g, "") === "修改") {
                    flag = false;
                }

                $.confirm({
                    content: function () {
                        var self = this;
                        return $.ajax({
                            url: 'back/getUserById',
                            dataType: 'json',
                            method: 'post',
                            data: {id}
                        }).done(function (response) {
                            if (flag) {
                                self.setContent('UserId: <input type="text" class="userInput" disabled value="' + response.userId + '"/>');
                                self.setContentAppend('<br>UserName: <input type="text" class="userInput"  value="' + response.userName + '"/>');
                                self.setContentAppend('<br>UserPassword: <input type="text" class="userInput"  value="' + response.userPassword + '"/>');
                                self.setContentAppend('<br>UserPhone: <input type="text" class="userInput"  value="' + response.userPhone + '"/>');
                                self.setContentAppend('<br>UserAddress: <input type="text" class="userInput"  value="' + response.userAddress + '"/>');
                                self.setContentAppend('<br>UserDetail: <input type="text" class="userInput"  value="' + response.userDetail + '"/>');
                                self.setContentAppend('<br>UserEmail: <input type="text" class="userInput"  value="' + response.userEmail + '"/>');
                                self.setContentAppend('<br>UserState: <input type="text" class="userInput"  value="' + (parseInt(response.userState,10) === 1? "正常":"异常") + '"/>');
                                self.setTitle(response.userName + " 的详细信息");
                                self.buttons.confirm.setText('确认');
                            } else {
                                self.setContent('UserId: <input type="text" disabled value="' + response.userId + '"/>');
                                self.setContentAppend('<br>UserName: <input type="text" value="' + response.userName + '"/>');
                                self.setContentAppend('<br>UserPassword: <input type="text" value="' + response.userPassword + '"/>');
                                self.setContentAppend('<br>UserPhone: <input type="text" value="' + response.userPhone + '"/>');
                                self.setContentAppend('<br>UserAddress: <input type="text" value="' + response.userAddress + '"/>');
                                self.setContentAppend('<br>UserDetail: <input type="text" value="' + response.userDetail + '"/>');
                                self.setContentAppend('<br>UserEmail: <input type="text" value="' + response.userEmail + '"/>');
                                self.setContentAppend('<br>UserState: <input type="text" value="' + (parseInt(response.userState,10) === 1? "正常":"异常") + '"/>');
                                self.buttons.confirm.setText('修改');
                                self.setTitle("修改 " + response.userName + " 的详细信息");
                            }
                        }).fail(function () {
                            self.setTitle('错误');
                            self.setContent('服务器错误！');
                        });
                    },
                    closeIcon: true,
                    buttons: {
                        confirm: {
                            text: "确认",
                            btnClass: 'btn-blue',
                            action: function () {      //有效
                                if (!flag) {
                                    let date = [];
                                    $("input[type=text]").each(function () {
                                        date.push(this.value);
                                    });
                                    let str = date.toString();
                                    $.ajax({
                                        url: 'back/upDateUser',
                                        dataType: 'text',
                                        method: 'post',
                                        data: {data: str}
                                    }).done(function (response) {
                                        //todo 修改表格内容
                                        if (parseInt(response, 10) === 1) {
                                            td.parentElement.parentElement.children[0].innerText = date[0];
                                            td.parentElement.parentElement.children[1].innerText = date[1];
                                            td.parentElement.parentElement.children[2].innerText = date[6];
                                            td.parentElement.parentElement.children[3].innerText = date[7];
                                            $.alert('修改成功！');
                                        } else $.alert('修改失败！\t服务器错误');
                                    }).fail(function () {
                                        $.alert('修改失败！\t服务器错误')
                                    });
                                }
                            }
                        }
                    }
                });
            }); //响应
        })
    </script>
</head>
<body>
<h1>用户管理页</h1>

<table class="table table-bordered table-striped table-advance table-hover">
    <thead>
    <tr>
        <th>用户ID</th>
        <th>用户昵称</th>
        <th><i class="fa fa-tasks"></i> 邮箱</th>
        <th>用户状态</th>
        <th style="width: 156px">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${usersList}">
        <tr>
            <td> ${user.userId} </td>
            <td> ${user.userName} </td>
            <td> ${user.userEmail} </td>
            <c:if test="${user.userState==1}">
                <td>正常</td>
            </c:if>
            <c:if test="${user.userState!=1}">
                <td>异常</td>
            </c:if>
            <td>
                <div class="btn-group" role="group" aria-label="Basic example">
                    <a type="button" class="btn btn-primary btn-sm"><i class="my-icon my-icon_view"></i> 查看</a>
                    <a type="button" class="btn btn-info btn-sm"><i class="my-icon my-icon_update"></i> 修改</a>
                </div>
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
</nav>
<script>
    $(function () {
        // 以10为值测试
        let totalPage;
        $.ajax({
            url: 'back/countUsersAll', type: 'get', dataType: 'text'
        })
            .done(function (date) {
                console.log(date);
                totalPage = Math.ceil(date / 10);
            })
            .fail(function () {
                console.log("服务器错误！！！！");
                $.alert('修改失败！\t服务器错误')
            });

        let currentPage = 1;
        let requestPage = 1;
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

            if (requestPage !== currentPage) {

                $.ajax({
                    url: 'back/queryUsersPage',
                    type: 'post',
                    dataType: 'json',
                    data: {offset: requestPage}
                })
                    .done(function (date) {
                        console.log(date);
                        console.log(date.length);
                        let str = "";
                        for (let i = 0; i < date.length; i++) {
                            str += "<tr><td> " + date[i].userId + " </td>" +
                                "<td>" + date[i].userName + "</td>" +
                                "<td>" + date[i].userEmail + "</td>" +
                                "<td>" + (date[i].userState===1?"正常":"异常") + "</td>" +
                                "<td><div class=\"btn-group\" role=\"group\"><a class=\"btn btn-primary btn-sm\"><i class=\"my-icon my-icon_view\"></i> 查看</a>" +
                                "<a class=\"btn btn-info btn-sm\"><i class=\"my-icon my-icon_update\"></i> 修改</a></div></td>" +
                                "</tr>";
                        }
                        $("tbody").empty();
                        $("tbody").append(str);
                    })
                    .fail(function () {
                        console.log("服务器错误！！！！");
                        $.alert('修改失败！\t服务器错误')
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
        });
    })
</script>

</body>
</html>
