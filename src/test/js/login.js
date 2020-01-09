var AccountBox=document.getElementsByClassName("AccountBox");
var AccountInput=document.getElementsByClassName('AccountInput');
var PasswordBox=document.getElementsByClassName('PasswordBox');
var PasswordInput=document.getElementsByClassName('PasswordInput');
var CodeInput=document.getElementsByClassName('codeInput');
var CodeBox=document.getElementsByClassName('codeBox');
var codeLi=document.getElementById('codeLi');
var loginButton=document.getElementsByClassName('loginButton');
var cha=document.getElementsByClassName('icon-Cha');
var iconEye=document.getElementsByClassName('icon-eye');
var code=[];
var normalDialog=null;
var newBackground=null;
var ishide=false;

initCode();

//封装改变样式方法
function ChangeborderStyle(className){
    className[0].style.border='1px solid mediumturquoise';
    className[0].style.boxShadow='inset 0px 1px 1px mediumturquoise,0px 0px 8px mediumturquoise';
}
//封装恢复样式方法
function ResumeborderStyle(className){
    className[0].style.border='1px solid #ccc';
    className[0].style.boxShadow='none';
}

//生成验证码
function createCode() {
    var list=[0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q'
        ,'r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
        'P','Q','R','S','T','U','V','W','X','Y','Z'];
    var n=Math.floor(Math.random()*(61));
    var number=list[n];
    return number;
}
//生成随机颜色
function randomColor() {
    var r=Math.floor(Math.random()*256);
    var g=Math.floor(Math.random()*256);
    var b=Math.floor(Math.random()*256);
    var color='#'+r.toString(16)+g.toString(16)+b.toString(16);
    return color;
}
//初始化验证码
function initCode() {
    var obj=codeLi.getElementsByTagName('li');
    for (var i=0;i<4;i++){
        var c=createCode();
        obj[i].innerHTML=c;
        obj[i].style.color=randomColor();
        code[i]=c;
    }
}
//验证码验证
function validCode(){
    var getCode=CodeInput[0].value;
    var rightCode=code.join('');
    if (getCode.toLowerCase()==rightCode.toLowerCase()){
        return true;
    } else {
        return false;
    }
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

//创建注册弹框
function createNormalDialog(operate,height,width,left,top) {
    normalDialog=document.createElement('div');
    newBackground=document.createElement('div');
    newBackground.className="newBackground";
    normalDialog.style.cssText="height:"+height+"%;width:"+width+"%;left:"+left+"%;top:"+top+"%";
    normalDialog.className="normaldialog";

    if (operate=="register") {
        //标题
        var h1=document.createElement('H1');
        h1.className="loginH1";
        h1.innerText="注册";
        h1.style.top='10%';

        //账号输入盒子
        var accountInput = document.createElement('div');
        accountInput.className = "AccountBox";
        accountInput.style.top='30%';

        //图标
        var iconAccount = document.createElement('div');
        iconAccount.className = "icon-Account";

        //叉
        var iconCha=document.createElement('div');
        iconCha.className='icon-Cha';
        iconCha.onclick=function (ev) {
            ainput.value="";
            iconCha.style.visibility="hidden";
        };

        //账号输入框
        var ainput = document.createElement('input');
        ainput.className = "AccountInput";
        ainput.placeholder = "请输入账号";
        ainput.addEventListener('input',function (ev) {
            if (ainput.value.length>0){
                iconCha.style.visibility="visible";
            } else {
                iconCha.style.visibility="hidden";
            }
        });

        //eye
        var iconEye=document.createElement('div');
        iconEye.className='icon-eye';
        var ishide=false;
        iconEye.addEventListener('mousedown',function (ev) {
            if (ishide){
                pinput.type="password";
                iconEye.style.backgroundImage="url(images/eye-close.png)";
                ishide=false;
            } else {
                pinput.type="text";
                iconEye.style.backgroundImage="url(images/eye.png)";
                ishide=true;
            }
        });

        //密码输入盒子
        var passwordInput=document.createElement('div');
        passwordInput.className="PasswordBox";
        passwordInput.style.top='45%';

        //图标
        var iconPassword=document.createElement('div');
        iconPassword.className="icon-Password";

        //密码输入框
        var pinput=document.createElement('input');
        pinput.className="PasswordInput";
        pinput.placeholder="请输入密码";
        pinput.type="password";

        //注册按钮
        var button=document.createElement('div');
        button.className="loginButton";
        button.innerText="注册";
        button.style.top="65%";
        button.onclick=function (ev) {
            if (ainput.value.length==0){
                createDialog("账号不能为空!",50,40)
            } else if (pinput.value.length==0){
                createDialog("密码不能为空",50,40);
            }
        };

        //焦点事件
        var inputClass = document.getElementsByClassName(this);
        inputEv(ainput,accountInput);
        inputEv(pinput,passwordInput);

        //返回按钮
        var back=document.createElement('div');
        back.className="back";
        back.addEventListener('mousedown',closeDialog);

        passwordInput.appendChild(pinput);
        passwordInput.appendChild(iconPassword);
        passwordInput.appendChild(iconEye);
        accountInput.appendChild(ainput);
        accountInput.appendChild(iconAccount);
        accountInput.appendChild(iconCha);
        normalDialog.appendChild(back);
        normalDialog.appendChild(h1);
        normalDialog.appendChild(accountInput);
        normalDialog.appendChild(passwordInput);
        normalDialog.appendChild(button);
    }else if (operate=="forget"){

        //标题
        var h1=document.createElement('H1');
        h1.className="loginH1";
        h1.innerText="找回密码";
        h1.style.top='10%';
        h1.style.left='10%';

        //账号输入盒子
        var accountInput = document.createElement('div');
        accountInput.className = "AccountBox";
        accountInput.style.top='30%';

        //图标
        var iconAccount = document.createElement('div');
        iconAccount.className = "icon-Account";

        //账号输入框
        var ainput = document.createElement('input');
        ainput.className = "AccountInput";
        ainput.placeholder = "请输入账号";


        //注册按钮
        var button=document.createElement('div');
        button.className="loginButton";
        button.innerText="确认";
        button.style.top="65%";


        //焦点事件
        var inputClass = document.getElementsByClassName(this);
        inputEv(ainput,accountInput);

        //返回按钮
        var back=document.createElement('div');
        back.className="back";
        back.addEventListener('mousedown',closeDialog);


        accountInput.appendChild(ainput);
        accountInput.appendChild(iconAccount);
        normalDialog.appendChild(back);
        normalDialog.appendChild(h1);
        normalDialog.appendChild(accountInput);
        normalDialog.appendChild(button);
    }

    document.body.appendChild(normalDialog);
    document.body.appendChild(newBackground);
}
//移除弹框
function closeDialog() {
    normalDialog.style.animation="break 0.2s";
    function removeDialog() {
        document.body.removeChild(normalDialog);
        document.body.removeChild(newBackground);
    }
    setTimeout(removeDialog,150);
    clearTimeout(removeDialog);
}

//监听弹框事件
window.addEventListener('mousedown',function (ev) {
    if (ev.target==newBackground){
        closeDialog();
    }
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

//密码显示隐藏
function HideOrVisit() {
     if (ishide){
         PasswordInput[0].type="password";
         iconEye[0].style.backgroundImage="url(images/eye-close.png)";
         ishide=false;
     } else {
         PasswordInput[0].type="text";
         iconEye[0].style.backgroundImage="url(images/eye.png)";
         ishide=true;
     }
}

//监听输入框
function inputChange() {
    if (AccountInput[0].value.length>0){
        cha[0].style.visibility="visible";
    } else {
        cha[0].style.visibility="hidden";
    }
}

//清除输入框内容
function clearInput() {
       AccountInput[0].value="";
       cha[0].style.visibility="hidden";
}

//登录
function submitLogin() {
    initCode();
        if (AccountInput[0].value.length==0){
            createDialog("账号不能为空!",70,40);
        } else if (PasswordInput[0].value.length==0){
            createDialog("密码不能为空!",70,40);
        } else if (!validCode()){
            createDialog("验证码错误!",70,40);
        }else {

        }
}