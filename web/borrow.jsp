<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/11/13
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>borrow</title>
    <link href="${pageContext.request.contextPath }/css/index.css" type="text/css" rel="stylesheet">
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
int uid=Integer.parseInt(session.getAttribute("uid").toString());%>
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

<div id="borrowPag">
    <fieldset class="typeLine" style="position: absolute;width: 70%;height: 70%;left: 15%;top: 20%">
        <legend style="font-size: 25px;font-family: Cambria;color:mediumaquamarine;">预定信息</legend>
        <ul class="bookUl" style="top: 6%">
            <li class="bookLi" style="width: 600px">
                <img class="bookImg" />
                <div style="line-height: 30px;">
                    <p class="bookName" style="width: 80%;left: 60%"></p>
                    <br><p class="author" style="width: 80%;left: 60%;"></p>
                    <br><p class="star" style="width: 80%;left: 60%"></p>
                    <br><p class="peopleNum" style="width: 80%;left: 60%"></p>
                </div>
                <div id="return0" class="pageDis" style="left: 750px;top: -50px;position: relative;width: 70px;
                    height: 40px">取消预定
                </div>
                <p class="bookId" style="visibility: hidden;"></p>
            </li>
            <li class="bookLi" style="width: 600px;">
                <img class="bookImg"/>
                <div style="line-height: 30px;">
                    <p class="bookName" style="width: 80%;left: 60%"></p>
                    <br><p class="author" style="width: 80%;left: 60%;"></p>
                    <br><p class="star" style="width: 80%;left: 60%"></p>
                    <br><p class="peopleNum" style="width: 80%;left: 60%"></p>
                </div>
                <div id="return1" class="pageDis" style="left: 750px;top: -50px;position: relative;width: 70px;
                    height: 40px">取消预定
                </div>
                <p class="bookId" style="visibility: hidden;"></p>
            </li>
        </ul>
        <div id="lastButton" class="pageDis" style="width: 70px;height:40px;top: 84%;left: 40%">上一页</div>
        <p id="currentPage" style="position: absolute;top: 82.5%;left: 49%;font-family: Cambria">1</p>
        <p style="position: absolute;top: 82.5%;left: 50%;font-family: Cambria">/</p>
        <p id="allPage" style="position: absolute;top: 82.5%;left: 51%;font-family: Cambria">1</p>
        <div id="nextButton" class="pageDis" style="width: 70px;height:40px;top: 84%;left: 55%">下一页</div>
    </fieldset>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath }/js/jQuery.js"></script>
<script>
    var bookImg=document.getElementsByClassName("bookImg");
    var bookName=document.getElementsByClassName("bookName");
    var author=document.getElementsByClassName("author");
    var star=document.getElementsByClassName("star");
    var peopleNum=document.getElementsByClassName("peopleNum");
    var lastButton=document.getElementById("lastButton");
    var nextButton=document.getElementById("nextButton");
    var currentPage=document.getElementById("currentPage");
    var allPage=document.getElementById("allPage");
    $("#managePage").click(function () {
        window.location.href="manage.jsp";
    });
    $("#personalPage").click(function () {
        window.location.href="personal.jsp";
    });
    $("#indexPage").click(function () {
        window.location.href="index.jsp";
    });
    var uid="<%=uid%>";
    RequestData();

    function RequestData() {
        $.ajax({
            url: "/j2ee/BorrowServlet",
            type: "post",
            dataType: "json",
            data: {"op": "queryBorrow", "uid": uid},
            success: function (data) {
                var length = data.length;
                var page = 0;
                page = Math.ceil(length / 2);
                currentPage.innerHTML = 1;
                allPage.innerHTML = page;
                var len = 0;
                if (length >= 2) {
                    len = 2;
                    for (var i = 0; i < 2; i++) {
                        $(".bookLi")[i].style.visibility = "visible";
                    }
                } else {
                    len = length;
                    for (var j = len; j < 2; j++) {
                        $(".bookLi")[j].style.visibility = "hidden";
                    }
                }
                for (var i = 0; i < len; i++) {
                    $(".bookId")[i].innerHTML = data[i].id;
                    bookImg[i].src = data[i].url;
                    bookName[i].innerHTML = "书名:" + data[i].bookName;
                    author[i].innerHTML = "作者:" + data[i].author;
                    star[i].innerHTML = "评分:" + data[i].mark;
                    peopleNum[i].innerHTML = "评价人数:" + data[i].peopleNumber;
                }
                nextButton.onclick = function (ev) {
                    var a = parseInt(currentPage.innerText);
                    if (a < page) {
                        a = a + 1;
                        currentPage.innerHTML = a;
                        var len = 2;
                        if (a == page) {
                            len = length - (a - 1) * 2;
                            if (len == 2) {
                                len = 2;
                                for (var i = 0; i < 2; i++) {
                                    $(".bookLi")[i].style.visibility = "visible";
                                }
                            } else {
                                len = len;
                                for (var j = len; j < 2; j++) {
                                    $(".bookLi")[j].style.visibility = "hidden";
                                }
                            }
                        }
                        for (var i = 0; i < len; i++) {
                            $(".bookId")[i].innerHTML = data[i+(a-1)*2].id;
                            bookImg[i].src = data[i + (a - 1) * 2].url;
                            bookName[i].innerHTML = "书名:" + data[i + (a - 1) * 2].bookName;
                            author[i].innerHTML = "作者:" + data[i + (a - 1) * 2].author;
                            star[i].innerHTML = "评分:" + data[i + (a - 1) * 2].mark;
                            peopleNum[i].innerHTML = "评价人数:" + data[i + (a - 1) * 2].peopleNumber;
                        }
                    }
                };
                lastButton.onclick = function (ev) {
                    var a = parseInt(currentPage.innerText);
                    if (a > 1) {
                        a = a - 1;
                        for (var i = 0; i < 2; i++) {
                            $(".bookLi")[i].style.visibility = "visible";
                        }
                        currentPage.innerHTML = a;
                        for (var i = 0; i < 2; i++) {
                            $(".bookId")[i].innerHTML = data[i+(a-1)*2].id;
                            bookImg[i].src = data[i + (a - 1) * 2].url;
                            bookName[i].innerHTML = "书名:" + data[i + (a - 1) * 2].bookName;
                            author[i].innerHTML = "作者:" + data[i + (a - 1) * 2].author;
                            star[i].innerHTML = "评分:" + data[i + (a - 1) * 2].mark;
                            peopleNum[i].innerHTML = "评价人数:" + data[i + (a - 1) * 2].peopleNumber;
                        }
                    }
                }
            },
            error: function (xhr) {
                createDialog(xhr,50,50);
            }
        })
    }

$("#return0").click(function () {
    var bookid=parseInt($(".bookId")[0].innerHTML)
    $.ajax({
        url:"/j2ee/BorrowServlet",
        type:"post",
        data:{"op":"returnBook","bookid":bookid,"uid":uid},
        success:function (msg) {
            createDialog(msg,50,50);
            RequestData();
        },
        error:function (xhr) {
            createDialog(xhr,50,50);
        }
    })
});
    $("#return1").click(function () {
        var bookid=parseInt($(".bookId")[1].innerHTML)
        $.ajax({
            url:"/j2ee/BorrowServlet",
            type:"post",
            data:{"op":"returnBook","bookid":bookid,"uid":uid},
            success:function (msg) {
                createDialog(msg,50,50);
                RequestData();
            },
            error:function (xhr) {
                createDialog(xhr,50,50);
            }
        })
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
