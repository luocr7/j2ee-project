package Servlet;

import DAO.AccountDao;
import DAOImp.AccountDaoImp;
import model.AccountInformation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private String message;

    public void init() throws ServletException {
        message = null;
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException{
         doPost(request,response);
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,
            IOException{
        request.setCharacterEncoding("utf-8");
           response.setContentType("text/html;charset=UTF-8");
           String userName=new String(request.getParameter("userName").getBytes("ISO8859-1")
                   ,"UTF-8");
           String passWord=new String(request.getParameter("passWord").getBytes("ISO8859-1")
           ,"UTF-8");
           String name=new String(request.getParameter("name"));
           String major=new String(request.getParameter("major"));
           String grade=new String(request.getParameter("grade"));
           PrintWriter out=response.getWriter();
           AccountDao accountDaoImp=new AccountDaoImp();
           String status=null;
           if (accountDaoImp.QueryAccount(userName)){
               AccountInformation information=new AccountInformation();
               information.setAccountNumber(userName);
               information.setPassWord(passWord);
               information.setGrade(grade);
               information.setMajor(major);
               information.setName(name);
               information.setRole("user");
               accountDaoImp.InsertUser(information);
               status="注册成功!";
               out.println(status);
           }else {
               status="账号已存在!";
               System.out.println(status);
               out.print(status);
           }
    }
}
