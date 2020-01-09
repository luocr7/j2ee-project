package DAO;

import model.AccountInformation;
import model.Book;

import java.util.HashMap;
import java.util.List;

public interface AccountDao {
    public void InsertUser(AccountInformation accountInformation);
    public boolean QueryAccount(String userName);
    public HashMap<String,Object> QueryIsUser(String userName, String passWord);
}
