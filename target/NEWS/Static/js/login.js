//import * as myModule from "lib/jquery-3.5.1.min";
function showMsg2() {
    $("#getValidateCode").show();
    $("#getValidateCode").css("backgroundColor", "#d3c5c1");
    $("#ValidateCode").show();
    $.alert({
        icon: "hint error",
        animationBounce: 2.5,
        theme: 'material',
        title: 'Error',
        content: '002邮箱密码错误，请重试！！！',
        buttons: {
            confirm: {
                text: 'OK',
                btnClass: 'btn-blue',
                keys: ['enter', 'shift']
            }
        }
    })
}

function showMsg1() {
    $("#getValidateCode").hide();
    $("#ValidateCode").hide();
    waring("001邮箱密码错误，请重试！！！");
}

function waring(s){
    $.alert({
        icon: "hint error",
        animationBounce: 2.5,
        theme: 'material',
        title: 'Error',
        content: s,
        buttons: {
            confirm: {
                text: 'OK',
                btnClass: 'btn-blue',
                keys: ['enter', 'shift']
            }
        }
    })
}


function showMsg3() {
    $.confirm({
        icon: "hint confirm",
        animationBounce: 2.5,
        theme: 'material',
        title: '注意！！!',
        content: '你的邮箱没有注册!',
        buttons: {
            confirm: {
                text: "忽略",
                action: function() {
                    console.log('忽略');
                    //$.alert('忽略!');
                }
            },
            somethingElse: {
                text: '去注册',
                btnClass: 'btn-blue',
                keys: ['enter', 'shift'],
                action: function () {
                    window.location.href = "User/enroll";
                }
            }
        }
    });
}

function PreValidate() {
    var flag = false;
    $.ajax(
        {
            url: "User/preLogin",
            dataType: "text",
            async: false,
            data: {
                userPassword: $("#psd").val(),
                userEmail: $("#email").val()
            },
            success: function (data) {
                console.log(data);
                if (parseInt(data, 10) === 0) {
                    flag = true;
                } else {
                    if (parseInt(data, 10) === 1)
                        showMsg1();
                    else if (parseInt(data, 10) === 2)
                        showMsg2();
                    else if (parseInt(data, 10) === 3)
                        showMsg3();
                }
            },
            error: function (e) {
                waring("服务器异常");
                console.log("验证码验证失败");
                console.log(e);
            }
        });
    return flag;
}

$(document).ready(function () {
    $("#email").mousemove(function () {
        if ($("#getValidateCode").css('display') === 'none') return;
        else {
            if ($("#email").val() !== "") {
                let btn = $("#getValidateCode");
                btn.css("backgroundColor", "#f6d85f");
                btn.removeAttr("disabled");
            }
        }
    });
});