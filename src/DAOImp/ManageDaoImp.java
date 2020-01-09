package DAOImp;

import DAO.ManageDao;
import Utils.DBUtils;
import model.Book;

public class ManageDaoImp implements ManageDao {
    @Override
    public Book QueryBookById(int id) {
        return DBUtils.QueryBookById(id);
    }

    @Override
    public void UpdateBook(Book book) {
        DBUtils.UpdateBook(book);
    }

    @Override
    public void DeleteBook(int bookid) {
          DBUtils.DeleteBook(bookid);
    }

    @Override
    public void addBook(Book book) {
        DBUtils.addBook(book);
    }
}
