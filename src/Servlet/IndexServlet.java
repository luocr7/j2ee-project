package Servlet;

import DAO.BookDao;
import DAOImp.BookDaoImp;
import model.Book;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet("/IndexServlet")
public class IndexServlet extends HttpServlet {
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
        BookDao bookDao=new BookDaoImp();
        JSONArray map=new JSONArray();
        if (op.equals("QueryAll")){
            int page=Integer.parseInt(request.getParameter("page"));
             map=bookDao.QueryAllBook(page);
            out.print(map);
        } else if (op.equals("QueryType")){
            int page=Integer.parseInt(request.getParameter("page"));
            int type=Integer.parseInt(request.getParameter("type"));
            map=bookDao.QueryBookByType(type,page);
            out.print(map);
        }else if (op.equals("QueryBookName")){
            String bookName=new String(request.getParameter("bookName"));
            map=bookDao.QueryBookByBookName(bookName);
            out.print(map);
        }
    }
}
