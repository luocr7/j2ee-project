<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/11/13
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>personal</title>
    <link href="${pageContext.request.contextPath }/css/index.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/personal.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/login.css" type="text/css" rel="stylesheet">
    <style>
        html,body{
            -moz-user-select:none;/*火狐*/
            -webkit-user-select:none;/*webkit浏览器*/
            -ms-user-select:none;/*IE10*/
            -khtml-user-select:none;/*早期浏览器*/
            user-select:none;
        }
    </style>
</head>
<body>
<%String role=session.getAttribute("role").toString();
String grade=null;
if(role.equals("user")) {
    grade = session.getAttribute("grade").toString();
}
%>
<div class="Nav">
    <H1 class="NavH">图书预定系统</H1>
    <%if (role.equals("admin")){%>
    <H2 id="indexPage" class="NavH2" style="left: 52%;">首页</H2>
    <H2 id="borrowPage" class="NavH2" style="left: 60%">预定信息</H2>
    <%}else {%>
    <H2 id="indexPage" class="NavH2" style="left: 62%;">首页</H2>
    <H2 id="borrowPage" class="NavH2" style="left: 70%">预定信息</H2>
    <%}%>

    <%if (role.equals("admin")){%>
    <H2 id="managePage" class="NavH2" style="left: 70%">书籍管理</H2>
    <%}%>

    <H2 id="personalPage" class="NavH2">个人信息</H2>
    <form action="/j2ee/Logout" method="post">
        <input class="NavH2" value="注销" style="left:90%;border:none;background-color: mediumaquamarine;
        top:29.5%;font-weight: 700;font-size: 24px;" type="submit">
    </form>
</div>


<fieldset class="typeLine" style="position: absolute;width: 30%;height: 70%;left: 15%;top: 20%">
    <legend style="font-size: 25px;font-family: Cambria;color:mediumaquamarine;">个人信息</legend>
    <table style="line-height: 60px;padding-top: 50px">
        <tr>
            <td class="Msgbox">
                姓 名:<input class="inputStyle" id="uName">
            </td>
        </tr>
        <tr>
            <td class="Msgbox">
                学 号/工 号:<input class="inputStyle" readonly="true" id="uAccount">
            </td>
        </tr>
        <tr>
            <td class="Msgbox">
                专 业:<input class="inputStyle" id="uMajor">
            </td>
        </tr>
        <%if (role.equals("user")){%>
        <tr>
            <td class="Msgbox">
                班 级:<input class="inputStyle" id="uGrade">
            </td>
        </tr>
            <%}%>
        <div id="update" class="pageDis" style="left: 180px;top: 380px;position: relative;width: 70px;
                    height: 40px;background-color: mediumaquamarine">修改</div>
    </table>
</fieldset>

<fieldset class="typeLine" style="position: absolute;width: 30%;height: 70%;left: 55%;top: 20%">
    <legend style="font-size: 25px;font-family: Cambria;color:mediumaquamarine;">修改密码</legend>
    <table style="line-height: 60px;padding-top: 50px">
        <tr>
            <td class="Msgbox">
                原 密 码:<input id="oldPassword" class="inputStyle" type="password">
            </td>
        </tr>
        <tr>
            <td class="Msgbox">
                新 密 码:<input id="newPassword" class="inputStyle" type="password">
            </td>
        </tr>
        <div id="change" class="pageDis" style="left: 180px;top: 280px;position: relative;width: 70px;
                    height: 40px;background-color: mediumaquamarine">修改</div>
    </table>
</fieldset>


<script type="text/javascript" src="${pageContext.request.contextPath }/js/jQuery.js"></script>
<script>
    $.ajax({
        url:"/j2ee/PersonalServlet",
        type:"post",
        data:{"op":"pInfo"},
        success:function (data) {
            var jsonobj=eval("("+data+")");
             $("#uName").val(jsonobj.name);
            $("#uAccount").val(jsonobj.accountNumber);
            $("#uMajor").val(jsonobj.major);
            $("#uGrade").val(jsonobj.grade);
        },
        error:function (xhr) {
             createDialog("服务器错误!",50,50);
        }
    });

    var role="<%=role%>";
    $("#borrowPage").click(function () {
        window.location.href="borrow.jsp";
    });
    $("#managePage").click(function () {
        window.location.href="manage.jsp";
    });
    $("#indexPage").click(function () {
        window.location.href="index.jsp";
    });

    $("#update").click(function () {
        var grade;
        if (role=="user"){
            grade=$(".inputStyle")[3].value;
        } else {
            grade=null;
        }
         if ($(".inputStyle")[0].value.length==0){
             createDialog("姓名不能为空!",48,50);
         } else if($(".inputStyle")[2].value.length==0){
             createDialog("专业不能为空!",48,50);
         }else if (role=="user"&&$(".inputStyle")[3].value.length==0){
             createDialog("班级不能为空!",48,50);
         }else {
             $.ajax({
                 url:"/j2ee/PersonalServlet",
                 type:"post",
                 data:{"op":"updatePersonal","major":$(".inputStyle")[2].value,"name":$(".inputStyle")[0].value,
                 "grade":grade},
                 success:function (msg) {
                     createDialog(msg,48,50);
                 },
                 error:function (xhr) {
                     createDialog(xhr,48,50);
                 }
             })
         }
    });

    $("#change").click(function () {
       if (document.getElementById("oldPassword").value.length==0){
            createDialog("请输入原密码!",48,50);
       }  else if (document.getElementById("newPassword").value.length==0){
           createDialog("请输入新密码!",48,50);
       }else{
           $.ajax({
               url:"/j2ee/PersonalServlet",
               type:"post",
               data:{"op":"changePassword","oldPassword":document.getElementById("oldPassword").value,
               "newPassword":document.getElementById("newPassword").value},
               success:function (msg) {
                   createDialog(msg,48,50);
               },
               error:function (xhr) {
                   createDialog(xhr,48,50);
               }
           })
       }
    });

    //创建消息弹框
    function createDialog(msg,left,top) {
        var dialog=document.createElement('div');
        var text=document.createTextNode(msg);
        dialog.appendChild(text);
        dialog.style.cssText="left:"+left+"%;top:"+top+"%";
        dialog.className="dialog";
        document.body.appendChild(dialog);
        function animation() {
            dialog.style.animation="break 0.2s";
        }
        function remove(){
            document.body.removeChild(dialog);
            clearTimeout(animation);
        }
        setTimeout(animation,2000);
        setTimeout(remove,2100);
        clearTimeout(remove);
    }
</script>
</body>
</html>
