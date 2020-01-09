<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/10/24
  Time: 23:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cookie[] cookies=request.getCookies();
    String userName="";
    String passWord="";
    if (cookies!=null) {
        userName = cookies[0].getValue();
        passWord = cookies[0].getValue();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<style>
    html,body{
        width: 100%;
        padding: 0;
        margin: 0;
        -moz-user-select:none;/*火狐*/
        -webkit-user-select:none;/*webkit浏览器*/
        -ms-user-select:none;/*IE10*/
        -khtml-user-select:none;/*早期浏览器*/
        user-select:none;
    }
    ::-ms-clear{
        display: none;
    }
    ::-ms-reveal{
        display: none;
    }
    h1{
        color: mediumturquoise;
        font-family: "Calisto MT";
    }
    input::-webkit-input-placeholder{
        color:#ccc;
        font-size: 16px;
    }
    ul:hover{
        cursor: pointer;
    }
    li{
        float: left;
        display: block;
        font-size: 36px;
        font-family: Jokerman;
    }
</style>
<body>

<div class="mainContainer">
    <div class="ncepuImg">

    </div>
    <div class="loginBox">
        <h1 class="loginH1">登   录</h1>
        <div  class="AccountBox">
            <div class="icon-Account"></div>
            <div class="icon-Cha" onclick="clearInput()"></div>
            <input placeholder="请输入账号" oninput="inputChange()" class="AccountInput" onfocus="ChangeborderStyle(AccountBox)"
             value="<%=userName%>"      onblur="ResumeborderStyle(AccountBox)">
        </div>
        <div class="PasswordBox">
            <div class="icon-Password"></div>
            <div class="icon-eye" onclick="HideOrVisit()"></div>
            <input placeholder="请输入密码" type="password" class="PasswordInput" onfocus="ChangeborderStyle(PasswordBox)"
            value="<%=passWord%>"       onblur="ResumeborderStyle(PasswordBox)">
        </div>
        <div class="codeBox">
            <input placeholder="验证码" class="codeInput" onfocus="ChangeborderStyle(CodeBox)"
                   onblur="ResumeborderStyle(CodeBox)">
        </div>
        <div class="createCode">
            <ul class="codeLi" onclick="initCode()" id="codeLi">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>
        <div class="vagueCode" onclick="initCode()">
            换一张
        </div>
        <div class="register" onclick="createNormalDialog('register',70,26,40,15)">
            没有账号?
        </div>
        <div class="forgetPassword" onclick="createNormalDialog('forget')">
            忘记密码?
        </div>
        <div class="loginButton" onclick="submitLogin()">
            登 录
        </div>
    </div>
</div>

<!--<div style="position: absolute;height: 70%;width: 26%;background-color: white;
    boder:1px solid #fff;
    border-radius: 6px;
    left: 40%;
    top: 10%;z-index: 2011">

</div>
<div style="position: absolute;height: 100%;width: 100%;background-color: #000;
opacity: 0.5"></div>-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jQuery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
