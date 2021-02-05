function login() {
    if (form1.username.value == '') {
        alert('用户名不能为空！');
        return false;
    }
    if (form1.password.value == '') {
        alert('密码不能为空！');
        return false;
    }
    if (form1.email.value == '') {
        alert('邮件地址不能为空！');
        return false;
    }
    if (form1.captcha.value == '') {
        alert('验证码不能为空！');
        return false;
    }

    var flage = false;
    $.ajax({

        url: "/NEWS_war_exploded/User/validate",
        dataType: "text",
        async: false,
        data: {
            userCode: $("#captcha").val()
        },
        success: function (data, textStatus) {
            console.log("验证码发送成功过，并成功比对");
            // console.log("返回data: " + parseInt(data, 10));
            // console.log(data);
            if (parseInt(data, 10) == 1) {
                flage = true;   //验证码正确
            } else if (parseInt(data, 10) == 2) {//验证码错误
                alert("验证码错误！");
            }
        },
        error: function (e) {
            console.log("验证码验证失败");
            console.log(e);
        }
    });
    if (!flage) {
        form1.reset();
        window.clearInterval(InterValObj);
        sendCap.value = "重新发送验证码";
        sendCap.setAttribute("disabled", "true");
        sendCap.style.background = "#d3c5c1";
    }
    return flage;
}

window.onload = function () {
    var pass = document.getElementById("password");
    pass.onfocus = function () {
        pass.type = "password";
    }
}

var captcha = document.getElementById("captcha");
var email = document.getElementById("email");
var sendCap = document.getElementById("sendCap");
var Count = 45, curCount;
var InterValObj;
email.onmouseover = function () {

    if (email.value != "") {
        sendCap.removeAttribute("disabled");
        sendCap.style.background = "#cddc39";
        sendCap.style.color = "black";
    } else {
        if ($("#sendCap").prop("disabled")) return;
        sendCap.setAttribute("disabled", "true");
        sendCap.style.background = "#d3c5c1";
    }
}
captcha.onmouseover = function () {
    if (captcha.value.length != 6) return;
    else {
        sendCap.removeAttribute("disabled");
        sendCap.style.background = "#cddc39";
        sendCap.style.color = "black";
    }
}
sendCap.onclick = function () {
    sendCap.setAttribute("disabled", "true");
    sendCap.style.background = "#d3c5c1";
    curCount = Count;
    sendCap.value = "请在" + curCount + "秒后再次获取";
    InterValObj = window.setInterval(SetRemainTime, 1000);
    sendBt();
}

function SetRemainTime() {
    if (curCount == 0) {
        window.clearInterval(InterValObj);// 停止计时器
        sendCap.removeAttribute("disabled");//移除禁用状态改为可用
        sendCap.style.background = "#cddc39";
        sendCap.value = "重新发送验证码";
    } else {
        curCount--;
        sendCap.value = "请在" + curCount + "秒后再次获取";
    }
}

function bt_check() {
    console.log("check-begin");

}

/** @type {HTMLFrameElement} */
//var send = document.getElementById("sentBT");
function sendBt() {
    console.log("begin");
    console.log($("#username").val() + "\t" + $("#password").val() + "\t" + $("#email").val());
    console.log(window.location.pathname);
    $.ajax({
        type: "post",
        url: "/NEWS_war_exploded/User/send",
        dataType: "text",
        data: {
            address: $("#email").val()
        },
        success: function (data, textStatus) {
            console.log(textStatus);
            console.log("数字data " + parseInt(data, 10));
            console.log(data);//验证码发送成功
        },
        error: function (e) {
            console.log(e);
        }
    });
    console.log("end");
}