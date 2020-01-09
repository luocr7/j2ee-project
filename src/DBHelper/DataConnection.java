package DBHelper;

import java.sql.*;

public class DataConnection {
    private static final String url="jdbc:mysql://localhost:3306/student_system?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String user="root";
    private static final String password="chiCHI19970622";
    private static final Connection connection=null;

    public static Connection getConnection(){
        Connection connection=null;
        try {
           Class.forName("com.mysql.jdbc.Driver");
               connection = DriverManager.getConnection(url, user, password);
        }catch (SQLException se){
            se.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();;
        }
        return connection;
    }

    public static void close(ResultSet resultSet,PreparedStatement statement,Connection connection){
        closeConn(connection);
        closeRs(resultSet);
        closeSt(statement);
    }

    public static void closeConn(Connection connection){
        try{
            if (connection!=null){
                connection.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void closeRs(ResultSet resultSet){
        try {
            if (resultSet!=null){
                resultSet.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void closeSt(PreparedStatement statement){
        try {
            if (statement!=null){
                statement.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

   /* public static void main(String args[]){
        Connection connection=DataConnection.getConnection();
         PreparedStatement statement=null;
        try {
            statement = connection.prepareStatement("insert into accountinformation values ('201709000666'," +
                    "encode('luochi11'),)");

        }catch (Exception e){
            e.printStackTrace();
        }
    }*/
}
