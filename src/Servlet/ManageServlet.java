package Servlet;

import DAO.ManageDao;
import DAOImp.ManageDaoImp;
import model.Book;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ManageServlet")
public class ManageServlet extends HttpServlet {
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
        ManageDao manageDao=new ManageDaoImp();
        if (op.equals("queryBook")){
            int id=Integer.parseInt(request.getParameter("id"));
            Book book=manageDao.QueryBookById(id);
            JSONObject bookJson=new JSONObject().fromObject(book);
            out.print(bookJson.toString());
        }else if (op.equals("updateBook")){
            Book book=new Book();
            int bookid=Integer.parseInt(request.getParameter("bookid"));
            String bookName=new String(request.getParameter("bookName"));
            Double mark=Double.parseDouble(request.getParameter("mark"));
            String peopleNum=new String(request.getParameter("peopleNumber"));
            String author=new String(request.getParameter("author"));
            book.setId(bookid);
            book.setAuthor(author);
            book.setPeopleNumber(peopleNum);
            book.setMark(mark);
            book.setBookName(bookName);
            manageDao.UpdateBook(book);
            out.print("更新成功!");
        }else if (op.equals("deleteBook")){
            int bookid=Integer.parseInt(request.getParameter("bookid"));
            manageDao.DeleteBook(bookid);
            out.print("删除成功!");
        }else if (op.equals("addBook")){
            Book book=new Book();
            String bookName=new String(request.getParameter("bookName"));
            Double mark=Double.parseDouble(request.getParameter("mark"));
            String peopleNum=new String(request.getParameter("peopleNumber"));
            String author=new String(request.getParameter("author"));
            int type=Integer.parseInt(request.getParameter("type"));
            String url=new String(request.getParameter("url"));
            book.setBookName(bookName);
            book.setMark(mark);
            book.setAuthor(author);
            book.setPeopleNumber(peopleNum);
            book.setType(type);
            book.setUrl(url);
            book.setIsBorrow("false");
            manageDao.addBook(book);
            out.print("添加成功!");
        }
    }
}
