<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/11/13
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>manage</title>
    <link href="${pageContext.request.contextPath }/css/index.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/css/login.css" type="text/css" rel="stylesheet">
    <style>
        body,html{
            overflow:hidden;
            -moz-user-select:none;/*火狐*/
            -webkit-user-select:none;/*webkit浏览器*/
            -ms-user-select:none;/*IE10*/
            -khtml-user-select:none;/*早期浏览器*/
            user-select:none;
        }
    </style>
</head>
<body>
<%String role=session.getAttribute("role").toString();%>
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

    <fieldset class="typeLine" style="position: absolute;width: 70%;height: 70%;left: 15%;top: 20%">
        <legend style="font-size: 25px;font-family: Cambria;color:mediumaquamarine;">书籍管理</legend>

        <p style="position: absolute;font-size: 16px;font-family: Cambria;left: 15.2%;top:8%">修改(删除)书籍信息:</p>
        <div class="search" style="left: 30%;top: 10%">
            <input id="searchBookName" class="searchInput" placeholder="请输入图书编号">
            <div id="search" class="searchIcon">
                <img class="searchImg" src="images/search.png">
            </div>
        </div>

        <div id="addBook" class="pageDis" style="left: 60%;top: 9.5%;width: 8%;height: 8%">添加书籍</div>

        <ul class="bookUl" style="left: 18%;visibility: hidden">
            <li class="bookLi" style="width: 600px">
                <img class="bookImg" src="images/pic1.jpg"/>
                <div style="line-height: 30px;">
                    <p style="position: absolute;left: 45%;top: -0.4%;font-family: 华文行楷;
                    font-size: 20px;">书名:</p>
                    <input class="bookName" style="width: 80%;left: 60%;border: none;border-bottom: 1px solid #ccc"/>
                    <p style="position: absolute;left: 45%;top: 5%;font-family: 华文行楷;
                    font-size: 20px;">作者:</p>
                    <br><input class="author" style="width: 80%;left: 60%;border: none;border-bottom: 1px solid #ccc" />
                    <p style="position: absolute;left: 45%;top: 10%;font-family: 华文行楷;
                    font-size: 20px;">得分:</p>
                    <br><input class="star" style="width: 80%;left: 60%;border: none;border-bottom: 1px solid #ccc" />
                    <p style="position: absolute;left: 45%;top: 17%;font-family: 华文行楷;
                    font-size: 20px;">评价人数:</p>
                    <br><input class="peopleNum" style="width: 70%;left: 70%;border: none;border-bottom: 1px solid #ccc" />
                </div>
                <div id="update" class="pageDis" style="left: 500px;top: -90px;position: relative;width: 70px;
                    height: 40px;background-color: mediumaquamarine">修改</div>
                <div id="delete" class="pageDis" style="left: 500px;top: -50px;position: relative;width: 70px;
                    height: 40px;background-color: red">删除</div>
                <p class="bookId" style="visibility: hidden;"></p>
            </li>
        </ul>
    </fieldset>


<script type="text/javascript" src="${pageContext.request.contextPath }/js/jQuery.js"></script>
<script>
    $("#borrowPage").click(function () {
        window.location.href="borrow.jsp";
    });
    $("#personalPage").click(function () {
        window.location.href="personal.jsp";
    });
    $("#indexPage").click(function () {
        window.location.href="index.jsp";
    });

    $("#search").click(function () {
        var data={"op":"queryBook","id":$("#searchBookName").val()};
        $.ajax({
            url: "/j2ee/ManageServlet",
            type: "post",
            dataType:"json",
            data: data,
            success: function (data) {
                if(data.bookName==""){
                    createDialog("书籍不存在！",50,50);
                }else {
                    $(".bookUl")[0].style.visibility="visible";
                    $(".bookImg")[0].src = data.url;
                    $(".bookName")[0].value = data.bookName;
                    $(".bookId")[0].value = data.id;
                    $(".author")[0].value = data.author;
                    $(".star")[0].value = data.mark;
                    $(".peopleNum")[0].value = data.peopleNumber;
                }
            },
            error:function (xhr) {
                createDialog(xhr,50,50);
            }
        })
    });

    $("#update").click(function () {
        $.ajax({
            url:"/j2ee/ManageServlet",
            type:"post",
            data:{"bookid":$(".bookId")[0].value,"bookName":$(".bookName")[0].value,
            "mark":$(".star")[0].value,"peopleNumber":$(".peopleNum")[0].value,
            "author":$(".author")[0].value,"op":"updateBook"},
            success:function (msg) {
                createDialog(msg,50,50);
            },
            error:function (xhr) {
                createDialog(xhr,50,50);
            }
        })
    });

    $("#delete").click(function () {
        var dialog=document.createElement('div');
        var text=document.createTextNode("确认删除?");
        var btn1=document.createElement('div');
        var btn2=document.createElement('div');
        btn1.innerHTML="确认";
        btn1.className="pageDis";
        btn1.style.cssText="position:absolute;height:40%;width:40%;left:5%;top:55%;background-color:red;" +
            "border-radius:4px;";
        btn2.innerHTML="取消";
        btn2.className="pageDis";
        btn2.style.cssText="position:absolute;height:40%;width:40%;left:50%;top:55%;" +
            "border-radius:4px;";
        dialog.appendChild(btn2);
        dialog.appendChild(btn1);
        dialog.appendChild(text);
        dialog.style.cssText="left:45%;top:45%;height:12%;width:12%;line-height:35px;background-color:#000";
        dialog.className="dialog";
        dialog.style.opacity=0.8;
        document.body.appendChild(dialog);
        function animation() {
            dialog.style.animation="break 0.2s";
        }
        btn1.onclick=function (ev) {
            $.ajax({
                url:"/j2ee/ManageServlet",
                type:"post",
                data:{"op":"deleteBook","bookid":$(".bookId")[0].value},
                success:function (msg) {
                    document.body.removeChild(dialog);
                    createDialog(msg,50,50);
                    $(".bookUl")[0].style.visibility="hidden";
                },
                error:function (xhr) {
                    createDialog(xhr,50,50);
                }
            })
        };
        btn2.onclick=function (ev) {
            document.body.removeChild(dialog)
        };
    });

    $("#addBook").click(function () {
        var normalDialog=document.createElement('div');
        var  newBackground=document.createElement('div');
        newBackground.className="newBackground";
        newBackground.style.cssText="left:0;top:0"
        normalDialog.style.cssText="height:70%;width:40%;left:30%;top:10%;border:1px solid #ccc";
        normalDialog.className="normaldialog";

        //标题
        var h1=document.createElement('H1');
        h1.className="loginH1";
        h1.innerText="添加书籍";
        h1.style.top='3%';
        h1.style.color='mediumaquamarine';


        for (var i=0;i<6;i++){
            var box=document.createElement('div');
            box.className="AccountBox";
            box.style.cssText="width:50%;height:5%;left:25%;top:"+(i*10+20)+"%";
            var a=document.createElement('input');
            a.className="AccountInput";
            a.style.cssText="left:0;width:80%;height:80%;";
            if (i==0){
                a.placeholder="请输入书名";
            } else if (i==1){
                a.placeholder="请输入作者名";
            } else if (i==2){
                a.placeholder="请输入书籍类型";
            } else if (i==3){
                a.placeholder="请输入图片地址";
            } else if (i==4){
                a.placeholder="请输入评分";
            } else {
                a.placeholder="请输入评价人数";
            }
            box.appendChild(a);
            normalDialog.appendChild(box);
            inputEv(a,box);
        }

        //返回按钮
        var back=document.createElement('div');
        back.className="back";
        back.style.cssText="background-size:50%";
        back.onclick=function (ev) {
            normalDialog.style.animation="break 0.2s";
            function removeDialog() {
                document.body.removeChild(normalDialog);
                document.body.removeChild(newBackground);
            }
            setTimeout(removeDialog,150);
            clearTimeout(removeDialog);
        };

        //提交按钮
        var button=document.createElement('div');
        button.className="loginButton";
        button.innerText="提交";
        button.style.top="85%";
        button.style.left="25%";
        button.style.width="50%";
        button.onclick=function (ev) {
            var a=document.getElementsByClassName("AccountInput");
            if (a[0].value.length==0){
                createDialog("书名不能为空!",47,40)
            } else if (a[1].value.length==0){
                createDialog("作者名不能为空!",47,40);
            }else if (a[2].value.length==0) {
                createDialog("类型不能为空!", 47, 40);
            }else if (a[3].value.length==0) {
                createDialog("图片地址不能为空!", 47, 40);
            }else if (a[4].value.length==0) {
                createDialog("评分不能为空!", 47, 40);
            }else if (a[5].value.length==0) {
                createDialog("评价人数不能为空!", 47, 40);
            }else if(isNaN(a[4].value)){
                createDialog("评分只能为数字!",47,40);
            }
            else {
                var type=0;
                if (a[2].value=="中国历史"){
                    type=1;
                } else if (a[2].value=="中国文学"){
                    type=2;
                } else if (a[2].value=="哲学"){
                    type=3;
                } else if (a[2].value=="诗歌"){
                    type=4;
                } else if (a[2].value=="政治"){
                    type=5;
                } else if (a[2].value=="艺术"){
                    type=6;
                } else if (a[2].value=="生活"){
                    type=7;
                } else if (a[2].value=="互联网"){
                    type=8;
                } else if (a[2].value=="编程"){
                    type=9;
                } else {
                    type=10;
                }
                $.ajax({
                    url:"/j2ee/ManageServlet",
                    type:"post",
                    data:{"op":"addBook","bookName":a[0].value,"author":a[1].value,"type":type,
                    "url":a[3].value,"mark":a[4].value,"peopleNumber":a[5].value},
                    success:function (msg) {
                        createDialog(msg,47,40);
                        for (var i=0;i<6;i++){
                            a[i].value="";
                        }
                    },
                    error:function (xhr) {
                        createDialog(xhr,47,40);
                    }

                })
            }
        };

        normalDialog.appendChild(button);
        normalDialog.appendChild(back);
        normalDialog.appendChild(h1);
        document.body.appendChild(normalDialog);
        document.body.appendChild(newBackground);
    });

    //输入框监听事件
    function inputEv(name,input) {
        name.addEventListener('focus', function (ev) {
            input.style.border = '1px solid mediumturquoise';
            input.style.boxShadow = 'inset 0px 1px 1px mediumturquoise,0px 0px 8px mediumturquoise';
        });
        name.addEventListener('blur', function (evt) {
            input.style.border = '1px solid #ccc';
            input.style.boxShadow = 'none';
        });
    }


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
