package DAO;

import model.Book;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.HashMap;
import java.util.List;

public interface BookDao {
    public JSONArray QueryAllBook(int page);
    public JSONArray QueryBookByType(int type, int page);
    public JSONArray QueryBookByBookName(String bookName);
}
