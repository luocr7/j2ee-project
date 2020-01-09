package DAO;

import model.Book;

public interface ManageDao {
    public Book QueryBookById(int id);
    public void UpdateBook(Book book);
    public void DeleteBook(int bookid);
    public void addBook(Book book);
}
