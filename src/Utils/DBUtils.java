package Utils;

import DBHelper.DataConnection;
import DBHelper.JDBCUtil;
import com.mchange.v2.c3p0.impl.DbAuth;
import model.AccountInformation;
import model.Book;
import model.BorrowRelation;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class DBUtils {
    private static Connection connection=null;
    private static PreparedStatement statement=null;
    private static ResultSet resultSet=null;

    //插入用户账号密码
    public static void Insert(AccountInformation information){
        String sql="insert into accountinformation values(?,?,?,?,?,?,?)";
        try {
            connection= DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setString(1,information.getAccountNumber());
            statement.setString(2,information.getPassWord());
            statement.setInt(3,information.getUid());
            statement.setString(4,information.getRole());
            statement.setString(5,information.getMajor());
            statement.setString(6,information.getName());
            statement.setString(7,information.getGrade());
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
    }

    //查询是否存在账号
    public static boolean QueryAccount(String userName){
        String sql="select uid from accountinformation where accountnumber=?";
        int ct=0;
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setString(1,userName);
            resultSet=statement.executeQuery();
            while(resultSet.next()) {
                ct = resultSet.getInt("uid");
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
            if (ct==0){
                return true;
            }else {
                return false;
            }
        }
    }

    //查询密码是否正确
    public static HashMap<String,Object> QueryIsUser(String userName,String passWord){
         String sql="select * from accountinformation where accountnumber=?";
         String Qpassword=null;
         String role=null;
         int uid=0;
         String accountnumber=null;
         String major=null;
         String name=null;
         String grade=null;
         HashMap<String,Object> map=new HashMap<String,Object>();
         try {
             connection=DataConnection.getConnection();
             statement=connection.prepareStatement(sql);
             statement.setString(1,userName);
             resultSet=statement.executeQuery();
             while (resultSet.next()){
                 Qpassword=resultSet.getString("password");
                 role=resultSet.getString("role");
                 uid=resultSet.getInt("uid");
                 accountnumber=resultSet.getString("accountnumber");
                 major=resultSet.getString("major");
                 name=resultSet.getString("name");
                 grade=resultSet.getString("grade");
             }
         }catch (SQLException e){
             e.printStackTrace();
         }finally {
             DataConnection.close(resultSet,statement,connection);
             if (passWord.equals(Qpassword)){
                 map.put("isUser","true");
                 map.put("role",role);
                 map.put("uid",uid);
                 map.put("accountnumber",accountnumber);
                 map.put("major",major);
                 map.put("name",name);
                 map.put("grade",grade);
                 return map;
             }else {
                 map.put("isUser","false");
                 return map;
             }
         }
    }

    //分页查询所有书籍
    public static List<Book> QueryAllBook(int page){
        String sql="select * from book_list order by isBorrow desc,mark asc limit ?,10";
        List<Book> bookList=new ArrayList<Book>();
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,(page-1)*10);
            resultSet=statement.executeQuery();
            int i=0;
            while (resultSet.next()){
                Book book=new Book();
                book.setId(resultSet.getInt("id"));
                book.setBookName(resultSet.getString("bookName"));
                book.setMark(resultSet.getDouble("mark"));
                book.setPeopleNumber(resultSet.getString("peopleNumber"));
                book.setAuthor(resultSet.getString("author"));
                book.setType(resultSet.getInt("type"));
                book.setUrl(resultSet.getString("url"));
                book.setIsBorrow(resultSet.getString("isBorrow"));
                bookList.add(i,book);
                i++;
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        return bookList;
    }

    //分页分类查询
    public static List<Book> QueryBookByType(int type,int page){
        String sql="select * from book_list where type=? order by isBorrow desc,mark asc limit ?,10";
        List<Book> bookList=new ArrayList<Book>();
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,type);
            statement.setInt(2,(page-1)*10);
            resultSet=statement.executeQuery();
            int i=0;
            while (resultSet.next()){
                Book book=new Book();
                book.setId(resultSet.getInt("id"));
                book.setBookName(resultSet.getString("bookName"));
                book.setMark(resultSet.getDouble("mark"));
                book.setPeopleNumber(resultSet.getString("peopleNumber"));
                book.setAuthor(resultSet.getString("author"));
                book.setType(resultSet.getInt("type"));
                book.setUrl(resultSet.getString("url"));
                book.setIsBorrow(resultSet.getString("isBorrow"));
                bookList.add(i,book);
                i++;
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        return bookList;
    }

    //按书名查询
    public static List<Book> QueryBookByBookName(String bookName){
        String sql="select * from book_list where bookName like ?";
        List<Book> bookList=new ArrayList<Book>();
        try {
             connection=DataConnection.getConnection();
             statement=connection.prepareStatement(sql);
             statement.setString(1,"%"+bookName+"%");
             resultSet=statement.executeQuery();
             int i=0;
             while (resultSet.next()){
                 Book book=new Book();
                 book.setId(resultSet.getInt("id"));
                 book.setBookName(resultSet.getString("bookName"));
                 book.setMark(resultSet.getDouble("mark"));
                 book.setPeopleNumber(resultSet.getString("peopleNumber"));
                 book.setAuthor(resultSet.getString("author"));
                 book.setType(resultSet.getInt("type"));
                 book.setUrl(resultSet.getString("url"));
                 book.setIsBorrow(resultSet.getString("isBorrow"));
                 bookList.add(i,book);
                 i++;
             }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        return bookList;
    }

    //插入借阅关系
    public static void InsertBorrowRelation(BorrowRelation bookRelation){
         String sql="insert into borrowrelation values(?,?,?)";
         try {
             connection=DataConnection.getConnection();
             statement=connection.prepareStatement(sql);
             statement.setInt(1,bookRelation.getUid());
             statement.setInt(2,bookRelation.getBookid());
             statement.setInt(3,bookRelation.getId());
             statement.executeUpdate();
         }catch (Exception e){
             e.printStackTrace();
         }finally {
             DataConnection.close(resultSet,statement,connection);
         }
        UpdateBorrowStatus(bookRelation.getBookid(),"true");
    }

    //更新借书状态
    public static void UpdateBorrowStatus(int bookid,String status){
        String sql="update book_list set isBorrow=? where id=?";
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setString(1,status);
            statement.setInt(2,bookid);
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
    }

    //通过uid查询书籍信息
    public static List<Book> QueryBookByUid(int uid){
        String sql="select * from book_list,borrowrelation where borrowrelation.uid=? and " +
                "borrowrelation.bookid=book_list.id";
        List<Book> bList=new ArrayList<Book>();
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
                statement.setInt(1,uid);
                resultSet=statement.executeQuery();
                int i=0;
                while (resultSet.next()) {
                    Book book = new Book();
                    book.setId(resultSet.getInt("id"));
                    book.setBookName(resultSet.getString("bookName"));
                    book.setMark(resultSet.getDouble("mark"));
                    book.setPeopleNumber(resultSet.getString("peopleNumber"));
                    book.setAuthor(resultSet.getString("author"));
                    book.setType(resultSet.getInt("type"));
                    book.setUrl(resultSet.getString("url"));
                    book.setIsBorrow(resultSet.getString("isBorrow"));
                    bList.add(i, book);
                    i++;
                }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        return bList;
    }

    //通过uid，bookid还书
    public static void ReturnBook(int uid,int bookid){
        String sql="delete from borrowrelation where uid=? and bookid=?";
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,uid);
            statement.setInt(2,bookid);
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        DBUtils.UpdateBorrowStatus(bookid,"false");
    }

    //通过图书编号查询图书信息
    public static Book QueryBookById(int id){
        String sql="select * from book_list where id=?";
        Book book=new Book();
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,id);
            resultSet=statement.executeQuery();
            while (resultSet.next()){
                book.setId(resultSet.getInt("id"));
                book.setBookName(resultSet.getString("bookName"));
                book.setMark(resultSet.getDouble("mark"));
                book.setPeopleNumber(resultSet.getString("peopleNumber"));
                book.setAuthor(resultSet.getString("author"));
                book.setType(resultSet.getInt("type"));
                book.setUrl(resultSet.getString("url"));
                book.setIsBorrow(resultSet.getString("isBorrow"));
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        return book;
    }

    //更新图书数据
    public static void UpdateBook(Book book){
        String sql="update book_list set bookName=?,mark=?,peopleNumber=?,author=? where id=?";
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setString(1,book.getBookName());
            statement.setDouble(2,book.getMark());
            statement.setString(3,book.getPeopleNumber());
            statement.setString(4,book.getAuthor());
            statement.setInt(5,book.getId());
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
    }

    //删除图书
    public static void DeleteBook(int bookid){
        String sql="delete from book_list where id=?";
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,bookid);
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
    }

    //添加图书
    public static void addBook(Book book){
        String sql="insert into book_list values(?,?,?,?,?,?,?,?)";
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,book.getId());
            statement.setString(2,book.getBookName());
            statement.setDouble(3,book.getMark());
            statement.setString(4,book.getPeopleNumber());
            statement.setString(5,book.getAuthor());
            statement.setInt(6,book.getType());
            statement.setString(7,book.getUrl());
            statement.setString(8,book.getIsBorrow());
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
    }

    //修改个人信息
    public static void updatePersonal(String major,String name,String grade,int uid){
        String sql="update accountinformation set major=?,name=?,grade=? where uid=?";
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setString(1,major);
            statement.setString(2,name);
            statement.setString(3,grade);
            statement.setInt(4,uid);
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
    }

    //修改密码
    public static void changePassword(int uid,String password){
        String sql="update accountinformation set password=? where uid=?";
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setString(1,password);
            statement.setInt(2,uid);
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
    }

    //通过uid查询密码
    public static String queryPasswordByUid(int uid,String password){
        String sql="select password from accountinformation where uid=?";
        String Qpassword=null;
        try{
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,uid);
            resultSet=statement.executeQuery();
            while (resultSet.next()){
                Qpassword=resultSet.getString("password");
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        if (Qpassword.equals(password)){
            return "true";
        }else {
            return "false";
        }
    }

    //通过uid查询个人信息
    public static AccountInformation querypInfoByUid(int uid){
        String sql="select * from accountinformation where uid=?";
        AccountInformation information=new AccountInformation();
        try {
            connection=DataConnection.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setInt(1,uid);
            resultSet=statement.executeQuery();
            while (resultSet.next()){
                information.setAccountNumber(resultSet.getString("accountnumber"));
                information.setGrade(resultSet.getString("grade"));
                information.setMajor(resultSet.getString("major"));
                information.setName(resultSet.getString("name"));
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DataConnection.close(resultSet,statement,connection);
        }
        return information;
    }




   /* public static void test(int i,int j,int k){
        String sql="update book_list set url=? where id=?";
        try{
            connection=JDBCUtil.getConnection();
            statement=connection.prepareStatement(sql);
            statement.setString(1,"images/pic/"+k+"/"+"pic"+j+".jpg");
            statement.setInt(2,i);
            statement.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtil.close(null,statement,connection);
        }
    }*/


//   public static void main(String args[]) {
//       System.out.println(DBUtils.querypInfoByUid(1).getName());
//   }
}
