package Servlet;

import DAO.ManageDao;
import DAO.PersonalDao;
import DAOImp.ManageDaoImp;
import DAOImp.PersonalDaoImp;
import model.AccountInformation;
import model.Book;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/PersonalServlet")
public class PersonalServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //编码
        request.setCharacterEncoding("utf-8");
        //响应类型
        response.setContentType("text/html;charset=UTF-8");
        String op=new String(request.getParameter("op").getBytes("ISO8859-1"),
                "UTF-8");
        PrintWriter out=response.getWriter();
        PersonalDao personalDao=new PersonalDaoImp();
        HttpSession session=request.getSession();
        int uid=Integer.parseInt(session.getAttribute("uid").toString());
        if(op.equals("pInfo")){
            JSONObject obj =personalDao.querypInfoByUid(uid);
            out.print(obj);
        }
        else if (op.equals("updatePersonal")){
            String major=new String(request.getParameter("major"));
            String name=new String(request.getParameter("name"));
            String grade=new String(request.getParameter("grade"));
            personalDao.updatePersonal(major,name,grade,uid);
            out.print("修改成功!");
        }else if (op.equals("changePassword")){
            String oldPassword=new String(request.getParameter("oldPassword"));
            String newPassword=new String(request.getParameter("newPassword"));
            String isTrue=personalDao.queryPasswordByUid(uid,oldPassword);
            if (isTrue.equals("true")){
                personalDao.changePassword(uid,newPassword);
                out.print("修改成功!");
            }else {
                out.print("密码错误!");
            }
        }
    }
}
