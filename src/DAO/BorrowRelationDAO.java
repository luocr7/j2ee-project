package DAO;

import model.Book;
import model.BorrowRelation;
import net.sf.json.JSONArray;

import java.util.List;

public interface BorrowRelationDAO {
    public void InsertBorrowRelation(int uid,int bookid);
    public JSONArray QueryBookByUid(int uid);
    public void ReturnBook(int uid,int bookid);
}
