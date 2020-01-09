package Servlet;


import DAO.AccountDao;
import DAOImp.AccountDaoImp;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException,IOException{
        //编码
        request.setCharacterEncoding("utf-8");
        //响应类型
        response.setContentType("text/html;charset=UTF-8");
        String userName=new String(request.getParameter("userName").getBytes("ISO8859-1"),
                "UTF-8");
        String passWord=new String(request.getParameter("passWord").getBytes("ISO8859-1"),
                "UTF-8");
        String isChecked=new String(request.getParameter("isChecked").getBytes("ISO8859-1"),
                "UTF-8");
        System.out.println(isChecked);

        Cookie getCookies[]=request.getCookies();

        PrintWriter out=response.getWriter();
        AccountDao accountDaoImp=new AccountDaoImp();
        String status=null;
        HashMap<String,Object> map=accountDaoImp.QueryIsUser(userName,passWord);
        if (accountDaoImp.QueryAccount(userName)){
            status="账号不存在!";
            out.print(status);
        }else if (map.get("isUser").equals("false")){
            status="密码错误!";
            out.print(status);
        }else {
            System.out.println(getCookies);
            if (getCookies==null&&isChecked.equals("true")) {
                //cookie
                Cookie account = new Cookie("Account", userName);
                Cookie password = new Cookie("passWord", passWord);
                //过期时间
                account.setMaxAge(60 * 60*24*99999);
                password.setMaxAge(60 * 60*24*99999);
                response.addCookie(account);
                response.addCookie(password);
            }
                String role = map.get("role").toString();
                int uid = Integer.parseInt(map.get("uid").toString());
                HttpSession session = request.getSession(true);
                session.setAttribute("role", role);
                session.setAttribute("uid", uid);
                session.setAttribute("accountnumber", map.get("accountnumber").toString());
                session.setAttribute("major", map.get("major").toString());
                session.setAttribute("name", map.get("name").toString());
                if (role.equals("user")) {
                    session.setAttribute("grade", map.get("grade").toString());
                }
            status="success";
            out.print(status);
        }
    }
}
