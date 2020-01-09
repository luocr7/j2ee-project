package DAOImp;

import DAO.BorrowRelationDAO;
import model.Book;
import model.BorrowRelation;
import Utils.DBUtils;
import net.sf.json.JSON;
import net.sf.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

public class BorrowRelationImp implements BorrowRelationDAO {
    @Override
    public void InsertBorrowRelation(int uid,int bookid) {
        BorrowRelation borrowRelation=new BorrowRelation();
        borrowRelation.setBookid(bookid);
        borrowRelation.setUid(uid);
        DBUtils.InsertBorrowRelation(borrowRelation);
    }

    @Override
    public JSONArray QueryBookByUid(int uid) {
        List<Book> bookList=DBUtils.QueryBookByUid(uid);
        JSONArray map= JSONArray.fromObject(bookList);
        return map;
    }

    @Override
    public void ReturnBook(int uid, int bookid) {
        DBUtils.ReturnBook(uid,bookid);
    }
}
