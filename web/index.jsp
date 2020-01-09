<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/10/10
  Time: 8:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>图书预定系统</title>
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
int uid=Integer.parseInt(session.getAttribute("uid").toString());
    List<String> list=(List<String>)application.getAttribute("allUser");
    int onlineNum=list.size();
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

<fieldset class="typeLine">
    <legend id="typeName" style="font-size: 25px;font-family: Cambria;color: mediumaquamarine">全部</legend>
</fieldset>

<h1 id="noBook" style="position: absolute;left: 30%;top: 70%;color: crimson;visibility: hidden">
    查无此书
</h1>

<ul class="bookUl">
    <li class="bookLi">
        <img class="bookImg"/>
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>

        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(0)">
        预定</div>
        <p class="bookId" style="visibility: hidden;" ></p>

    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(1)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(2)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(3)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(4)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
</ul>
<ul class="bookUl2">
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(5)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(6)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(7)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(8)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
    <li class="bookLi">
        <img class="bookImg" />
        <div style="line-height: 30px;">
            <p class="bookName"></p>
            <br><p class="author"></p>
            <br><p class="star"></p>
            <br><p class="peopleNum"></p>
        </div>
        <div class="borrowStatus" style="background-color: mediumseagreen"></div>
        <br><div class="borrow" onclick="borrowMethond(9)">预定</div>
        <p class="bookId" style="visibility: hidden;"></p>
    </li>
</ul>

<div id="lastButton" class="pageDis">上一页</div>
<p id="currentPage" style="position: absolute;top: 156%;left: 33%;font-family: Cambria">1</p>
<p style="position: absolute;top: 156%;left: 34%;font-family: Cambria">/</p>
<p id="allPage" style="position: absolute;top: 156%;left: 35%;font-family: Cambria">99</p>
<div id="nextButton" class="pageDis" style="left: 39%">下一页</div>

<div style="position: absolute;top: 157%;width: 7%;height: 4%;left:48%;border:1px solid #ccc;
    border-radius: 4px;box-shadow: 0px 5px 5px #ccc">
    <input id="searchPage" style="position: absolute;border: none;width: 95%;height: 95%;left: 2%" placeholder="请输入页数">
</div>
<div id="confirmPage" class="pageDis" style="left: 56%;height: 4.5%;">确定</div>


<h2 id="chinaHistory" style="position: absolute;top: 50%;left: 75%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">中国历史</h2>
<h2 id="chinaLiterature" style="position: absolute;top: 65%;left: 75%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">中国文学</h2>
<h2 id="internet" style="position: absolute;top: 80%;left: 75%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">互联网</h2>
<h2 id="life" style="position: absolute;top: 95%;left: 75%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">生活</h2>
<h2 id="poetry" style="position: absolute;top: 110%;left: 75%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">诗歌</h2>
<h2 id="art" style="position: absolute;top: 50%;left: 90%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">艺术</h2>
<h2 id="philosophy" style="position: absolute;top: 65%;left: 90%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">哲学</h2>
<h2 id="politics" style="position: absolute;top: 80%;left: 90%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">政治</h2>
<h2 id="programing" style="position: absolute;top: 95%;left: 90%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">编程</h2>
<h2 id="investment" style="position: absolute;top: 110%;left: 90%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">投资</h2>
<h2 id="allbook" style="position: absolute;top: 125%;left: 82.5%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">全部</h2>
<h2 style="position: absolute;top: 150%;left: 79.5%;color: mediumaquamarine;font-family: Cambria;cursor: pointer">在线人数:</h2>
<h2 id="onlineNum" style="position: absolute;top: 150.5%;left: 86.5%;color: mediumaquamarine;font-family: Cambria;cursor: pointer"><%=onlineNum%></h2>
<div class="search">
    <input id="searchBookName" class="searchInput" placeholder="请输入书名">
    <div id="search" class="searchIcon">
        <img class="searchImg" src="images/search.png">
    </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath }/js/jQuery.js"></script>

<!--首页js!-->
<script type="text/javascript">
    var bookImg=document.getElementsByClassName("bookImg");
    var bookName=document.getElementsByClassName("bookName");
    var author=document.getElementsByClassName("author");
    var star=document.getElementsByClassName("star");
    var peopleNum=document.getElementsByClassName("peopleNum");
    var currentPage=document.getElementById("currentPage");
    var allPage=document.getElementById("allPage");
    var lastButton=document.getElementById("lastButton");
    var nextButton=document.getElementById("nextButton");
    var userId="<%=uid%>";
    var typeMap=new Map();
    typeMap.set("中国历史",1);
    typeMap.set("中国文学",2);
    typeMap.set("哲学",3);
    typeMap.set("诗歌",4);
    typeMap.set("政治",5);
    typeMap.set("艺术",6);
    typeMap.set("生活",7);
    typeMap.set("互联网",8);
    typeMap.set("编程",9);
    typeMap.set("投资",10);

    var type="all";
    var isAll=1;

    $("#managePage").click(function () {
        window.location.href="manage.jsp";
    });
    $("#personalPage").click(function () {
        window.location.href="personal.jsp";
    });
    $("#borrowPage").click(function () {
        window.location.href="borrow.jsp";
    });

    var firstData={"op":"QueryAll","page":parseInt(currentPage.innerText)};
    RequestData("/j2ee/IndexServlet",firstData);
    if(isAll==1) {
        lastButtonEv("all", 0, 1);
        nextButtonEv("all", 0, 99);
    }

    /*if (currentPage.innerText==1){
        lastButton.disabled=true;
        lastButton.style.backgroundClip="#ccc";
        lastButton.style.cursor="not-allowed";
    }else if (currentPage.innerText==99){
        nextButton.disabled=true;
        nextButton.style.backgroundClip="#ccc";
        nextButton.style.cursor="not-allowed";
    }*/

    //上一页
    function lastButtonEv(type,val,i) {
        lastButton.onclick = function (ev) {
            var a = parseInt(currentPage.innerText);
            if (a > i) {
                a = a - 1;
                currentPage.innerHTML = a;
                if (type=="all") {
                    data = {"op": "QueryAll", "page": a};
                    RequestData("/j2ee/IndexServlet", data);
                }else {
                    data={"op":"QueryType","page":a,"type":val};
                    RequestData("/j2ee/IndexServlet", data);
                }
            }
        };
    }

    //下一页
    function nextButtonEv(type,val,i) {
        nextButton.onclick = function (ev) {
            var a = parseInt(currentPage.innerText);
            if (a < i) {
                a = a + 1;
                currentPage.innerHTML = a;
                if (type=="all") {
                    data = {"op": "QueryAll", "page": a};
                    RequestData("/j2ee/IndexServlet", data);
                }else {
                    data={"op":"QueryType","page":a,"type":val};
                    RequestData("/j2ee/IndexServlet", data);
                }
            }
        };
    }

    //搜索页数
    $("#confirmPage").click(function () {
        var page=$("#searchPage").val();
        var reg = /^([1]|[1-9][0-9]*)$/;
        if(reg.test(page)==true) {
            page = parseInt(page);
            var type = $("#typeName").text();
            var data;
            var top=parseInt(document.body.scrollTop);
            if(page>parseInt(allPage.innerHTML)){
                createDialog("页数超过范围！",480,top+300);
                $("#searchPage").val("");
            }else if (type == "全部") {
                currentPage.innerHTML = page;
                data = {"op": "QueryAll", "page": page};
                RequestData("/j2ee/IndexServlet", data);
                $("#searchPage").val("");
            } else {
                currentPage.innerHTML = page;
                data = {"op": "QueryType", "page": page, "type": typeMap.get(type)};
                RequestData("/j2ee/IndexServlet", data);
                $("#searchPage").val("");
            }
        }else{
            page = parseInt(page);
            var top=parseInt(document.body.scrollTop);
            if (page==0){
                createDialog("页数大于0！",480,top+300);
                $("#searchPage").val("");
            }else {
                createDialog("只能输入数字！", 480, top + 300);
                $("#searchPage").val("");
            }
        }
    });


    $("#chinaHistory").click(function () {
        $("#typeName").text("中国历史");
        TypeBook(1);
    });

    $("#chinaLiterature").click(function () {
        $("#typeName").text("中国文学");
        TypeBook(2);
    });

    $("#philosophy").click(function () {
        $("#typeName").text("哲学");
        TypeBook(3);
    });

    $("#poetry").click(function () {
        $("#typeName").text("诗歌");
        TypeBook(4);
    });

    $("#politics").click(function () {
        $("#typeName").text("政治");
        TypeBook(5);
    });

    $("#art").click(function () {
        $("#typeName").text("艺术");
        TypeBook(6);
    });

    $("#life").click(function () {
        $("#typeName").text("生活");
        TypeBook(7);
    });

    $("#internet").click(function () {
        $("#typeName").text("互联网");
        TypeBook(8);
    });

    $("#programing").click(function () {
        $("#typeName").text("编程");
        TypeBook(9);
    });

    $("#investment").click(function () {
        $("#typeName").text("投资");
        TypeBook(10);
    });

    $("#allbook").click(function () {
       $("#typeName").text("全部");
        allPage.innerHTML=99;
        currentPage.innerHTML=1;
        var firstData={"op":"QueryAll","page":1};
        RequestData("/j2ee/IndexServlet",firstData);
            lastButtonEv("all", 0, 1);
            nextButtonEv("all", 0, 99);
    });


    function TypeBook(type) {
        isAll=0;
        allPage.innerHTML=10;
        currentPage.innerHTML=1;
        var firstData={"op":"QueryType","page":parseInt(currentPage.innerText),"type":type};
        RequestData("/j2ee/IndexServlet", firstData);
        lastButtonEv("history",type,1);
        nextButtonEv("history",type,10);
    }

    $("#search").click(function () {
        var data={"op":"QueryBookName","bookName":$("#searchBookName").val()};
        $.ajax({
            url:"/j2ee/IndexServlet",
            type:"post",
            dataType:"json",
            data:data,
            success:function (data) {
                isAll=0;
                var length=0;
                for (var i in data){
                    length++;
                }
                var page=0;
                page=Math.ceil(length/10);
                currentPage.innerHTML=1;
                allPage.innerHTML=page;
                var len=0;
                if(length==0){
                    $("#noBook").css("visibility","visible");
                }else{
                    $("#noBook").css("visibility","hidden");
                }
                if (length>=10){
                    len=10;
                    for (var i=0;i<10;i++){
                        $(".bookLi")[i].style.visibility="visible";
                    }
                } else {
                    len=length;
                    for (var j=len;j<10;j++){
                        $(".bookLi")[j].style.visibility="hidden";
                    }
                }
                for (var i=0;i<len;i++){
                    if (data[i].isBorrow=="false") {
                        $(".borrowStatus")[i].style.backgroundColor="mediumseagreen";
                        $(".borrowStatus")[i].innerHTML="可预定";
                    }else {
                        $(".borrowStatus")[i].style.backgroundColor="red";
                        $(".borrowStatus")[i].innerHTML="已预定";
                    }
                    $(".bookId")[i].innerHTML=data[i].id;
                    bookImg[i].src=data[i].url;
                    bookName[i].innerHTML="书名:"+data[i].bookName;
                    author[i].innerHTML="作者:"+data[i].author;
                    star[i].innerHTML="评分:"+data[i].mark;
                    peopleNum[i].innerHTML="评价人数:"+data[i].peopleNumber;
                }
                nextButton.onclick=function (ev) {
                    var a = parseInt(currentPage.innerText);
                    if (a<page){
                        a=a+1;
                        currentPage.innerHTML = a;
                        var len=10;
                        if (a==page){
                            len=length-(a-1)*10
                            if (len==10){
                                len=10;
                                for (var i=0;i<10;i++){
                                    $(".bookLi")[i].style.visibility="visible";
                                }
                            } else {
                                len=len;
                                for (var j=len;j<10;j++){
                                    $(".bookLi")[j].style.visibility="hidden";
                                }
                            }
                        }
                        for (var i=0;i<len;i++){
                            if (data[i].isBorrow=="false") {
                                $(".borrowStatus")[i].style.backgroundColor="mediumseagreen";
                                $(".borrowStatus")[i].innerHTML="可预定";
                            }else {
                                $(".borrowStatus")[i].style.backgroundColor="red";
                                $(".borrowStatus")[i].innerHTML="已预定";
                            }
                            $(".bookId")[i].innerHTML=data[i].id;
                            bookImg[i].src=data[i+(a-1)*10].url;
                            bookName[i].innerHTML="书名:"+data[i+(a-1)*10].bookName;
                            author[i].innerHTML="作者:"+data[i+(a-1)*10].author;
                            star[i].innerHTML="评分:"+data[i+(a-1)*10].mark;
                            peopleNum[i].innerHTML="评价人数:"+data[i+(a-1)*10].peopleNumber;
                        }
                    }
                };
                lastButton.onclick=function (ev) {
                    var a = parseInt(currentPage.innerText);
                    if (a>1){
                        a=a-1;
                        for (var i=0;i<10;i++){
                            $(".bookLi")[i].style.visibility="visible";
                        }
                        currentPage.innerHTML = a;
                        for (var i=0;i<10;i++) {
                            if (data[i].isBorrow=="false") {
                                $(".borrowStatus")[i].style.backgroundColor="mediumseagreen";
                                $(".borrowStatus")[i].innerHTML="可预定";
                            }else {
                                $(".borrowStatus")[i].style.backgroundColor="red";
                                $(".borrowStatus")[i].innerHTML="已预定";
                            }
                            $(".bookId")[i].innerHTML=data[i].id;
                            bookImg[i].src=data[i+(a-1)*10].url;
                            bookName[i].innerHTML="书名:"+data[i+(a-1)*10].bookName;
                            author[i].innerHTML="作者:"+data[i+(a-1)*10].author;
                            star[i].innerHTML="评分:"+data[i+(a-1)*10].mark;
                            peopleNum[i].innerHTML="评价人数:"+data[i+(a-1)*10].peopleNumber;
                        }
                    }
                }
            }
        });
    });


    function RequestData(url,data) {
        $.ajax({
            url:url,
            type:"post",
            dataType:"json",
            data:data,
            success:function (data) {
                $("#noBook").css("visibility","hidden");
                var len=data.length;
                var length=0;
                if (len>=10) {
                    length=10;
                    for (var i=0;i<10;i++){
                        $(".bookLi")[i].style.visibility="visible";
                    }
                }else {
                    length=len;
                    for (var j=len;j<10;j++){
                        $(".bookLi")[j].style.visibility="hidden";
                    }
                }
                for (var i = 0; i < len; i++) {
                    if (data[i].isBorrow=="false") {
                        $(".borrowStatus")[i].style.backgroundColor="mediumseagreen";
                        $(".borrowStatus")[i].innerHTML="可预定";
                    }else {
                        $(".borrowStatus")[i].style.backgroundColor="red";
                        $(".borrowStatus")[i].innerHTML="已预定";
                    }
                    $(".bookId")[i].innerHTML=data[i].id;
                    bookImg[i].src = data[i].url;
                    bookName[i].innerHTML = "书名:" + data[i].bookName;
                    author[i].innerHTML = "作者:" + data[i].author;
                    star[i].innerHTML = "评分:" + data[i].mark;
                    peopleNum[i].innerHTML = "评价人数:" + data[i].peopleNumber;
                }
            },
            error:function (xhr) {
                alert(xhr);
            }
        })
    }

        //借书事件监听
    function borrowMethond(i){
        var top=parseInt(document.body.scrollTop);
        if ($(".borrowStatus")[i].innerHTML=="已预定"){
            createDialog("书籍已被预定!", 480,top+300);
        }else {
            var bookid=parseInt($(".bookId")[i].innerHTML)
            $.ajax({
                url:"/j2ee/BorrowServlet",
                type:"post",
                data:{"uid":userId,"bookid":bookid,"op":"borrow"},
                success:function (msg) {
                    createDialog(msg,470,top+300);
                    $(".borrowStatus")[i].style.backgroundColor="red";
                    $(".borrowStatus")[i].innerHTML="已预定";
                },
                error:function (xhr) {
                    createDialog(xhr,480,top+300);
                }
            })
        }
    }

    //创建消息弹框
    function createDialog(msg,left,top) {
        var dialog=document.createElement('div');
        var text=document.createTextNode(msg);
        dialog.appendChild(text);
        dialog.style.cssText="left:"+left+"px;top:"+top+"px";
        dialog.className="dialog";
        dialog.style.opacity=0.7;
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
