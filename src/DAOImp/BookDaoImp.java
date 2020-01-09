package DAOImp;

import DAO.BookDao;
import Utils.DBUtils;
import model.Book;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class BookDaoImp implements BookDao {
    @Override
    public JSONArray QueryAllBook(int page) {
        List<Book> bookList=new ArrayList<Book>();
        bookList=DBUtils.QueryAllBook(page);
        JSONArray map=JSONArray.fromObject(bookList);
        return map;
    }

    @Override
    public JSONArray QueryBookByType(int type, int page) {
        List<Book> bookList=new ArrayList<Book>();
        bookList=DBUtils.QueryBookByType(type,page);
        JSONArray map=JSONArray.fromObject(bookList);
        return map;
    }

    @Override
    public JSONArray QueryBookByBookName(String bookName) {
        List<Book> bookList=new ArrayList<Book>();
        bookList=DBUtils.QueryBookByBookName(bookName);
        JSONArray map=JSONArray.fromObject(bookList);
        return map;
    }

    /* public static void main(String args[]){
        BookDaoImp bookDaoImp=new BookDaoImp();
        System.out.println(bookDaoImp.QueryAllBook(2).getJSONObject(0).get("id"));
    }*/
}
