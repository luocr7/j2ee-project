package DAOImp;

import DAO.AccountDao;
import DBHelper.DataConnection;
import Utils.DBUtils;
import model.AccountInformation;
import model.Book;

import java.util.HashMap;
import java.util.List;

public class AccountDaoImp implements AccountDao {
    private AccountInformation information=new AccountInformation();
    @Override
    public void InsertUser(AccountInformation accountInformation) {
        DBUtils.Insert(accountInformation);
    }

    @Override
    public  boolean QueryAccount(String userName) {
        return DBUtils.QueryAccount(userName);
    }

    @Override
    public HashMap<String, Object> QueryIsUser(String userName, String passWord){
        return DBUtils.QueryIsUser(userName,passWord);
    }


    /*public static  void main(String args[]){
        AccountDaoImp accountDaoImp=new AccountDaoImp();
        accountDaoImp.InsertUser("afe","age");
    }*/
}
