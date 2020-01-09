package Servlet;

import DAO.BookDao;
import DAO.BorrowRelationDAO;
import DAOImp.BookDaoImp;
import DAOImp.BorrowRelationImp;
import model.Book;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BorrowServlet")
public class BorrowServlet extends HttpServlet {
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
        BorrowRelationDAO borrowRelation=new BorrowRelationImp();
        int uid=Integer.parseInt(request.getParameter("uid"));
        if (op.equals("borrow")){
            int bookid=Integer.parseInt(request.getParameter("bookid"));
            borrowRelation.InsertBorrowRelation(uid,bookid);
            out.print("预定成功!");
        }else if (op.equals("queryBorrow")){
            List<Book> bookList=new ArrayList<>();
            bookList=borrowRelation.QueryBookByUid(uid);
            out.print(bookList);
        }else if (op.equals("returnBook")){
            int bookid=Integer.parseInt(request.getParameter("bookid"));
            borrowRelation.ReturnBook(uid,bookid);
            out.print("取消成功!");
        }
    }
}
